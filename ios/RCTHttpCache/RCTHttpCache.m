//
//  RCTHttpCache.m
//  RCTHttpCache
//
//  Created by LvBingru on 12/30/15.
//  Copyright © 2015 erica. All rights reserved.
//

#import "RCTHttpCache.h"
#import "React/RCTImageLoader.h"
#import "RCTImageCache.h"
#import "React/RCTBridge.h"

@implementation RCTHttpCache

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(HttpCache);

RCT_EXPORT_METHOD(getHttpCacheSize:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    resolve(@([httpCache currentDiskUsage]));
}

RCT_EXPORT_METHOD(clearCache:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    [httpCache removeAllCachedResponses];
    resolve(nil);
}


RCT_EXPORT_METHOD(getImageCacheSize:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    resolve(@0);
}

RCT_EXPORT_METHOD(clearImageCache:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    resolve(nil);
}


@end
