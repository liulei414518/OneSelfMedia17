//
//  DownRefreshView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-14.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "DownRefreshView.h"

@implementation DownRefreshView
@synthesize label;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
