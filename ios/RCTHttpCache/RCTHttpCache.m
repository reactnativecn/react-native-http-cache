//
//  RCTHttpCache.m
//  RCTHttpCache
//
//  Created by LvBingru on 12/30/15.
//  Copyright © 2015 erica. All rights reserved.
//

#import "RCTHttpCache.h"
#import "RCTImageLoader.h"
#import "RCTBridge.h"

@implementation RCTHttpCache

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(HttpCache);

RCT_EXPORT_METHOD(getHttpCacheSize:(RCTResponseSenderBlock)resolve)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    resolve(@[[NSNull null], @([httpCache currentDiskUsage])]);
}

RCT_EXPORT_METHOD(clearCache:(RCTResponseSenderBlock)resolve)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    [httpCache removeAllCachedResponses];
    resolve(@[[NSNull null]]);
}


RCT_EXPORT_METHOD(getImageCacheSize:(RCTResponseSenderBlock)resolve)
{
    NSURLCache *imageCache = [self imageCache];
    dispatch_queue_t queue = [self imageCacheQueue];
    if (imageCache == nil || queue == nil) {
        resolve(@[@"cache not found"]);
    }
    dispatch_async(queue, ^{
        resolve(@[[NSNull null], @([imageCache currentDiskUsage])]);
    });
}

RCT_EXPORT_METHOD(clearImageCache:(RCTResponseSenderBlock)resolve)
{
    NSURLCache *imageCache = [self imageCache];
    dispatch_queue_t queue = [self imageCacheQueue];
 
    if (imageCache == nil || queue == nil) {
        resolve(@[@"cache not found"]);
    }

    dispatch_async(queue, ^{
        [imageCache removeAllCachedResponses];
        resolve(@[[NSNull null]]);
    });
}

- (NSURLCache *)imageCache
{
    RCTImageLoader* loader = _bridge.imageLoader;
    NSURLCache *cache = [loader valueForKey:@"_URLCache"];
    
//        Ivar ivar = class_getInstanceVariable([RCTImageLoader class], [@"_URLCache" UTF8String]);
//        NSURLCache *cache = object_getIvar(loader, ivar);
//        NSLog(@"%@",cache);
//        NSLog(@"%@",[loader valueForKey:@"_URLCache"]);
    return cache;
}

- (dispatch_queue_t)imageCacheQueue
{
    RCTImageLoader* loader = _bridge.imageLoader;
    dispatch_queue_t queue = [loader valueForKey:@"_URLCacheQueue"];
    return queue;
}


@end
