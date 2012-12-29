//
//  WeiBoCell.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-17.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "WeiBoCell.h"

@implementation WeiBoCell
@synthesize logoImage;
@synthesize blogName;
@synthesize blogContent;
@synthesize articleImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        logoImage =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:logoImage];
        articleImage =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:articleImage];
        blogName =[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:blogName];
        blogContent =[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:blogContent];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
