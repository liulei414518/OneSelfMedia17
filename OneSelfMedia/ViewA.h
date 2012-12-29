//
//  ViewA.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"
#import "SizeSliderViewController.h"
#import "SinaOperator.h"
#import "TCWBEngine.h"
#import "WBEngine.h"
#import "TableViewController.h"
#import "ShareWordView.h"
#import "WriteRemarkView.h"
@interface ViewA : UIView
<SizeChangeDelegate,WriteDelegate,ShareWordDelegate>
{
    UILabel* _titlelabel;
    
    UIImageView* _BigImageVIew;
    UIView* bgView;
    UIWebView* _contentView;
    int textSize;
    int count;
    UIButton* button;
    
    UIButton* commentButton;
    CommentView* _commentView;
    UIPopoverController* popover;
    ShareWordView *_shareWordView;//分享文章的view
    WriteRemarkView *_writeRemarkView;//撰写评论的view
    TCWBEngine  *weiboEngine;
    WBEngine *_engine;
}

@property(strong,nonatomic)UILabel* titlelabel;
@property(strong,nonatomic)UIImageView* Imageview;
@property(strong,nonatomic)UIWebView* contentView;
@property(strong,nonatomic) TCWBEngine *weiboEngine;
- (id)initWithFrame:(CGRect)frame withScrollView:(CGSize)NewSize withTitle:(CGRect)titleFarme withImageView:(CGRect)ImageViewFrame withContent:(CGRect)contentFrame;
@end
