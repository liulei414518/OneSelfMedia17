//
//  ViewC.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol jumpdelegate<NSObject>
-(void)jumpController:(int)glideValue;
@end
@interface ViewC : UIView
{
    
    NSMutableArray* _dataArray;
    UIScrollView* _scrollView;
    UIView* _view;
    UIImageView* _imageView;
    UIButton* button;
    UILabel* _introLabel;
    UILabel* _numLabel;
    
    int x;
    int y;
    id<jumpdelegate>delegate;
}
@property(strong,nonatomic)id<jumpdelegate>delegate;
- (id)initWithFrame:(CGRect)frame withScrollView:(CGSize)NewSize;
@end
