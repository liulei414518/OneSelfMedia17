//
//  WeiBoContentView.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-18.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableData.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "CommentDataModel.h"
#import "MBProgressHUD.h"
#import "WriteRemarkView.h"
#import "ASIFormDataRequest.h"
#import "TranspondView.h"
@protocol WeiBoContentViewdelegate<NSObject>
-(void)huadongAction;
@end
@interface WeiBoContentView : UIView<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,WriteDelegate,TranspondDelegate>
{
    UITableView *_tableView;//主微博视图
    TableData *tableData;//徐达内的微博数据
    UIView *tranView;//转发的数据
    NSFileManager *fileManager;
    UIView *imageScrollView;//点击图片后放大的试图
    UIImage *weiBoImage;//暂时存放徐达内微博图片
    UIImage* reWeiBoimage;//暂时存放转发的图片
    
    MBProgressHUD *hud;//加载条
    NSMutableArray *_commentArray;//存放评论数据的数组
    
    CommentDataModel *commentData;// 评论的数据
    
    UIImageView* myImage;
    UIImageView*reImage;
    NSMutableArray *logoImageArr;// 临时保存评论的头像
    BOOL blogImageBool;// 自己写的微博图片是否下载完成
    BOOL tranImageBool;// 转载的微博图片是否下载完成
    WriteRemarkView *writeView;
    id<WeiBoContentViewdelegate>delegate;
    ASIHTTPRequest *requestHTTP;//GET请求
    TranspondView *transpondView;// 转发的view
}
@property(strong,nonatomic)id<WeiBoContentViewdelegate>delegate;
@property(strong,nonatomic)TableData *tableData;
@property(strong,nonatomic)UITableView *_tableView;
@property(strong,nonatomic)UIView *tranView;

-(void)requestData:(NSString*)index andCount:(NSString*)count;
-(void) getImageFromURL:(NSString *)fileURL andName:(NSString*)name;
@end
