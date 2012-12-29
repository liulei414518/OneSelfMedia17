//
//  TableViewController.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-5.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "WBSendView.h"
#import "TCWBEngine.h"
#import "AppDelegate.h"
#import "ZhuCeViewController.h"
#import "DengluViewController.h"
@interface TableViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,WBEngineDelegate,TCWBRequestDelegate,RenrenDelegate,WBSendViewDelegate>
{
    UITableView* _tabelView;
    UIButton* Sinabutton;
    UIButton* Wangbutton;
    UIButton* Txbutton;
    UIButton* Renbutton;
    WBEngine* _engine;
    TCWBEngine* weiboEngine;
    UIActivityIndicatorView     *indicatorView;
    NSMutableDictionary* weiboDcitionary;//存储微博绑定,解绑状态
    NSString* filename;
}
@property (nonatomic, strong) TCWBEngine   *weiboEngine;
+(TableViewController*)shareTableView;
-(void)sinaAction;
-(void)shareTCWeiBo;
-(BOOL)sinaIsLogin;
- (void)showAlertMessage:(NSString *)msg;
@end
