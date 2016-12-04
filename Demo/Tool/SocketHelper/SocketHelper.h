//
//  SocketHelper.h
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
@protocol MSocketDelegate <NSObject>
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag;
- (void)socketDidDisconnect:(GCDAsyncSocket*)sock withError:(NSError*)err;
- (void)socket:(GCDAsyncSocket*)sock didReadData:(NSData*)data withTag:(long)tag;
- (void)socket:(GCDAsyncSocket*)sock didConnectToHost:(NSString*)host port:(UInt16)port;
@end
@interface SocketHelper : NSObject
@property (nonatomic,weak) id<MSocketDelegate> delegate;
+ (instancetype)SharedSocket;
- (BOOL)connectToHost:(NSString *)host
               onPort:(uint16_t)port
          withTimeout:(NSTimeInterval)timeout
                error:(NSError **)errPtr;
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag;
- (void)writeData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag;
- (void)disconnect;
@end
