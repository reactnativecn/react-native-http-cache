React Native http cache control for both fetch/XMLHttpRequest and ImageView

- [x] iOS
- [x] Android

## Installation

```sh
$ npm install react-native-http-cache --save
```

## iOS: Linking in your XCode project

- Link `react-native-http-cache` library from your `node_modules/react-native-http-cache/ios` folder like its
  [described here](http://facebook.github.io/react-native/docs/linking-libraries-ios.html).
  Don't forget to add it to "Build Phases" of project.

## Android: Linking to your gradle Project

- Add following lines into `android/settings.gradle`

```
include ':RCTHttpCache'
project(':RCTHttpCache').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-http-cache/android')
```

- Add following lines into your `android/app/build.gradle` in section `dependencies`

```
...
dependencies {
   ...
   compile project(':RCTHttpCache')    // Add this line only.
}
```

- Add following lines into `MainActivity.java`

```java
...
import cn.reactnative.httpcache.HttpCachePackage;
      // Add this line before public class MainActivity

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        ...
        mReactInstanceManager = ReactInstanceManager.builder()
            .setApplication(getApplication())
            .setBundleAssetName("index.android.bundle")
            .setJSMainModuleName("index.android")
            .addPackage(new MainReactPackage())
            .addPackage(new HttpCachePackage())        // Add this line
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build();
    }
}
```

- Add these lines to 'proguard-rules.pro' if you need to minify your java code:

```
-keep class com.facebook.cache.disk.DiskStorageCache {
   private boolean maybeUpdateFileCacheSize();
}
```

## JavaScript: import all and invoke!

```js
import * as CacheManager from 'react-native-http-cache';

// invoke API directly when in need
CacheManager.clear();

```

## API Documentation

#### clear()

Clear cache for all type.

Return a promise which indicate the clear state.

#### getSize()

Get cache size for all type.

Return a promise that contain the cache size(in bytes).

#### clearHttpCache()

Clear cache for fetch/ajax only.

Return a promise which indicate the clear state.

#### getHttpCacheSize()

Get cache size for fetch/ajax only.

Return a promise that contain the cache size(in bytes).

#### clearImageCache()

Clear cache for ImageView only.

Return a promise which indicate the clear state.

#### getImageCacheSize()

Get cache size for ImageView only.

Return a promise that contain the cache size(in bytes).

## Authors

- [Deng Yun](https://github.com/tdzl2003) from [React-Native-CN](https://github.com/reactnativecn)
- [Lv Bingru](https://github.com/lvbingru) from [React-Native-CN](https://github.com/reactnativecn)
