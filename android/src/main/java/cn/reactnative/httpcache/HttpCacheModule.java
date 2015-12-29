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
            callback.invoke(null, cache != null ? cache.getSize() : 0);
        } catch(IOException e){
            callback.invoke(e.getMessage());
        }
    }

    @ReactMethod
    public void getImageCacheSize(Callback callback){
        DiskStorageCache cache = ImagePipelineFactory.getInstance().getMainDiskStorageCache();
        callback.invoke(null, cache.getSize());
    }

    @ReactMethod
    public void clearImageCache(Callback callback){
        DiskStorageCache cache = ImagePipelineFactory.getInstance().getMainDiskStorageCache();
        cache.clearAll();
        callback.invoke();
    }
}
