//
//  NetHelper.h
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetHelper : NSObject
+ (void)request:(NSString *)URLString httpMethod:(NSString *)method parameters:(id)parameters progress:(void (^)(id downloadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)startWithAPPDelegate;
@end
