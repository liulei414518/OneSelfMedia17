//
//  ShareWordView.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-21.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShareWordDelegate <NSObject>

-(void)ShareWorddelegate;

@end
@interface ShareWordView : UIView
<UITextViewDelegate>
{
    UIView *ShareBgView;
    UITextView* textView;
    id<ShareWordDelegate>delegate;
    
    int count;
}
@property(strong,nonatomic)UIView *ShareBgView;
@property(strong,nonatomic)id<ShareWordDelegate>delegate;

@end
