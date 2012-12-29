//
//  commentCell.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-25.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentCell : UITableViewCell
{
    UIImageView *logoImageView;
    UILabel* blogText;
    UILabel* blogFrom;

}
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UILabel *blogText;
@property (strong, nonatomic) IBOutlet UILabel *blogFrom;


@end
