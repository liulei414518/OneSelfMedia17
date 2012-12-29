//
//  LoadViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "LoadViewController.h"
#import "MainViewController.h"
@interface LoadViewController ()

@end

@implementation LoadViewController

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.jpg"]];

	
   [self performSelector:@selector(mainView) withObject:self afterDelay:0];
}
-(void)mainView{
    MainViewController* main=[[MainViewController alloc]init];
    main.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
  
    [self presentModalViewController:main animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//支持旋转
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
