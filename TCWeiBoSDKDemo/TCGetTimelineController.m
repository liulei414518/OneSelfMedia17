//
//  TCGetTimelineController.m
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-8-24.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "TCGetTimelineController.h"
#import "JSON.h"
@implementation TCGetTimelineController

@synthesize homeTextView,homeDic;
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

- (id)init{
    self = [super init];
    if (self) {
        homeDic = [[NSDictionary alloc] init];
    }
    return  self;
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Return Info";  
    homeTextView = [[UITextView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    homeTextView.scrollEnabled = YES;
    homeTextView.text = [NSString stringWithFormat:@"########请求url#######\r%@ \r\r########结果########\r %@", self.url, [homeDic JSONRepresentation]];
    [self.view addSubview:homeTextView];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = back;
    [back release];
//    UIButton *showURL = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 52, 33)];
//	[showURL setTitle:@"链接" forState:UIControlStateNormal];
//	showURL.titleLabel.font = [UIFont systemFontOfSize:14];
//    [showURL setBackgroundImage:[UIImage imageNamed:@"composequxiaobtn.png"] forState:UIControlStateNormal];
//	[showURL addTarget:self action:@selector(btnShowURLClicked) forControlEvents:UIControlEventTouchUpInside];
//	UIBarButtonItem *barLeft = [[UIBarButtonItem alloc] initWithCustomView:showURL];
//	self.navigationItem.rightBarButtonItem = barLeft;
//	[barLeft release];
}

//-(void)btnShowURLClicked {
//    
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [homeTextView release];
    homeTextView = nil;
    [homeDic release];
    homeDic = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITextViewDelegate Methods


@end
