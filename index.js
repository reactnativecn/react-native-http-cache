/**
 * Created by tdzl2_000 on 2015-12-29.
 */
import { NativeModules } from 'react-native';
import promisify from 'es6-promisify';

const native = NativeModules.HttpCache;

// Used only with promisify. Transform callback to promise result.
function translateError(err, result) {
  if (!err) {
    return this.resolve(result);
  }
  if (typeof err === 'object') {
    if (err instanceof Error) {
      return this.reject(ret);
    }
    const {message, ...other} = err;
    return this.reject(Object.assign(new Error(err.message), other));
  } else if (typeof err === 'string') {
    return this.reject(new Error(err));
  }
  this.reject(Object.assign(new Error(), { origin: err }));
}

function wrapApi(nativeFunc, argCount) {
  if (!nativeFunc) {
    return undefined;
  }
  const promisified = promisify(nativeFunc, translateError);
  if (argCount != undefined){
    return (...args) => {
      let _args = args;
      if (_args.length < argCount) {
        _args[argCount - 1] = undefined;
      } else if (_args.length > argCount){
        _args = _args.slice(0, args);
      }
      return promisified(..._args);
    };
  } else {
    return () => {
      return promisified();
    };
  }
}
const clearHttpCache = wrapApi(native.clearCache);
const getHttpCacheSize = wrapApi(native.getHttpCacheSize);
const clearImageCache = wrapApi(native.clearImageCache);
const getImageCacheSize = wrapApi(native.getImageCacheSize);
async function getSize(){
  const arr = await Promise.all([getHttpCacheSize(), getImageCacheSize()]);
  // Get sum of all cache type.
  return arr.reduce((a,b)=>a+b, 0);
}
async function clear(){
  await Promise.all([clearHttpCache(), clearImageCache()]);
}

export default {
  clearImageCache,
  getImageCacheSize,
  clearHttpCache,
  getHttpCacheSize,
  getSize,
  clear,
}