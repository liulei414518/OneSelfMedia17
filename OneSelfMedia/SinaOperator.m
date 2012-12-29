//
//  SinaOperator.m
//  NewSN
//
//  Created by eg365 on 12-10-9.
//
//

#import "SinaOperator.h"
#import "AppDelegate.h"
#import "Reachability.h"
static SinaOperator *sinaOperator;

#define kFeedbackEmailAddress       @"service@fuyanculture.com"
#define kWBSDKDemoAppKey            @"1035552810"
#define kWBSDKDemoAppSecret         @"e870b2fc9456787215ec2d524d2c060e"

@implementation SinaOperator
@synthesize avatarURL;
@synthesize username;
@synthesize wbEngine;
@synthesize contentDelegate;
@synthesize switchDelegate;
@synthesize hud;

-(id)init{
    if ((self = [super init])) {
        WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
        [engine setDelegate:self];
        [engine setRedirectURI:@"http://"];
        [engine setIsUserExclusive:YES];
        self.wbEngine = engine;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        avatarURL = [defaults objectForKey:DEFAULTAVATARURKEY];
        username = [defaults objectForKey:DEFAULTUSERNAMEKEY];
        if (avatarURL==nil || username==nil) {
            self.wbEngine.userID = nil;
        }
        currentRequest = TagRequestNone;
    }
    return self;
}

//单列
+ (SinaOperator *)sharedSinaWeiboOperator{
    if (!sinaOperator) {
        sinaOperator = [[SinaOperator alloc] init];
    }
    return sinaOperator;
}


- (NSString *)GetUseName{
    return username;
}


- (BOOL) isBindSinaWeiBo{
    if ([wbEngine isLoggedIn] && ![wbEngine isAuthorizeExpired])
    {
        return YES;
    }
    else
    {
        [wbEngine logIn];
        return NO;
    }
}


- (void) bindSinaWeiBo{
    if ([wbEngine isLoggedIn] && ![wbEngine isAuthorizeExpired])
    {

    }
    else
    {
        [wbEngine logIn];
    }
}


- (void) cancleBindSinaWeiBo{
    [wbEngine logOut];
}


- (void) ShareFixedContent:(NSString *)Mytext{
    if ([wbEngine isLoggedIn] && ![wbEngine isAuthorizeExpired])
    {
        currentRequest = TagRequestShareContent;
        
        [wbEngine sendWeiBoWithText:[Mytext stringByAppendingString:@"http://www.newsn.me"]
                              image:[UIImage imageWithContentsOfFile:SandBox(@"myImage.png")]];
    }else{
        [wbEngine logIn];
    }
}

- (UIImage*)rotateImageByAngle:(float)angleInRadians withCG:(CGImageRef)Image {
    CGSize size = CGSizeMake(1024, 768);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextRotateCTM(ctx, M_PI * angleInRadians / 180);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),  CGRectMake(0,0,size.height, size.width), Image);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - WBEngineDelegate
- (void)engineDidLogIn:(WBEngine *)engine{
    
    [[NSUserDefaults standardUserDefaults]setValue:engine.accessToken forKey:@"accessToken"];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            wbEngine.userID,@"uid",
                            nil];
    currentRequest = TagRequestPersonalInfo;
    [wbEngine loadRequestWithMethodName:@"users/show.json"
                              httpMethod:@"GET"
                                  params:params
                            postDataType:sinakWBRequestPostDataTypeNone
                        httpHeaderFields:nil];
}
- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"绑定失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
{
    if ([result isKindOfClass:[NSDictionary class]]) {
        if (currentRequest == TagRequestPersonalInfo) {
            NSDictionary *resultDict = result;
            self.avatarURL = [resultDict objectForKey:@"profile_image_url"];
            self.username = [resultDict objectForKey:@"screen_name"];
            [[NSUserDefaults standardUserDefaults] setObject:self.avatarURL forKey:DEFAULTAVATARURKEY];
            [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:DEFAULTUSERNAMEKEY];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                               message:@"绑定成功！"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
            alertView.tag = 1;
            [switchDelegate saveSwicth];
            [alertView show];
        }else if(currentRequest == TagRequestShareContent){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                               message:@"分享成功"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
            alertView.tag = 2;
            [alertView show];
        }
    }
    currentRequest = TagRequestNone;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [contentDelegate initContentViewDelegate];
        }
    }
    if (alertView.tag == 2 || alertView.tag == 3) {
        if (buttonIndex == 0) {
            [contentDelegate disappearKeyBoard];
        }
    }
}



- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error
{
    if (currentRequest == TagRequestShareContent) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"分享失败"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        alertView.tag = 3;
        [alertView show];
    }
}



- (void)engineDidLogOut:(WBEngine *)engine
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:DEFAULTAVATARURKEY];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:DEFAULTUSERNAMEKEY];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登出成功！"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
    [switchDelegate noSaveSwicth];
	[alertView show];
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"请重新登录！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}
-(BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];  // 测试服务器状态
    
    switch([reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            break;
    }
    return  isExistenceNetwork;
}


@end
