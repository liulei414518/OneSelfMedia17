//
//  TableCell.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-17.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize logoImage;
@synthesize iconImage;
@synthesize blogName;
@synthesize fromLable;
@synthesize timeLine;
@synthesize weiBoData;
@synthesize retranImage;
@synthesize retranCount;
@synthesize discussImage;
@synthesize discussCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        logoImage =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:logoImage];// logo
        iconImage =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:iconImage];//icon
        retranImage =[[UIImageView alloc]initWithFrame:CGRectMake(560, 120, 20, 20)];
        [self.contentView addSubview:retranImage];// 转发
        discussImage =[[UIImageView alloc]initWithFrame:CGRectMake(620, 120, 20, 20)];
        [self.contentView addSubview:discussImage];//评论
        
        blogName=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:blogName];
        fromLable=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:fromLable];
        timeLine=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:timeLine];
        weiBoData=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:weiBoData];
        retranCount=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:retranCount];
        discussCount=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:discussCount];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
