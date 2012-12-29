//
//  MainViewController.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ViewA.h"
#import "ViewB.h"
#import "ViewC.h"
#import "ViewD.h"
#import "WeatherView.h"
#import "WeatherModel.h"
#import "MyCollect.h"
#import "OtherView.h"
#import "MainTitleView.h"
#import "ParticularViewController.h"
#import "GPSCoord.h"
#import "CityTableViewViewController.h"
#import "TableViewController.h"
#import "CalendarViewController.h"

@interface MainViewController : UIViewController
<jumpdelegate,cityDelegate,ASIHTTPRequestDelegate>
{
    //内容主视图
    UIView* _MainView;
    UIButton* selectedButton;
    UIButton* threeSeletedButton;
    //左侧滑动主视图
    UIScrollView* _MainSideScrollView;
    UIView* _SetVIew;
    UILabel*  _cityLabel;
    UISlider* _slider;
    UILabel* _textLabel;
    UIScrollView* _SubsidiaryScrollView;//附属滑动视图
    UIButton* accountButton;//设置账户
    UIButton* locationButton;//设置城市
    UIPopoverController* _popover;
    UIPopoverController* _CityPopover;
    
    
    
    NSArray* _moduleImageArray;//模块名称
    NSMutableArray* _idArray;//模块对应ID
    ViewA* _viewa;
    ViewB* _viewb;
    ViewC* _viewc;
    ViewD* _viewd;
    MainTitleView* _mainTitleView;
    WeatherView* _weatherView;
    MyCollect* _myCollect;
    OtherView* _otherView;
    ParticularViewController* _particular;
    GPSCoord* _gpsCoord;

    WeatherModel* _weatherModel;
    CityTableViewViewController* _cityTableView;
    TableViewController* _zhanghuTableView;
    
    CalendarViewController* calendar;
    UIButton* CalendarButton;
    
    int time;
}
@end
