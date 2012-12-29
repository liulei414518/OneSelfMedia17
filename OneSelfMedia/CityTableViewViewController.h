//
//  CityTableViewViewController.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-6.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cityDelegate<NSObject>
-(void)customCityID;
@end
@interface CityTableViewViewController : UIViewController

<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
    
    NSMutableArray* city_array;//城市名称
    
    NSMutableArray* number;//城市代码
    id<cityDelegate>delegate;
}
@property(strong,nonatomic)id<cityDelegate>delegate;
@property(strong,nonatomic)NSString* CityName;
@property(strong,nonatomic)NSString* CityID;
@end
