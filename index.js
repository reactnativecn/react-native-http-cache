/**
 * Created by tdzl2_000 on 2015-12-29.
 */
import { NativeModules } from 'react-native';
const native = NativeModules.HttpCache;

export const clearHttpCache = native.clearCache;

export const getHttpCacheSize = native.getHttpCacheSize;

export const clearImageCache = native.clearImageCache;

export const getImageCacheSize = native.getImageCacheSize;

export async function getCacheSize(){
  const arr = await Promise.all([getHttpCacheSize(), getImageCacheSize()]);

  console.log(arr.join(','));
  // Get sum of all cache type.
  return arr.reduce((a,b)=>a+b, 0);
}

export async function clearCache(){
  await Promise.all([clearHttpCache(), clearImageCache()]);
}
