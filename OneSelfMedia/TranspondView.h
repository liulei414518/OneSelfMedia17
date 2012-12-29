//
//  TranspondView.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//
//转载的视图
#import <UIKit/UIKit.h>
@protocol TranspondDelegate <NSObject>

-(void)closeTextView;
-(void)tranSpondText:(NSString*)str;
@end

@interface TranspondView : UIView<UITextViewDelegate>
{
    UITextView *_textView;
    id<TranspondDelegate>delegate;
    NSString* sendText;
}
@property(strong,nonatomic)id<TranspondDelegate>delegate;
@property(nonatomic,strong) UITextView *_textView;
@end