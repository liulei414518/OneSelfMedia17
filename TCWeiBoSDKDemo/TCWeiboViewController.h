//
//  WEWeiboViewController.h
//  WiressSDKDemo
//
//  Created by wang ying on 12-8-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCWBEngine.h"

@interface TCWeiboViewController : UIViewController<UIAlertViewDelegate>{
    TCWBEngine                  *weiboEngine;
    UIButton                    *logInBtnOAuth;                   //登录按钮
    UIActivityIndicatorView     *indicatorView;
    UIButton                    *generalInterfaceBtn;
    UIButton                    *btnLogin;
    UIButton                    *btnLogout;
    UIButton                    *btnRepeat;
}

@property (nonatomic, retain) TCWBEngine   *weiboEngine;
@property (nonatomic, retain) UIButton      *logInBtnOAuth;


- (void)showAlertMessage:(NSString *)msg;

@end
