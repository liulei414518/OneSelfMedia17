//
//  ZhuCeViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-27.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "ZhuCeViewController.h"

@interface ZhuCeViewController ()

@end

@implementation ZhuCeViewController

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
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Setloginon.jpg"]];
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"loginbtn.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(30, 8, 124/2, 60/2);
    [button addTarget:self action:@selector(buttonReturn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    _zhanghuTextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 5, 1875/2, 84/2)];
    _zhanghuTextField.borderStyle=UITextBorderStyleNone;
    _zhanghuTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_zhanghuTextField];
    UILabel* zhanghuLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 84/2)];
    zhanghuLabel.text=@"用户账号";
    zhanghuLabel.backgroundColor=[UIColor clearColor];
    zhanghuLabel.textAlignment=UITextAlignmentCenter;
    zhanghuLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    _zhanghuTextField.leftView=zhanghuLabel;
    _zhanghuTextField.leftViewMode=UITextFieldViewModeAlways;
    UILabel* rightzhanghu=[[UILabel alloc]initWithFrame:CGRectMake(300, 5, 200, 84/2)];
    rightzhanghu.text=@"请输入您的常用邮箱";
    rightzhanghu.backgroundColor=[UIColor clearColor];
    rightzhanghu.textColor=[UIColor grayColor];
    _zhanghuTextField.rightView=rightzhanghu;
    _zhanghuTextField.rightViewMode=UITextFieldViewModeAlways;
    
    _passWordTextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 5, 1875/2, 84/2)];
    _passWordTextField.borderStyle=UITextBorderStyleNone;
    _passWordTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UILabel* passWordLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 84/2)];
    passWordLabel.text=@"用户密码";
    passWordLabel.backgroundColor=[UIColor clearColor];
    passWordLabel.textAlignment=UITextAlignmentCenter;
    passWordLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    _passWordTextField.leftView=passWordLabel;
    _passWordTextField.leftViewMode=UITextFieldViewModeAlways;
    UILabel* rightpassWord=[[UILabel alloc]initWithFrame:CGRectMake(300, 5, 200, 84/2)];
    rightpassWord.text=@"请输入6~20数字或字母";
    rightpassWord.backgroundColor=[UIColor clearColor];
    rightpassWord.textColor=[UIColor grayColor];
    _passWordTextField.rightView=rightpassWord;
    _passWordTextField.rightViewMode=UITextFieldViewModeAlways;
    
    
    _affirmTextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 5, 1875/2, 84/2)];
    _affirmTextField.borderStyle=UITextBorderStyleNone;
    _affirmTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UILabel* affirmLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 84/2)];
    affirmLabel.text=@"确认密码";
    affirmLabel.backgroundColor=[UIColor clearColor];
    affirmLabel.textAlignment=UITextAlignmentCenter;
    affirmLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    _affirmTextField.leftView=affirmLabel;
    _affirmTextField.leftViewMode=UITextFieldViewModeAlways;
    UILabel* rightaffirmText=[[UILabel alloc]initWithFrame:CGRectMake(300, 5, 200, 84/2)];
    rightaffirmText.text=@"请重新输入密码";
    rightaffirmText.backgroundColor=[UIColor clearColor];
    rightaffirmText.textColor=[UIColor grayColor];
    _affirmTextField.rightView=rightaffirmText;
    _affirmTextField.rightViewMode=UITextFieldViewModeAlways;
    
    
    _nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 5, 1875/2, 84/2)];
    _nameTextField.borderStyle=UITextBorderStyleNone;
    _nameTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UILabel* nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 84/2)];
    nameLabel.text=@"用户昵称";
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.textAlignment=UITextAlignmentCenter;
    nameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    _nameTextField.leftView=nameLabel;
    _nameTextField.leftViewMode=UITextFieldViewModeAlways;
    UILabel* rightNameText=[[UILabel alloc]initWithFrame:CGRectMake(300, 5, 200, 84/2)];
    rightNameText.text=@"请输入2~8个字符";
    rightNameText.backgroundColor=[UIColor clearColor];
    rightNameText.textColor=[UIColor grayColor];
    _nameTextField.rightView=rightNameText;
    _nameTextField.rightViewMode=UITextFieldViewModeAlways;
    
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(40, 50, 1872/2, 443/2)];
    view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg.png"]];
    [self.view addSubview:view];
    UITableView* tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, 1872/2, 443/2)];
    
    tabelView.dataSource=self;
    tabelView.delegate=self;
    tabelView.scrollEnabled=NO;
    tabelView.backgroundColor=[UIColor clearColor];
    [view addSubview:tabelView];
    
    UIButton* zhucebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    zhucebutton.frame=CGRectMake(40, 280, 1875/2,84/2);
    [zhucebutton setImage:[UIImage imageNamed:@"loginokbtn.png"] forState:UIControlStateNormal];
    [self.view addSubview:zhucebutton];
}
-(void)buttonReturn{
    [self dismissModalViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"cellId";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell==Nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        [cell addSubview:_zhanghuTextField];
    }else
    if (indexPath.row==1) {
        [cell addSubview:_passWordTextField];
    }else
    if (indexPath.row==2) {
            [cell addSubview:_affirmTextField];
    }else{
            [cell addSubview:_nameTextField];
    }
    
    return cell;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
