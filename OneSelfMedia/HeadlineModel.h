//
//  HeadlineModel.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-29.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadlineModel : NSObject
{
    UIImageView* smallImage;
    
    UIImageView* bigImage;
   
    UILabel* titleLabel;
}
@property(strong,nonatomic) UIImageView* smallImage;
@property(strong,nonatomic) UIImageView* bigImage;
@property(strong,nonatomic) UILabel* titleLabel;
@end
