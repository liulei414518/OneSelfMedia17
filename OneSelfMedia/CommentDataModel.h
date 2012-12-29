//
//  CommentDataModel.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-20.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentDataModel : NSObject
{
    NSString *creatTime;
    NSString* text;
    NSString* sourceFrom;
    NSString* userImage;
    NSString*userName;
    
}
@property(nonatomic,strong)NSString *creatTime;
@property(nonatomic,strong) NSString* text;
@property(nonatomic,strong)NSString* sourceFrom;
@property(nonatomic,strong)NSString* userImage;
@property(nonatomic,strong) NSString*userName;
@end
