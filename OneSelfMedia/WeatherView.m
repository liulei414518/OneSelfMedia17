//
//  WeatherView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-30.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView
@synthesize cityLabel=_cityLabel ,dateLabel=_dateLabel,weatherLabel=_weatherLabel
        ,qiwenlabel=_qiwenlabel,imageView=_imageView,windLabel=_windLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"WeatherBG.png"]];
         [self setOpaque:NO];//设置透明度
        _cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 30)];
        _cityLabel.font=[UIFont systemFontOfSize:15];
        _cityLabel.textColor=[UIColor whiteColor];
        _cityLabel.textAlignment=UITextAlignmentCenter;
        _cityLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:_cityLabel];
        
        _dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(125, 0, 120, 30)];
        _dateLabel.backgroundColor=[UIColor clearColor];
        _dateLabel.font=[UIFont systemFontOfSize:13];
        _dateLabel.textColor=[UIColor whiteColor];
        [self addSubview:_dateLabel];
        
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 40, 129/2, 105/2)];
        _imageView.backgroundColor=[UIColor clearColor];
        [self addSubview:_imageView];
        
        _weatherLabel=[[UILabel alloc]initWithFrame:CGRectMake(155, 37, 70, 30)];
        _weatherLabel.backgroundColor=[UIColor clearColor];
        _weatherLabel.font=[UIFont systemFontOfSize:15];
        _weatherLabel.textColor=[UIColor whiteColor];
        _weatherLabel.textAlignment=UITextAlignmentCenter;
        _weatherLabel.lineBreakMode=UILineBreakModeWordWrap;
        _weatherLabel.numberOfLines=0;
        [self addSubview:_weatherLabel];
        
        _windLabel=[[UILabel alloc]initWithFrame:CGRectMake(155, 62, 70, 30)];
        _windLabel.backgroundColor=[UIColor clearColor];
        _windLabel.font=[UIFont systemFontOfSize:15];
        _windLabel.textColor=[UIColor whiteColor];
        _windLabel.textAlignment=UITextAlignmentCenter;
        _windLabel.lineBreakMode=UILineBreakModeWordWrap;
        _windLabel.numberOfLines=0;
        [self addSubview:_windLabel];
        
        _qiwenlabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 37, 90, 55)];
        _qiwenlabel.backgroundColor=[UIColor clearColor];
        _qiwenlabel.font=[UIFont systemFontOfSize:15];
        _qiwenlabel.textAlignment=UITextAlignmentCenter;
        _qiwenlabel.textColor=[UIColor whiteColor];
        [self addSubview:_qiwenlabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
