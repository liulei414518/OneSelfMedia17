//
//  ZhuCeViewController.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-27.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuCeViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITextField* _zhanghuTextField;
    UITextField* _passWordTextField;
    UITextField* _affirmTextField;
    UITextField* _nameTextField;
}
@end
