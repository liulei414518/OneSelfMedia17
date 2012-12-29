//
//  ViewB.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewB : UIView
{
    UIScrollView* _scrollView;
    UIView* _view;
    UIImageView* _smallImageView;
    UIImageView* _bigImageView;
    UIView* BigView;
    UILabel* _TitleLabel;
    NSMutableArray* _imageArray;//图片数组
    NSMutableArray* _titleArray;//名字
    
    int x;
    int y;
}

- (id)initWithFrame:(CGRect)frame withScrllView:(CGSize)newSize;
@end
