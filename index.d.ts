declare module "react-native-http-cache" {
    export function clearHttpCache(): Promise<void>;
    export function getHttpCacheSize(): Promise<number>;
    export function clearImageCache(): Promise<void>;
    export function getImageCacheSize(): Promise<number>;
    export function getCacheSize(): Promise<number>;
    export function clearCache(): Promise<void>;
}
