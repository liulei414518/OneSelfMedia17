//
//  TableData.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-17.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableData : NSObject
{
    NSString *logoImage;
    NSString* articleSmallImage;
    NSString* articleOriginalImage;
    UIImageView *iconImage;
    NSString* blogName;
    NSString* timeline;
    NSString* weiBoFrom;
    NSString*weiBoData;
    NSString* tranWeiBoData;
    NSString*tranWeiBOFrom;
    NSString* tranCount;
    NSString* commentCount;
    NSString* tranTimeLine;
    NSString* tranLogoName;
    NSString* tranSmallImage;
    NSString* tranOriginalImage;
    
    NSString *ID;
    NSString* commentUrl;

}
@property(nonatomic,strong)NSString *logoImage;
@property(nonatomic,strong)NSString *articleSmallImage;
@property(nonatomic,strong)NSString *articleOriginalImage;
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)NSString* blogName;
@property(nonatomic,strong)NSString* timeline;
@property(nonatomic,strong)NSString* tranTimeLine;
@property(nonatomic,strong)NSString* weiBoFrom;
@property(nonatomic,strong)NSString* tranWeiBoData;
@property(nonatomic,strong)NSString*tranWeiBOFrom;
@property(nonatomic,strong)NSString*weiBoData;
@property(nonatomic,strong)NSString* tranCount;
@property(nonatomic,strong)NSString* commentCount;
@property(nonatomic,strong)NSString*tranLogoName;
@property(nonatomic,strong)NSString* tranSmallImage;
@property(nonatomic,strong)NSString* tranOriginalImage;
@property(nonatomic,strong) NSString *ID;
@property(nonatomic,strong) NSString *commentUrl;
@end
