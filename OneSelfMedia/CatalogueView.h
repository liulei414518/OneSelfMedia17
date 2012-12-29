//
//  CatalogueView.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-13.
//  Copyright (c) 2012年 EG365. All rights reserved.
//目录

#import <UIKit/UIKit.h>

@protocol indexDelegate <NSObject>

-(void)catalogueIndex;

@end
@interface CatalogueView : UIView
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableView;
    NSMutableArray* TitleArray;
    id <indexDelegate>delegate;
    int count;
}
@property(strong,nonatomic)id <indexDelegate>delegate;
@property(strong,nonatomic)NSMutableArray* TitleArray;
@property(nonatomic)int count;
@end
