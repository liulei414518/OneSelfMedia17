//
//  OAuthWebView.m
//  weibo
//
//  Created by Yang QianFeng on 29/06/2012.
//  Copyright (c) 2012 千锋3G www.mobiletrain.org. All rights reserved.
//

#import "OAuthLoginController.h"
#import "WeiboHTTPManager.h"

static UIViewController *s;

@implementation OAuthLoginController
@synthesize delegate = _delegate;

+ (id) sharedOAuthController {
    if (s == nil) {
        OAuthLoginController *root = [[[self class] alloc] init];
        s = [[UINavigationController alloc] initWithRootViewController:root];
    }
    return s;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView
{
    [super loadView];
    
    self.title = @"weibo";
    
    webV = [[UIWebView alloc] initWithFrame:[self.view bounds]];
    [webV setDelegate:self];
    
    weiboHttpManager = [[WeiboHTTPManager alloc] initWithDelegate:self];
    NSURL *url = [weiboHttpManager getOauthCodeUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [webV loadRequest:request];
    [request release];
    
    [self.view addSubview:webV];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelWeibo)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    [cancelButton release];
}
- (void) closeView {
    UIViewController *wv = [OAuthLoginController sharedOAuthController];

    CGRect rect = wv.view.frame;
    CGRect newRect = rect;
    newRect.origin.y += newRect.size.height;
    [UIView animateWithDuration:0.5 animations:^(void){
            wv.view.frame = newRect;
        } completion:^(BOOL finished) {
            [wv.view removeFromSuperview];
        }
     ];    
}

- (void) cancelWeibo {
    [self closeView];

    if ([_delegate respondsToSelector:@selector(didCancelOauthController:)]) {
        [_delegate didCancelOauthController:self];
    }
}

+ (void) logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_STORE_USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_STORE_EXPIRATION_DATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *) getStringFromUrl: (NSString*) url needle:(NSString *) needle {
    NSString * str = nil;
    NSRange start = [url rangeOfString:needle];
    if (start.location != NSNotFound) {
        NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
        NSUInteger offset = start.location+start.length;
        str = end.location == NSNotFound
        ? [url substringFromIndex:offset]
        : [url substringWithRange:NSMakeRange(offset, end.location)];
        str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return str;
}

- (void) dialogDidSucceed:(NSURL*)url {
    NSString *q = [url absoluteString];
    token = [self getStringFromUrl:q needle:@"access_token="];
    
    // 用户点取消 error_code=21330
    NSString *errorCode = [self getStringFromUrl:q needle:@"error_code="];
    if (errorCode != nil && [errorCode isEqualToString: @"21330"]) {
        [self cancelWeibo];
    }
    
    NSString *refreshToken = [self getStringFromUrl:q needle:@"refresh_token="];
    NSString *expTime = [self getStringFromUrl:q needle:@"expires_in="];
    NSString *uid = [self getStringFromUrl:q needle:@"uid="];
    NSString *remindIn = [self getStringFromUrl:q needle:@"remind_in="];
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:USER_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:USER_STORE_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSDate *expirationDate =nil;
    NSLog(@"qianfeng \n\ntoken=%@\nrefreshToken=%@\nexpTime=%@\nuid=%@\nremindIn=%@\n\n",token,refreshToken,expTime,uid,remindIn);
    if (expTime != nil) {
        int expVal = [expTime intValue]-3600;
        if (expVal) {
            expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
            [[NSUserDefaults standardUserDefaults]setObject:expirationDate forKey:USER_STORE_EXPIRATION_DATE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"qianfeng time = %@",expirationDate);
        } 
    } 
    if (token) {
        [self closeView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    // 这里是几个重定向，将每个重定向的网址遍历，如果遇到＃号，则重定向到自己申请时候填写的网址，后面会附上access_token的值
    NSURL *url = [request URL];
    NSLog(@"webview's url = %@",url);
    NSArray *array = [[url absoluteString] componentsSeparatedByString:@"#"];
    if ([array count]>1) {
        // http://www.1000phone.com/#access_token=2.00d4s_SC6hIGaC3ab9a0af3aaRBAFC&remind_in=86399&expires_in=86399&uid=2102976985
        [self dialogDidSucceed:url];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad ");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad ");
}

+ (void) launchLoginUI {
    UIViewController *wv = [OAuthLoginController sharedOAuthController];

    UIWindow* wnd = [[UIApplication sharedApplication] keyWindow];
    CGRect windowRect = wnd.frame;
    
    CGRect origRect = windowRect;
    origRect.origin.y += windowRect.size.height;
    [wv.view setFrame:origRect];

    [wnd addSubview:wv.view];

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	wv.view.frame = windowRect;
	[UIView commitAnimations];
}

+ (NSString *) getCurrentAccount {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
}
+ (NSString *) getCurrentToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_ACCESS_TOKEN];
}


@end
