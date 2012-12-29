//
//  OAuthWebView.h
//  weibo
//
//  Created by Yang QianFeng on 29/06/2012.
//  Copyright (c) 2012 千锋3G www.mobiletrain.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboHTTPManager.h"

@protocol OAuthLoginDelegate;
@interface OAuthLoginController : UIViewController 
<UIWebViewDelegate, WeiboHTTPDelegate>
{
    UIWebView *webV;
    NSString *token;
    
    WeiboHTTPManager *weiboHttpManager;
    
    id <OAuthLoginDelegate> _delegate;
}
@property (nonatomic, assign) id <OAuthLoginDelegate> delegate;

+ (id) sharedOAuthController;
+ (void) launchLoginUI;
+ (NSString *) getCurrentAccount;
+ (NSString *) getCurrentToken;
+ (void) logout;

@end

@protocol OAuthLoginDelegate <NSObject>

- (void) didFinishedOauthController:(OAuthLoginController *)controller;
- (void) didCancelOauthController:(OAuthLoginController *)controller;

@end

