//
//  CalendarViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-18.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

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
	calendar=[[CKCalendarView alloc]initWithStartDay:startMonday];
    calendar.delegate=self;
    calendar.frame=CGRectMake(0, 10, 400, 400);
    [calendar setTitleFont:[UIFont systemFontOfSize:40]];
    [calendar setDateFont:[UIFont systemFontOfSize:40]];
    [self.view addSubview:calendar];
}
-(void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date{
    
    ;
    NSString* sss=[NSString stringWithFormat:@"%@",date];
    [self string:sss];
}
-(void)string:(NSString*)string{
    
    NSString* date=[string substringToIndex:11];
    NSLog(@"=========%@",date);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
