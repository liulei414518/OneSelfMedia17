//
//  DengluViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "DengluViewController.h"

@interface DengluViewController ()

@end

@implementation DengluViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"登陆";
    self.view.backgroundColor=[UIColor lightGrayColor];
	nameField=[[UITextField alloc]initWithFrame:CGRectMake(5, 30, 290, 50)];
    nameField.borderStyle=UITextBorderStyleRoundedRect;
    nameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    nameField.placeholder=@"请输入邮箱";
    UILabel* nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 60, 50)];
    nameLabel.text=@"账号:";
    nameLabel.textAlignment=UITextAlignmentCenter;
    nameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    nameLabel.backgroundColor=[UIColor clearColor];
    nameField.leftView=nameLabel;
    nameField.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:nameField];
    
    passWordField=[[UITextField alloc]initWithFrame:CGRectMake(5, 90, 290, 50)];
    passWordField.borderStyle=UITextBorderStyleRoundedRect;
    passWordField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    passWordField.placeholder=@"请输入密码";
    [self.view addSubview:passWordField];
    UILabel* passWordLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
    passWordLabel.text=@"密码:";
    passWordLabel.textAlignment=UITextAlignmentCenter;
    passWordLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    passWordLabel.backgroundColor=[UIColor clearColor];
    passWordField.leftView=passWordLabel;
    passWordField.leftViewMode=UITextFieldViewModeAlways;
    
    UIButton* dengluButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dengluButton setTitle:@"登陆" forState:UIControlStateNormal];
    dengluButton.frame=CGRectMake(200, 150, 50, 50);
    
    [self.view addSubview:dengluButton];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
