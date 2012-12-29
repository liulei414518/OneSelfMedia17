//
//  TCRootViewController.m
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-8-24.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCWBEngine.h"
#import "TCGetTimelineController.h"
#import "TCRootViewController.h"

@implementation TCRootViewController

@synthesize getTimelineBtn,postTextWeiboBtn,postWithImageWeiboBtn,postWithImageURLWeiboBtn;
@synthesize getUserTimelineBtn,getHTTimelineBtn,getTranslineBtn;
@synthesize getUserInfoBtn,getInfosBtn,getOtherInfoBtn;
@synthesize friendadd,friendidollist,friendfanslist,friendmutual_list,friendcheck,getFriendInimate;
@synthesize lbsGetPeople,lbsGetNewWeibo;
@synthesize wbEngine;
@synthesize url;

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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"URLPost" object:nil];
    [self.wbEngine cancelAllRequest];
    self.wbEngine = nil;
    [super dealloc];
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)back {
    [self dismissModalViewControllerAnimated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 52, 33)];
	[buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
	buttonLeft.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"composequxiaobtn.png"] forState:UIControlStateNormal];
	[buttonLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *barLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
	self.navigationItem.leftBarButtonItem = barLeft;
	[barLeft release];
    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.ying7wang7.com"];
    [engine setRootViewController:self];  
    //[engine setRedirectURI:@"http://www.ying7wang7.com"];
    self.wbEngine = engine;
    [engine release];
    //  拉取timeline信息按钮
    getTimelineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getTimelineBtn setFrame:CGRectMake(15, 15, 140, 30)];
    [getTimelineBtn setTitle:@"主人页时间线" forState:UIControlStateNormal];
    [getTimelineBtn addTarget:self action:@selector(onGetTimelineButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getTimelineBtn];
    
    getUserTimelineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getUserTimelineBtn setFrame:CGRectMake(165, 15, 140, 30)];
    [getUserTimelineBtn setTitle:@"客人页时间线" forState:UIControlStateNormal];
    [getUserTimelineBtn addTarget:self action:@selector(onGetUserTimelineButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUserTimelineBtn];
    
    //  发表一条文本微博按钮
    postTextWeiboBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [postTextWeiboBtn setFrame:CGRectMake(15, 60, 140, 30)];
    [postTextWeiboBtn setTitle:@"普通发表接口" forState:UIControlStateNormal];
    [postTextWeiboBtn addTarget:self action:@selector(onPostTextWeiboButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postTextWeiboBtn];
    
    //  发表一条带图片的微博按钮
    postWithImageWeiboBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [postWithImageWeiboBtn setFrame:CGRectMake(165, 60, 140, 30)];
    [postWithImageWeiboBtn setTitle:@"发表带图微博" forState:UIControlStateNormal];
    [postWithImageWeiboBtn addTarget:self action:@selector(onPostWithImageWeiboButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postWithImageWeiboBtn];
    
    //  发表一条图片url的微博
    postWithImageURLWeiboBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [postWithImageURLWeiboBtn setFrame:CGRectMake(15, 105, 140, 30)];
    [postWithImageURLWeiboBtn setTitle:@"发表带网络图片微博" forState:UIControlStateNormal];
    [postWithImageURLWeiboBtn addTarget:self action:@selector(onPostWithImageURLWeiboButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postWithImageURLWeiboBtn];
    
    getHTTimelineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getHTTimelineBtn setFrame:CGRectMake(165, 105, 140, 30)];
    [getHTTimelineBtn setTitle:@"话题时间线" forState:UIControlStateNormal];
    [getHTTimelineBtn addTarget:self action:@selector(onGetHTTimelineButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getHTTimelineBtn];
    
    getUserInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getUserInfoBtn setFrame:CGRectMake(15, 150, 140, 30)];
    [getUserInfoBtn setTitle:@"获取用户信息" forState:UIControlStateNormal];
    [getUserInfoBtn addTarget:self action:@selector(onGetUserInfoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUserInfoBtn];
    
    getOtherInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getOtherInfoBtn setFrame:CGRectMake(165, 150, 140, 30)];
    [getOtherInfoBtn setTitle:@"获取他人信息" forState:UIControlStateNormal];
    [getOtherInfoBtn addTarget:self action:@selector(onGetOtherInfoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getOtherInfoBtn];
    
    getInfosBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getInfosBtn setFrame:CGRectMake(15, 195, 140, 30)];
    [getInfosBtn setTitle:@"获取一批人信息" forState:UIControlStateNormal];
    [getInfosBtn addTarget:self action:@selector(onGetInfosButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getInfosBtn];
    
    friendadd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [friendadd setFrame:CGRectMake(165, 195, 140, 30)];
    [friendadd setTitle:@"收听某个用户" forState:UIControlStateNormal];
    [friendadd addTarget:self action:@selector(onfriendaddButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:friendadd];
    
    friendidollist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [friendidollist setFrame:CGRectMake(15, 240, 140, 30)];
    [friendidollist setTitle:@"获取偶像列表" forState:UIControlStateNormal];
    [friendidollist addTarget:self action:@selector(onfriendidollistButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:friendidollist];
    
    friendfanslist = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [friendfanslist setFrame:CGRectMake(165, 240, 140, 30)];
    [friendfanslist setTitle:@"获取粉丝列表" forState:UIControlStateNormal];
    [friendfanslist addTarget:self action:@selector(onfriendfanslistButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:friendfanslist];
    
    friendmutual_list = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [friendmutual_list setFrame:CGRectMake(15, 285, 140, 30)];
    [friendmutual_list setTitle:@"获取互听列表" forState:UIControlStateNormal];
    [friendmutual_list addTarget:self action:@selector(onfriendmutual_listButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:friendmutual_list];
    
    friendcheck = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [friendcheck setFrame:CGRectMake(165, 285, 140, 30)];
    [friendcheck setTitle:@"验证好友关系" forState:UIControlStateNormal];
    [friendcheck addTarget:self action:@selector(onfriendcheckButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:friendcheck];
    
    getTranslineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getTranslineBtn setFrame:CGRectMake(15, 330, 140, 30)];
    [getTranslineBtn setTitle:@"转播获取转播列表" forState:UIControlStateNormal];
    [getTranslineBtn addTarget:self action:@selector(onGetTransWeiboButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getTranslineBtn];
    
    getFriendInimate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getFriendInimate setFrame:CGRectMake(165, 330, 140, 30)];
    [getFriendInimate setTitle:@"获取最近联系人" forState:UIControlStateNormal];
    [getFriendInimate addTarget:self action:@selector(onGetFriendInimate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getFriendInimate];
    
    lbsGetPeople = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lbsGetPeople setFrame:CGRectMake(15, 375, 140, 30)];
    [lbsGetPeople setTitle:@"获取附近的人" forState:UIControlStateNormal];
    [lbsGetPeople addTarget:self action:@selector(onGetlbsPeopleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lbsGetPeople];
    
    lbsGetNewWeibo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lbsGetNewWeibo setFrame:CGRectMake(165, 375, 140, 30)];
    [lbsGetNewWeibo setTitle:@"获取身边最新的微博" forState:UIControlStateNormal];
    [lbsGetNewWeibo addTarget:self action:@selector(onGetlbsNewweiboButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lbsGetNewWeibo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(URLPostAction:) name:@"URLPost" object:nil];
}

-(void)URLPostAction:(NSNotification *)not {
    self.url = (NSString *)[not object];
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

#pragma mark - public method

//获得timeline信息 
- (void)onGetTimelineButtonPressed
{
    //获得timeline信息 
    [wbEngine getHomeTimelinewithFormat:@"json"
                               pageFlag:0 
                               pageTime:@"0"  
                                 reqNum:30 
                                   type:0 
                         andContentType:0 
                            parReserved:nil
                               delegate:self 
                              onSuccess:@selector(successCallBack:) 
                              onFailure:@selector(failureCallBack:)];
}

//发表一条微博
- (void)onPostTextWeiboButtonPressed
{
    //发表一条微博
    [wbEngine postTextTweetWithFormat:@"json" 
                              content:@"hello,world"
                             clientIP:@"10.10.1.31"
                            longitude:nil
                          andLatitude:nil
                          parReserved:nil
                             delegate:self
                            onSuccess:@selector(successCallBack:)
                            onFailure:@selector(failureCallBack:)];
    
}

//发表带图微博
- (void)onPostWithImageWeiboButtonPressed
{
    UIImage *img = [UIImage imageNamed:@"compose#.png"];
    NSData *dataImage = UIImageJPEGRepresentation(img, 1.0);
    [wbEngine postPictureTweetWithFormat:@"json" 
                                    content:@"hello,world" 
                                   clientIP:@"10.10.1.38"  
                                        pic:dataImage
                             compatibleFlag:@"0"
                                  longitude:nil
                                andLatitude:nil
                                parReserved:nil
                                   delegate:self 
                                  onSuccess:@selector(successCallBack:) 
                                  onFailure:@selector(failureCallBack:)];}

//发表带图片url微博 
- (void)onPostWithImageURLWeiboButtonPressed
{
       
    [wbEngine postPictureURLTweetWithFormat:@"json" 
                                           content:@"hello,world" 
                                          clientIP:@"10.10.1.38" 
                                            picURL:@"http://mat1.gtimg.com/app/opent/images/index/iweibo/logo.gif"
                                    compatibleFlag:@"0" 
                                         longitude:nil 
                                       andLatitude:nil
                                       parReserved:nil
                                          delegate:self 
                                         onSuccess:@selector(successCallBack:)  
                                         onFailure:@selector(failureCallBack:)];
}

// 用户时间线
- (void)onGetUserTimelineButtonPressed
{
    [wbEngine getUserTimelineWithFormat:@"json"
                               pageFlag:0 
                               pageTime:0  
                                 reqNum:30 
                                 lastid:@"0"
                                fopenID:nil
                                   name:wbEngine.name
                                   type:0 
                         andContentType:0 
                            parReserved:nil
                               delegate:self
                              onSuccess:@selector(successCallBack:) 
                              onFailure:@selector(failureCallBack:)];
}
   

// 话题时间线  
- (void)onGetHTTimelineButtonPressed
{
    [wbEngine gethtTimelineWithFormat:@"json"
                               reqNum:30 
                              tweetID:@"0"  
                                 time:@"0" 
                             pageFlag:0
                                 flag:0
                               htText:@"0"
                                 htID:@"4303851444892292538"
                                 type:1 
                       andContentType:4 
                          parReserved:nil
                             delegate:self
                            onSuccess:@selector(successCallBack:) 
                            onFailure:@selector(failureCallBack:)];
}

//获取用户信息
- (void)onGetUserInfoButtonPressed
{
    [wbEngine getUserInfoWithFormat:@"json"
                        parReserved:nil
                           delegate:self 
                          onSuccess:@selector(successCallBack:) 
                          onFailure:@selector(failureCallBack:)];
}

//获取他人信息
- (void)onGetOtherInfoButtonPressed
{
    [wbEngine getOtherUserInfoWithFormat:@"json"
                                    name:@"api_weibo"
                                 andOpenID:@"EBD628F6739AA512CEA4763D81CBE336"
                             parReserved:nil
                                delegate:self 
                               onSuccess:@selector(successCallBack:)
                               onFailure:@selector(failureCallBack:)];
}

//获取一批人信息
- (void)onGetInfosButtonPressed
{
    [wbEngine getInfosWithFormat:@"json" 
                          names:@"wangying844488,xiangrikui4389"
                        fopenids:nil
                     parReserved:nil
                       delegate:self 
                      onSuccess:@selector(successCallBack:) 
                      onFailure:@selector(failureCallBack:)];
}

//收听某个用户
- (void)onfriendaddButtonPressed{
    [wbEngine addFriendsWithFormat:@"json"
                             names:@"api_weibo"
                        andOpenIDs:nil
                       parReserved:nil
                          delegate:self 
                         onSuccess:@selector(successCallBack:) 
                         onFailure:@selector(failureCallBack:)];
        
}

//获取偶像列表
- (void)onfriendidollistButtonPressed{
    [wbEngine getFriendIdolListWithFormat:@"json"  
                                   reqNum:30  
                               startIndex:0 
                                  andInstall:0 
                              parReserved:nil
                                 delegate:self                 
                                onSuccess:@selector(successCallBack:)
                                onFailure:@selector(failureCallBack:)];

}

//获取粉丝列表
- (void)onfriendfanslistButtonPressed{
    [wbEngine getFriendFansListWithFormat:@"json" 
                                   reqNum:30 
                               startIndex:0 
                                     mode:0 
                                  install:0 
                                      andSex:0
                              parReserved:nil
                                 delegate:self 
                                onSuccess:@selector(successCallBack:)
                                onFailure:@selector(failureCallBack:)];
    
}

//获取互听列表
- (void)onfriendmutual_listButtonPressed{
    [wbEngine getFriendMutualListWithFormat:@"json"
                                       name:@"sunxiabenqiang"
                                    fopenID:nil
                                     reqNum:30
                                 startIndex:0
                                    andInstall:0
                               parReserved:nil 
                                   delegate:self
                                  onSuccess:@selector(successCallBack:)
                                  onFailure:@selector(failureCallBack:)];
}

- (void)onGetFriendInimate{
    [wbEngine getFriendIntimateListWithFormat:@"json"
                                   andReqNum:20
                              parReserved:nil 
                                 delegate:self 
                                onSuccess:@selector(successCallBack:)
                                onFailure:@selector(failureCallBack:)];
}

//验证好友关系
- (void)onfriendcheckButtonPressed{
    [wbEngine checkFriendWithFormat:@"json"
                                 names:@"wangying844488,xiangrikui4389"
                              fopenIDs:nil 
                               andFlag:2
                           parReserved:nil 
                              delegate:self 
                             onSuccess:@selector(successCallBack:)
                             onFailure:@selector(failureCallBack:)];
}

//转播获取转播列表
- (void)onGetTransWeiboButtonPressed{
    [wbEngine getTransTweetWithFormat:@"json" 
                                 flag:2 
                               rootID:@"112714089895346" 
                             pageFlag:0
                             pageTime:@"0" 
                               reqNum:20 
                         andTweetID:@"57980053806864"
                          parReserved:nil
                             delegate:self
                            onSuccess:@selector(successCallBack:) 
                            onFailure:@selector(failureCallBack:)];
}

//获取身边最新的微博
- (void)onGetlbsNewweiboButtonPressed{
    [wbEngine getAroundNewsWithFormat:@"json"
                         longitude:@"116.24" 
                          latitude:@"39.55" 
                          pageInfo:@"" 
                          andPageSize:25 
                       parReserved:nil
                          delegate:self
                         onSuccess:@selector(successCallBack:) 
                         onFailure:@selector(failureCallBack:)];
    
}

//获取附近的人
- (void)onGetlbsPeopleButtonPressed{
    [wbEngine getAroundPeopleWithFormat:@"json" 
                           longitude:@"116.24"
                            latitude:@"39.55"
                            pageInfo:@"" 
                            pageSize:25
                              andGender:0
                         parReserved:nil
                            delegate:self
                           onSuccess:@selector(successCallBack:) 
                           onFailure:@selector(failureCallBack:)];
    
}

#pragma mark - callback


- (void)successCallBack:(id)result{
    TCGetTimelineController *tlController = [[TCGetTimelineController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tlController];
    tlController.homeDic = (NSDictionary *)result;
    tlController.url = self.url;
    self.url = nil;
    [self presentModalViewController:nav animated:YES];
    [tlController release];
    [nav release];
}

- (void)failureCallBack:(NSError *)error{
    NSLog(@"error: %@", error);
}

@end
