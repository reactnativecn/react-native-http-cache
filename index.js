import { NativeModules } from 'react-native';

const native = NativeModules.HttpCache;

export const clearCache = native.clearCache;
export const getCacheSize = native.getHttpCacheSize;
export const existsInCache = native.existsInCache;

