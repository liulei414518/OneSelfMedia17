//
//  MyCollect.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-30.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "MyCollect.h"

@implementation MyCollect

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mbg.png"]];

        _label=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 250, 150)];
        _label.text=@"我的收藏";
        _label.textAlignment=UITextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:50];
        _label.backgroundColor=[UIColor clearColor];
        [self addSubview:_label];
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
