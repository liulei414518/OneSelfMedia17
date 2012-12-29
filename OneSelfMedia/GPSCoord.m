//
//  GPSCoord.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-3.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "GPSCoord.h"

@implementation GPSCoord
@synthesize city;

-(id)initGps{
    self=[super init];
    if (self) {
        _locationManager=[[CLLocationManager alloc]init];
        _locationManager.delegate=self;
        //准确度
        _locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        _locationManager.distanceFilter=1000.0f;
        [_locationManager startUpdatingLocation];
    }
  
    return self;
}
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    latitude=[NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
    longitude=[NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
    NSLog(@"当前城市经纬度{%@,%@}",latitude,longitude);
    
    //转换经纬度变成可读信息
    _geoCoder = [[CLGeocoder alloc] init];
    [_geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placeMark in placemarks){
          
            city=placeMark.locality;
              NSLog(@"城市:%@",city);
            
        }
    }];
    //如果没有城市
    if (city.length<=0) {
//        NSLog(@"城市为空，默认北京");
//        city=@"北京市";
        [_locationManager stopUpdatingLocation];
    }else{
        [_locationManager stopUpdatingLocation];
        NSLog(@"定位成功");
        NSLog(@"关闭GPS");
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"------------GPS----Error");
      NSLog(@"没有定位，默认北京");
    city=@"北京市";
    [_locationManager stopUpdatingLocation];
}
@end
