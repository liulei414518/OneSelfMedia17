//
//  TableCell.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-17.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *blogName;
@property (strong, nonatomic) IBOutlet UILabel *fromLable;
@property (strong, nonatomic) IBOutlet UILabel *timeLine;
@property (strong, nonatomic) IBOutlet UILabel *weiBoData;
@property (strong, nonatomic) IBOutlet UIImageView *retranImage;
@property (strong, nonatomic) IBOutlet UILabel *retranCount;
@property (strong, nonatomic) IBOutlet UIImageView *discussImage;
@property (strong, nonatomic) IBOutlet UILabel *discussCount;

@end
