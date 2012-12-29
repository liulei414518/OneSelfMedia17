//
//  TableViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-5.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "TableViewController.h"
#import "TCWBGlobalUtil.h"
#import "key.h"
#import "FileStreame.h"
#import "TCWBRebroadcastMsgViewController.h"
#import "ViewA.h"
#ifndef WiressSDKDemoAppKey
#error
#endif

#ifndef WiressSDKDemoAppSecret
#error
#endif

#define TCWBAlertViewLogOutTag          100
#define TCWBAlertViewLogInTag           101
static TableViewController *tableViewController;
@interface TableViewController ()

@end

@implementation TableViewController
@synthesize weiboEngine;


+(TableViewController*)shareTableView{
    if (!tableViewController) {
        tableViewController = [[TableViewController alloc] init];
    }
    return tableViewController;


}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self setContentSizeForViewInPopover:CGSizeMake(300, 400)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人账号";
    _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 400) style:UITableViewStyleGrouped];
    _tabelView.delegate=self;
    _tabelView.dataSource=self;
    [self.view addSubview:_tabelView];
    
    _engine=[[WBEngine alloc]initWithAppKey:SinaAppKey appSecret:SinaAppSecret];
    _engine.rootViewController=self;
    _engine.delegate=self;
    _engine.redirectURI = @"http://";
    _engine.isUserExclusive = NO;
    
   weiboEngine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
    [weiboEngine setRootViewController:self];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return @"自媒体通行证";
    }
    return @"其他平台";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }
    return 55;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"cellid";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell==Nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    if (indexPath.section==0) {
        cell.imageView.image=[UIImage imageNamed:@"image_small.jpg"];
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 150, 40)];
        label.font=[UIFont systemFontOfSize:20];
        label.backgroundColor=[UIColor clearColor];
        label.textAlignment=UITextAlignmentCenter;
        label.text=@"未登录";
        [cell addSubview:label];
         NSArray* array=[NSArray arrayWithObjects:@"注册", @"登陆",nil];
        for (int i=0; i<2; i++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            button.frame=CGRectMake(95+i*95, 45, 80, 30);
            button.tag=100+i;
            [button addTarget:self action:@selector(myButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
        }
    }
       if (indexPath.section==1&&indexPath.row==0) {
           cell.textLabel.text=@"新浪微博";
           Sinabutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
           Sinabutton.frame=CGRectMake(200, 10, 80, 40);
           [Sinabutton setTitle:@"绑定" forState:UIControlStateNormal];
           [Sinabutton addTarget:self action:@selector(sinaAction) forControlEvents:UIControlEventTouchUpInside];
           [cell addSubview:Sinabutton];
     
           if ([_engine isLoggedIn]) {
               [Sinabutton setTitle:@"解绑" forState:UIControlStateNormal];
               NSLog(@"解绑");
           }else{
               [Sinabutton setTitle:@"绑定" forState:UIControlStateNormal];
               NSLog(@"绑定");
           }
       }
    if (indexPath.section==1&&indexPath.row==1) {
        cell.textLabel.text=@"腾讯微博";
        Txbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        Txbutton.frame=CGRectMake(200, 10, 80, 40);
        
        
        [Txbutton setTitle:@"绑定" forState:UIControlStateNormal];
        [Txbutton addTarget:self action:@selector(txAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:Txbutton];
    }
    if (indexPath.section==1&&indexPath.row==2) {
        cell.textLabel.text=@"人人网";
        Renbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        Renbutton.frame=CGRectMake(200, 10, 80, 40);
        //未登录状态
        if (![[Renren sharedRenren]isSessionValid]) {
           [Renbutton setTitle:@"绑定" forState:UIControlStateNormal]; 
           [Renbutton addTarget:self action:@selector(renAction) forControlEvents:UIControlEventTouchUpInside];

        }
        else {//已经登录的
            [Renbutton setTitle:@"解绑" forState:UIControlStateNormal];
            [Renbutton addTarget:self action:@selector(renAction) forControlEvents:UIControlEventTouchUpInside];
        } 
        [cell addSubview:Renbutton];
        
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)myButtonAction:(UIButton*)sender{
    NSLog(@"%d",sender.tag);
    if (sender.tag==100) {
        ZhuCeViewController* zhuce=[[ZhuCeViewController alloc]init];
        zhuce.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:zhuce animated:YES];
    }
    if (sender.tag==101) {
        DengluViewController* denglu=[[DengluViewController alloc]init];
        [denglu setContentSizeForViewInPopover:CGSizeMake(300, 400)];
        [self.navigationController pushViewController:denglu animated:YES];
        
    }
}
-(BOOL)sinaIsLogin{
    if ([_engine isLoggedIn]) {
        return YES;
    }
    return NO;
}
-(void)sinaAction{
    NSLog(@"qqqq");
     [[SinaOperator sharedSinaWeiboOperator]bindSinaWeiBo];
//    if ([_engine isLoggedIn]&&![_engine isAuthorizeExpired]) {
//        [_engine logOut];
//    }else{
//        [_engine logIn];
//    
//    }
}
-(void)shareTCWeiBo{
//    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
//    [engine setRootViewController:self];  
//    self.weiboEngine = engine;
    UIImage* image = [UIImage imageNamed:@"logo.png"];
    WBSendView* sendView = [[WBSendView alloc] initWithAppKey:WiressSDKDemoAppKey appSecret:WiressSDKDemoAppSecret text:@"今天天气真的不错啊!" image:image];
    sendView.delegate = self;
    [sendView show:YES];
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:@"hello everybody!", @"status", [UIImage imageNamed:@"logo.png"], @"pic", nil];
    [_engine loadRequestWithMethodName:@"statuses/upload.json" httpMethod:@"POST" params:params postDataType:kWBRequestPostDataTypeMultipart httpHeaderFields:nil];


}
//u请求失败
- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error{
    NSLog(@"requestDidFailWithError:%@", error);
}
//请求成功
- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result{
    NSLog(@"requestDidSucceedWithResult %@",engine.accessToken);
}

//发送成功
- (void)sendViewDidFinishSending:(WBSendView *)view{
    NSLog(@"sendViewDidFinishSending");
    [view removeFromSuperview];
}

//点击登录按钮
-(void)txAction{
    NSLog(@"txAction");
        [weiboEngine UICreatRebroadWithContent:@"室友失业，求合租啊" 
                                       imageRefURL:nil 
                                   videoImageRefURL:nil 
                                        parReserved:nil 
                                           delegate:self 
                                    onPostStart:@selector(postStart) 
                                          onSuccess:@selector(createSuccess:) 
                                          onFailure:@selector(createFail:)];   
//        TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];

//    [weiboEngine logInWithDelegate:self onSuccess:@selector(onSuccessLogin) onFailure:@selector(onFailureLogin:)];
}
-(void)renAction{
   NSLog(@"renAction");
    if(![[Renren sharedRenren] isSessionValid]){//未登录的情况,进行授权登录
        [[Renren sharedRenren] authorizationWithPermisson:nil andDelegate:self];
    } else {//已登录的情况，退出登录
        [[Renren sharedRenren] logout:self];
//        [Renbutton setTitle:@"绑定" forState:UIControlStateNormal];
    }
}
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
    
    
}

#pragma mark RenrenDelegate
/**
 * 授权登录成功时被调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renrenDidLogin:(Renren *)renren
{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"成功登录" message:@"授权成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
    [alertView show];
    [Renbutton setTitle:@"解绑" forState:UIControlStateNormal];
    
}

/**
 * 用户登出成功后被调用 第三方开发者实现这个方法
 * @param renren 传回代理登出接口请求的Renren类型对象。
 */
- (void)renrenDidLogout:(Renren *)renren
{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"退出" message:@"已经成功登出" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
    [alertView show];
    [Renbutton setTitle:@"绑定" forState:UIControlStateNormal];
}

/**
 * 授权登录失败时被调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renren:(Renren *)renren loginFailWithError:(ROError*)error
{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"错误提示" message:@"授权失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
    [alertView show];
}
#pragma mark SinaDelegate
//登陆成功
- (void)engineDidLogIn:(WBEngine *)engine{
    NSLog(@"engineDidLogIn engine.accessToken%@",engine.accessToken);
    [[NSUserDefaults standardUserDefaults]setValue:engine.accessToken forKey:@"accessToken"];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [Sinabutton setTitle:@"解绑" forState:UIControlStateNormal];
}
//解绑成功
- (void)engineDidLogOut:(WBEngine *)engine{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"解绑成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    NSLog(@"engineDidLogOut");
        [Sinabutton setTitle:@"绑定" forState:UIControlStateNormal];
}
//已经登陆
- (void)engineAlreadyLoggedIn:(WBEngine *)engine{
    NSLog(@"engineAlreadyLoggedIn");
}
//登陆失败
- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error{
    NSLog(@"didFailToLogInWithError:%@", error);
}

#pragma mark - creatSuccessOrFail 
// 腾讯微博
//登录成功回调
- (void)onSuccessLogin
{
    NSLog(@"登录成功");
}
//登录失败回调
- (void)onFailureLogin:(NSError *)error
{
    NSLog(@"shibai");
//    NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
//                                                        message:message
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//    [alertView show];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
return ((interfaceOrientation == UIDeviceOrientationLandscapeLeft)||(interfaceOrientation == UIDeviceOrientationLandscapeRight));

}
@end
