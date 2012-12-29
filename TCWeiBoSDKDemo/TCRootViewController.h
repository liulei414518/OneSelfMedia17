//
//  TCRootViewController.h
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-8-24.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCWBEngine;

@interface TCRootViewController : UIViewController{

    TCWBEngine          *wbEngine;
    
    UIButton            *getTimelineBtn;
    UIButton            *getUserTimelineBtn;
    UIButton            *getHTTimelineBtn;
    UIButton            *getTranslineBtn;
    UIButton            *postTextWeiboBtn;
    UIButton            *postWithImageWeiboBtn;
    UIButton            *postWithImageURLWeiboBtn;
    
    UIButton            *getUserInfoBtn;
    UIButton            *getInfosBtn;
    UIButton            *getOtherInfoBtn;
    
    UIButton            *friendadd;     
    UIButton            *friendidollist;
    UIButton            *friendfanslist;
    UIButton            *friendmutual_list;
    UIButton            *friendcheck;
    UIButton            *getFriendInimate;
    
    UIButton            *lbsGetPeople;
    UIButton            *lbsGetNewWeibo;
    
    NSString            *url;
    
}

@property (nonatomic, retain) TCWBEngine    *wbEngine;
@property (nonatomic, retain) UIButton      *getTimelineBtn;
@property (nonatomic, retain) UIButton      *getUserTimelineBtn;
@property (nonatomic, retain) UIButton      *getHTTimelineBtn;
@property (nonatomic, retain) UIButton      *getTranslineBtn;
@property (nonatomic, retain) UIButton      *postTextWeiboBtn;
@property (nonatomic, retain) UIButton      *postWithImageWeiboBtn;
@property (nonatomic, retain) UIButton      *postWithImageURLWeiboBtn;

@property (nonatomic, retain) UIButton      *getUserInfoBtn;
@property (nonatomic, retain) UIButton      *getInfosBtn;
@property (nonatomic, retain) UIButton      *getOtherInfoBtn;

@property (nonatomic, retain) UIButton      *friendadd;
@property (nonatomic, retain) UIButton      *friendidollist;
@property (nonatomic, retain) UIButton      *friendfanslist;
@property (nonatomic, retain) UIButton      *friendmutual_list;
@property (nonatomic, retain) UIButton      *friendcheck;
@property (nonatomic, retain) UIButton      *getFriendInimate;
           
@property (nonatomic, retain) UIButton      *lbsGetPeople;
@property (nonatomic, retain) UIButton      *lbsGetNewWeibo;
@property (nonatomic, copy) NSString            *url;

@end
