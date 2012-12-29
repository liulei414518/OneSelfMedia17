//
//  ParticularViewController.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-29.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"
#import "SizeSliderViewController.h"
#import "WriteRemarkView.h"
#import "CatalogueView.h"
#import "UpRefreshView.h"
#import "DownRefreshView.h"
@interface ParticularViewController : UIViewController
<SizeChangeDelegate,UIScrollViewDelegate,indexDelegate,WriteDelegate>
{
    UIButton* button;
    UIButton* backbutton;
    UIButton* commentButton;
    UITableView* _tableView;

    UIScrollView* _scrollView;
    UIWebView* _contentWebView;
    NSMutableArray* _dataArray;
    int glideCount;
//    UIImageView* _imageView;
    
    UIView* _BgView;
    UIImageView* _BigImageView;
    CommentView* _commentView;
    int count;
    UIPopoverController* _popover;
    CatalogueView* _catalogueView;
    
    WriteRemarkView* _writeRemarkView;
    
    UPRefreshView* _upRefresh;
    DownRefreshView* _downRefresh;
}
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic)int glideCount;
-(id)init:(int)glideValue;
@end
