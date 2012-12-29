//
//  WriteRemarkView.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-21.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WriteDelegate <NSObject>

-(void)writedelegate;
-(void)sendMassage:(NSString*)str;
@end
@interface WriteRemarkView : UIView
<UITextViewDelegate>
{
    UIView* bgView;
    id<WriteDelegate>delegate;
    NSString* sendText;
}
@property(strong,nonatomic)UIView* bgView;
@property(strong,nonatomic)id<WriteDelegate>delegate;
@end
