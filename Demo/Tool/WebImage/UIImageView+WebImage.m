//
//  UIImageView+WebImage.m
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超 All rights reserved.
//

#import "UIImageView+WebImage.h"

@implementation UIImageView (WebImage)
- (void)downloadImage:(NSString *)url
                place:(UIImage *)place{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

- (void)downloadImage:(NSString *)url place:(UIImage *)place success:(DownloadSuccessBlock)success failure:(DownloadFailureBlock)failure received:(DownloadProgressBlock)progress{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageRetryFailed | SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progress((float)receivedSize/expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            failure(error);
        }else{
            // image是下载好的图片
            self.image = image;
            success(cacheType, image);
        }
    }];
}

@end
