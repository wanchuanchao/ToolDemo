//
//  LocationManager.m
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超 All rights reserved.
//

#import "LocationManager.h"

/*
 在Info.plist文件中添加如下配置：
 （1）NSLocationAlwaysUsageDescription
 （2）NSLocationWhenInUseUsageDescription
 */
@interface LocationManager ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locManager;
}
@end
@implementation LocationManager
+ (instancetype)SharedManager{
    static LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocationManager alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _locManager = [[CLLocationManager alloc] init];
        _locManager.distanceFilter = 100;
        _locManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locManager.delegate = self;
        if (IOS_VERSION >= 8) {
            [_locManager requestWhenInUseAuthorization];
        }
        [_locManager startUpdatingLocation];
    }
    return self;
}
- (void)startUpdatingLocation{
    [_locManager startUpdatingLocation];
}
- (void)stopUpdatingLocation{
    [_locManager stopUpdatingLocation];
}
#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    [self.delegate locationManager:manager didUpdateToLocation:newLocation fromLocation:oldLocation];
    //当前的经度
    NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%g",
                                 newLocation.coordinate.latitude];
    //当前的纬度
    NSString *currentLongitude = [[NSString alloc] initWithFormat:@"%g",newLocation.coordinate.longitude];
    //当前的水平距离
    NSString *currentHorizontalAccuracy =[[NSString alloc] initWithFormat:@"%g",newLocation.horizontalAccuracy];
    NSString *currentAltitude = [[NSString alloc] initWithFormat:@"%g",newLocation.altitude];
    NSString *currentVerticalAccuracy =[[NSString alloc] initWithFormat:@"%g",newLocation.verticalAccuracy];
//    if (startLocation == nil)startLocation = newLocation;
//    CLLocationDistance distanceBetween = [newLocation distanceFromLocation:startLocation];
//    NSString *tripString = [[NSString alloc] initWithFormat:@"%f",distanceBetween];
    //定位城市通过CLGeocoder
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString *test = [placemark locality];
            MLog(@"%@", test);
        }
    }];
}
@end
