//
//  WEWeiboViewController.m
//  WiressSDKDemo
//
//  Created by wang ying on 12-8-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCWeiboViewController.h"
#import "TCWBGlobalUtil.h"
#import "TCWBRebroadcastMsgViewController.h"
#import "TCRootViewController.h"
#import "FileStreame.h"
#import "key.h"
#import <CoreText/CoreText.h>

#ifndef WiressSDKDemoAppKey
#error
#endif

#ifndef WiressSDKDemoAppSecret
#error
#endif

#define TCWBAlertViewLogOutTag          100
#define TCWBAlertViewLogInTag           101

@implementation TCWeiboViewController

@synthesize weiboEngine;
@synthesize logInBtnOAuth;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.ying7wang7.com"];
    [engine setRootViewController:self];  
    //[engine setRedirectURI:@"http://www.ying7wang7.com"];
    self.weiboEngine = engine;
    [engine release];
#ifdef USE_UI_TWEET
    logInBtnOAuth = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logInBtnOAuth setFrame:CGRectMake(65, 150, 200, 40)];
    [logInBtnOAuth setTitle:@"发表组件(自带登录功能)" forState:UIControlStateNormal];//没登录就登录，有登录弹界面
    [logInBtnOAuth addTarget:self action:@selector(onLogInOAuthButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logInBtnOAuth];   
#endif
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(160, 240)];
    [self.view addSubview:indicatorView];
    
    generalInterfaceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [generalInterfaceBtn setFrame:CGRectMake(85, 200, 150, 40)];
    [generalInterfaceBtn setTitle:@"常用接口测试" forState:UIControlStateNormal];
    [generalInterfaceBtn addTarget:self action:@selector(onGeneralInterfaceBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:generalInterfaceBtn];   
    btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnLogin setFrame:CGRectMake(85, 100, 150, 40)];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];  
    btnLogout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnLogout setFrame:CGRectMake(85, 250, 150, 40)];
    [btnLogout setTitle:@"登出" forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(onLogout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogout]; 
    
#ifdef USE_UI_TWEET
    btnRepeat = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnRepeat setFrame:CGRectMake(65, 300, 200, 40)];
    [btnRepeat setTitle:@"转播组件(自带登录功能)" forState:UIControlStateNormal];//没登录就登录，有登录弹界面
    [btnRepeat addTarget:self action:@selector(repeatModuleCreat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRepeat];   
    
#endif

 
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.logInBtnOAuth = nil;
    [indicatorView release],indicatorView = nil;
}

- (void)dealloc{
    [weiboEngine release],weiboEngine = nil;
    
    [logInBtnOAuth release];
    
    [indicatorView release],indicatorView = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - method

//点击登录按钮
- (void)onLogin {
    [weiboEngine logInWithDelegate:self 
                         onSuccess:@selector(onSuccessLogin) 
                         onFailure:@selector(onFailureLogin:)];
}

- (void)onLogout {
    // 注销授权
    if ([weiboEngine logOut]) {
        [self showAlertMessage:@"登出成功！"];
    }else {
        [self showAlertMessage:@"登出失败！"];
    }
}

- (void)onGeneralInterfaceBtnPressed {
    if ([[self.weiboEngine openId] length] > 0) {
        TCRootViewController *tcWBRootViewController = [[TCRootViewController alloc] init];
        UINavigationController	*tcWBRootNavController = [[UINavigationController alloc] initWithRootViewController:tcWBRootViewController];
        [tcWBRootViewController release];
        [self presentModalViewController:tcWBRootNavController animated:YES];
        [tcWBRootNavController release];
    }
    else {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
                                                           message:@"请先授权！" 
                                                          delegate:self
                                                 cancelButtonTitle:@"确定" 
                                                 otherButtonTitles:nil];
        [alertView setTag:TCWBAlertViewLogInTag];
        [alertView show];
        [alertView release];
    }
}

#ifdef USE_UI_TWEET
//点击一键分享(自带登录功能)
- (void)onLogInOAuthButtonPressed
{      
    // 分享(自带登录功能)
    [self.weiboEngine UIBroadCastMsgWithContent:@"qq" 
                                       andImage:[UIImage imageNamed:@"test.png"] 
                                    parReserved:nil 
                                       delegate:self 
                                    onPostStart:@selector(postStart)
                                  onPostSuccess:@selector(createSuccess:) 
                                  onPostFailure:@selector(createFail:)];

}

// 点击一键转播（自带登陆功能） 
- (void)repeatModuleCreat {
    
    // 转播（自带登陆功能）
    [self.weiboEngine UICreatRebroadWithContent:@"中秋，国庆" 
                                    imageRefURL:@"http://mat1.gtimg.com/app/opent/images/index/iweibo/logo.gif" 
                               videoImageRefURL:@"http://www.tudou.com/programs/view/b-4VQLxwoX4/" 
                                    parReserved:nil 
                                       delegate:self 
                                    onPostStart:@selector(postStart) 
                                      onSuccess:@selector(createSuccess:) 
                                      onFailure:@selector(createFail:)];

}

#endif
#pragma mark - login callback

//登录成功回调
- (void)onSuccessLogin
{
    [indicatorView stopAnimating];
}

//登录失败回调
- (void)onFailureLogin:(NSError *)error
{
    [indicatorView stopAnimating];
    NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    [message release];
}

//授权成功回调
- (void)onSuccessAuthorizeLogin
{
    [indicatorView stopAnimating];
    [self onLogInOAuthButtonPressed];
}

- (void)didRequestMutualList:(id)result{
    
}

#pragma mark -  get homeline callback

- (void)successCallBack:(id)result{

}

- (void)failureCallBack{
    
}



#pragma mark -
#pragma mark - creatSuccessOrFail 

- (void)postStart {
    NSLog(@"%s", __FUNCTION__);
//    [self showAlertMessage:@"开始发送"];
}

- (void)createSuccess:(NSDictionary *)dict {
    NSLog(@"%s %@", __FUNCTION__,dict);
    if ([[dict objectForKey:@"ret"] intValue] == 0) {
        [self showAlertMessage:@"发送成功！"];
    }else {
        [self showAlertMessage:@"发送失败！"];
    }
}

- (void)createFail:(NSError *)error {
    NSLog(@"error is %@",error);
    [self showAlertMessage:@"发送失败！"];
}

- (void)showAlertMessage:(NSString *)msg {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
                                                       message:msg 
                                                      delegate:self
                                             cancelButtonTitle:@"确定" 
                                             otherButtonTitles:nil];
    [alertView show];
    [alertView release];

}

@end
