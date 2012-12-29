//
//  AppDelegate.h
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-8-15.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCWeiboViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    TCWeiboViewController           *viewController;
    BOOL                             logout;                //退出标志，yes为退出
}

@property (retain, nonatomic) UIWindow              *window;
@property (retain, nonatomic) TCWeiboViewController *viewController;
@property (assign, nonatomic) BOOL                  logout;

@end
