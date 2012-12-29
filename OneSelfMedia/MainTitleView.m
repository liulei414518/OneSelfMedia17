//
//  MainTitleView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-30.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "MainTitleView.h"

@implementation MainTitleView
@synthesize dateLabel=_dateLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"head.png"]];

        _dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 52, 180, 25)];
        _dateLabel.font=[UIFont systemFontOfSize:15];
        _dateLabel.textColor=[UIColor whiteColor];
        _dateLabel.textAlignment=UITextAlignmentCenter;
        _dateLabel.text=@"2012-11-19  第192期";
        _dateLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:_dateLabel];

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
