//
//  CommentView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

- (id)initWithFrame:(CGRect)frame withTableView:(CGRect)tableViewframe
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Commentlistbg.png"]];
        _tableView=[[UITableView alloc]initWithFrame:tableViewframe];
        [self addSubview:_tableView];
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
