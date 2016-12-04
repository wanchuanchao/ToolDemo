//
//  SocketHelper.m
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超 All rights reserved.
//

#import "SocketHelper.h"
#import "GCDAsyncSocket.h"

typedef NS_ENUM(long, ReadTagType){
    //读取数据的类型
    ReadTagTypehead = 1,// 报头
    ReadTagTypebody = 2 // 主体 6
};

@interface SocketHelper ()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *_socket;
}
@end
@implementation SocketHelper
+ (instancetype)SharedSocket{
    static SocketHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[SocketHelper alloc] init];
    });
    return helper;
}
- (instancetype)init{
    if ([super init]) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError *error = nil;
        if (![_socket connectToHost:WWW_HOST onPort:DefalutPORT withTimeout:50.0f error:&error]){
             MLog(@"Unable to connect to due to invalid configuration: %@", error);
            }else{
             MLog(@"Connecting to \"%@\" on port %d...", WWW_HOST, DefalutPORT);
            }
        }
    return self;
}
- (BOOL)connectToHost:(NSString *)host
               onPort:(uint16_t)port
          withTimeout:(NSTimeInterval)timeout
                error:(NSError **)errPtr{
    return [_socket connectToHost:host onPort:port withTimeout:timeout error:errPtr];
}
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag{
    [_socket readDataWithTimeout:timeout tag:tag];
}
- (void)writeData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag{
    [_socket writeData:data withTimeout:timeout tag:tag];
}
- (void)disconnect{
    _socket.delegate = nil;
    [_socket disconnect];
}
#pragma mark GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket*)sock didConnectToHost:(NSString*)host port:(UInt16)port{
    [self.delegate socket:sock didConnectToHost:host port:port];
}
- (void)socket:(GCDAsyncSocket*)sock didReadData:(NSData*)data withTag:(long)tag{
    [self.delegate socket:sock didReadData:data withTag:tag];
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [self.delegate socket:sock didWriteDataWithTag:tag];
}
- (void)socketDidDisconnect:(GCDAsyncSocket*)sock withError:(NSError*)err{
    [self.delegate socketDidDisconnect:sock withError:err];
}
@end
