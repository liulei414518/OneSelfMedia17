//
//  SizeSliderViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-7.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "SizeSliderViewController.h"

@interface SizeSliderViewController ()

@end

@implementation SizeSliderViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)init:(int)count{
    tmp=count;
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
	_slider=[[UISlider alloc]initWithFrame:CGRectMake(0, 5, 200, 10)];
    _slider.minimumValue=70;
    _slider.maximumValue=150;

 
    if (tmp==1) {
    _slider.value =[[[NSUserDefaults standardUserDefaults]objectForKey:@"value2"] floatValue];
    }else{
     _slider.value =[[[NSUserDefaults standardUserDefaults]objectForKey:@"value"] floatValue];
//        NSLog(@"---1111-------%@",userDatal.sizeValue);
    }
    
    [_slider addTarget:self action:@selector(sliderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_slider];
}
-(void)sliderAction{
    [self.delegate sizeChange:_slider.value];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
