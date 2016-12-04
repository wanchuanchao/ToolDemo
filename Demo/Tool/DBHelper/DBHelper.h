//
//  DBHelper.h
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHelper : NSObject
+ (instancetype)SharedInstance;

- (void)updateDBVersion;
@end
