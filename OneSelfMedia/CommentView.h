//
//  CommentView.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView

{
    UITableView* _tableView;
}
- (id)initWithFrame:(CGRect)frame withTableView:(CGRect)tableViewframe;
@end
