//
//  ViewD.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-5.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCell.h"
#import "ASIHTTPRequest.h"
#import "NSString+URLEncoding.h"
#import "TableData.h"
#import "AppDelegate.h"
#import "DownRefreshView.h"
#import "WeiBoContentView.h"
@interface ViewD : UIView
<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,UIScrollViewDelegate,WeiBoContentViewdelegate>
{
    UITableView* _tableView;

    NSMutableArray* _dataArray;
    TableData * tabData;
    DownRefreshView *downRefresh;// 刷新出现的视图
    WeiBoContentView *weiBoView;
    NSFileManager *fileManager;
     int indexCount;//加载条数
    
    BOOL networkBool;
    UIButton *selectButton;
    UIWebView* blogWebView;//博客试图
}
- (id)initWithFrame:(CGRect)frame;

@property(nonatomic,strong) UITableView* _tableView;
@property(nonatomic,strong)WeiBoContentView *weiBoView;

@end
