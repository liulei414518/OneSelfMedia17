//
//  commentCell.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-25.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "commentCell.h"

@implementation commentCell

@synthesize blogFrom,blogText,logoImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        logoImageView =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:logoImageView];// logo
        blogFrom=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:blogFrom];
        blogText=[[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:blogText];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
