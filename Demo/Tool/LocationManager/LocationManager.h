//
//  LocationManager.h
//  Demo
//
//  Created by 万传超 on 2016/12/4.
//  Copyright © 2016年 万传超 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol MLocationManagerDelegate <NSObject>

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

@end
@interface LocationManager : NSObject
@property (nonatomic,weak)id<MLocationManagerDelegate> delegate;
+ (instancetype)SharedManager;
- (void)startUpdatingLocation;

- (void)stopUpdatingLocation;
@end
