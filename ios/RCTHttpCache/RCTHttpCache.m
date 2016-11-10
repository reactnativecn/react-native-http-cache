//
//  RCTHttpCache.m
//  RCTHttpCache
//
//  Created by LvBingru on 12/30/15.
//  Copyright © 2015 erica. All rights reserved.
//

#import "RCTHttpCache.h"
#import "RCTBridge.h"

@implementation RCTHttpCache

//@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(HttpCache);

RCT_REMAP_METHOD(existsInCache,
                 url:(NSString *)url
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
  NSURLCache *httpCache = [NSURLCache sharedURLCache];
  
  NSCachedURLResponse *response = [httpCache cachedResponseForRequest: request];
  BOOL inCache = response != nil;
  
  resolve(@(inCache));
}


RCT_REMAP_METHOD(getHttpCacheSize,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    resolve(@([httpCache currentDiskUsage]));
}

RCT_REMAP_METHOD(clearCache,
                 resolverz:(RCTPromiseResolveBlock)resolve
                 rejecterz:(RCTPromiseRejectBlock)reject)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    [httpCache removeAllCachedResponses];
    resolve(@[[NSNull null]]);
}

@end
