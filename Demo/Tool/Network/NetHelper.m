//
//  NetHelper.m
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超. All rights reserved.
//

#import "NetHelper.h"
#import "AFNetworking.h"
@implementation NetHelper
static NSMutableArray *urlArr;

+ (void)request:(NSString *)URLString httpMethod:(NSString *)method parameters:(id)parameters progress:(void (^)(id downloadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    //    判断是否用户重复请求
    if (!urlArr) {
        urlArr = [NSMutableArray array];
    }
    for (NSString *url in urlArr) {
        if ([URLString isEqualToString:url]) {
            NSError *error = [NSError errorWithDomain:@"重复请求" code:REQUEST_REPEATMORE userInfo:nil];
            failure(error);
            return;
        }
    }
    [urlArr addObject:URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([method isEqualToString:@"GET"]){
        [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            progress(downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
            [urlArr removeObject:URLString];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
            [urlArr removeObject:URLString];
        }];
    }else if ([method isEqualToString:@"POST"]){
        [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            progress(uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
            [urlArr removeObject:URLString];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
            [urlArr removeObject:URLString];
        }];
    }
}
+ (void)startWithAPPDelegate{
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
}

@end
