//
//  WeatherView.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-30.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIWebView

{
    UILabel* _cityLabel;
    UILabel* _dateLabel;
    UILabel* _weatherLabel;
    UILabel* _windLabel;
    UILabel* _qiwenlabel;
    UIImageView* _imageView;
}
@property(strong,nonatomic)UILabel* cityLabel;
@property(strong,nonatomic)UILabel* dateLabel;
@property(strong,nonatomic)UILabel* weatherLabel;
@property(strong,nonatomic)UILabel* windLabel;
@property(strong,nonatomic)UILabel* qiwenlabel;
@property(strong,nonatomic)UIImageView* imageView;
@end
