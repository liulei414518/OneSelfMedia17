//
//  WeiBoCell.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-17.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiBoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UILabel *blogName;
@property (strong, nonatomic) IBOutlet UILabel *blogContent;
@property (strong, nonatomic) IBOutlet UIImageView *articleImage;
@end
