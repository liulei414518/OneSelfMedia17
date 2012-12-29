//
//  GPSCoord.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-3.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MapKit/MapKit.h"
@interface GPSCoord : NSObject
<CLLocationManagerDelegate>
{
    
    CLGeocoder* _geoCoder;
    NSString* latitude;//纬度
    NSString* longitude;//经度
    
    CLLocationManager* _locationManager;
    
    NSString* city;
}
@property(strong,nonatomic)NSString* city;
-(id)initGps;
@end
