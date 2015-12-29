package cn.reactnative.httpcache;

import android.content.Intent;

import com.facebook.cache.disk.DiskStorageCache;
import com.facebook.drawee.backends.pipeline.Fresco;
import com.facebook.imagepipeline.core.ImagePipelineFactory;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.modules.network.OkHttpClientProvider;
import com.squareup.okhttp.Cache;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;

/**
 * Created by tdzl2_000 on 2015-10-10.
 */
public class HttpCacheModule extends ReactContextBaseJavaModule {
    public HttpCacheModule(ReactApplicationContext context) {
        super(context);
    }

    @Override
    public String getName() {
        return "RCTHttpCache";
    }

    @ReactMethod
    public void clearCache(Callback callback){
        try {
            Cache cache = OkHttpClientProvider.getOkHttpClient().getCache();
            if (cache != null) {
                cache.delete();
            }
            callback.invoke();
        } catch(IOException e){
            callback.invoke(e.getMessage());
        }
    }

    @ReactMethod
    public void getHttpCacheSize(Callback callback){
        try {
            Cache cache = OkHttpClientProvider.getOkHttpClient().getCache();
            callback.invoke(null, cache != null ? ((double)cache.getSize()) : 0);
        } catch(IOException e){
            callback.invoke(e.getMessage());
        }
    }

    static Method update;
    private void updateCacheSize(DiskStorageCache cache) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        if (update == null){
            update = DiskStorageCache.class.getDeclaredMethod("maybeUpdateFileCacheSize");
            update.setAccessible(true);
        }
        update.invoke(cache);
    }

    @ReactMethod
    public void getImageCacheSize(Callback callback){
        DiskStorageCache cache1 = ImagePipelineFactory.getInstance().getMainDiskStorageCache();
        long size1 = cache1.getSize();
        if (size1 < 0){
            try {
                updateCacheSize(cache1);
            } catch (Exception e){
                callback.invoke(e.getMessage());
                return;
            }
            size1 = cache1.getSize();
        }
        DiskStorageCache cache2 = ImagePipelineFactory.getInstance().getSmallImageDiskStorageCache();
        long size2 = cache2.getSize();
        if (size2 < 0){
            try {
                updateCacheSize(cache2);
            } catch (Exception e){
                callback.invoke(e.getMessage());
                return;
            }
            size2 = cache2.getSize();
        }
        callback.invoke(null, ((double)(size1+size2)));
    }

    @ReactMethod
    public void clearImageCache(Callback callback){
        DiskStorageCache cache1 = ImagePipelineFactory.getInstance().getMainDiskStorageCache();
        cache1.clearAll();
        DiskStorageCache cache2 = ImagePipelineFactory.getInstance().getSmallImageDiskStorageCache();
        cache2.clearAll();
        callback.invoke();
    }
}
