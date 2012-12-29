//
//  TCGetTimelineController.h
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-8-24.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCGetTimelineController : UIViewController{
    UITextView          *homeTextView;
    NSDictionary        *homeDic;
    NSString            *url;
}

@property (nonatomic, retain) UITextView         *homeTextView;
@property (nonatomic, retain) NSDictionary       *homeDic;
@property(nonatomic, copy)  NSString            *url;
           
@end
