//
//  APIConfig.h
//  sssDemio
//
//  Created by 米环 on 2016/11/26.
//  Copyright © 2016年 啦啦啦啦啦. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface APIConfig : NSObject
#pragma mark 网络编程
//无网络code
#define REQUEST_REPEATMORE (2333)
//默认的端口号,网址
#define DefalutPORT 666
#define WWW_HOST @""
//信息服务器地址
#define SERVER_HOST @""
//图片服务器地址
#define IMAGE_HOST @""
//启动广告
//http://www.jianshu.com/p/6dc2713bf8d1


#pragma mark  数据库
//数据库
#define DB_NAME @"userDatabase.sqlite"
//表名
#define DB_TABLEANAME_USER @"user"
@end
