//
//  WeiboHTTPManager.h
//  weibo
//
//  Created by Yang QianFeng on 29/06/2012.
//  Copyright (c) 2012 千锋3G www.mobiletrain.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

#define SINA_V2_DOMAIN              @"https://api.weibo.com/2"
#define SINA_API_AUTHORIZE          @"https://api.weibo.com/oauth2/authorize"
#define SINA_API_ACCESS_TOKEN       @"https://api.weibo.com/oauth2/access_token"

#define SINA_APP_KEY @"1939671375"
#define SINA_APP_SECRET @"b39c896d2096933c2c50ae6a51ce7c8a"
#define SINA_CALLBACK @"http://www.cnblogs.com"

#define USER_STORE_ACCESS_TOKEN     @"SinaAccessToken"
#define USER_STORE_EXPIRATION_DATE  @"SinaExpirationDate"
#define USER_STORE_USER_ID          @"SinaUserID"
#define USER_STORE_USER_NAME        @"SinaUserName"

@protocol WeiboHTTPDelegate;
@interface WeiboHTTPManager : NSObject <ASIHTTPRequestDelegate>
{
    id <WeiboHTTPDelegate> delegate;
    NSString *authToken;
}
@property (nonatomic, assign) id <WeiboHTTPDelegate> delegate;
@property (nonatomic, retain) NSString *authToken;

- (id)initWithDelegate:(id)theDelegate;
- (NSURL*)getOauthCodeUrl;

@end

@protocol WeiboHTTPDelegate <NSObject>

@end
