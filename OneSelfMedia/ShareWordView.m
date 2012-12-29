//
//  ShareWordView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-21.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "ShareWordView.h"

@implementation ShareWordView
@synthesize ShareBgView,delegate;
- (id)initWithFrame:(CGRect)frame
{
//    self.backgroundColor=[UIColor ]
    self = [super initWithFrame:frame];
    if (self) {
        ShareBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        ShareBgView.backgroundColor=[UIColor blackColor];
        ShareBgView.alpha=0.7;
        ShareBgView.hidden=YES;
        [self addSubview:ShareBgView];
        UIButton* closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame=CGRectMake(0, 0, 1024, 768);
       
        [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [ShareBgView addSubview:closeButton];
        
        UIView* textBgView=[[UIView alloc]initWithFrame:CGRectMake(200, 110,1238/2, 741/2)];
        textBgView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ShareBg.png"]];
        [self addSubview:textBgView];
        
        
        textView=[[UITextView alloc]initWithFrame:CGRectMake(37, 98, textBgView.frame.size.width-80, textBgView.frame.size.height-245)];
        textView.delegate=self;
        textView.backgroundColor=[UIColor clearColor];
        textView.font=[UIFont systemFontOfSize:23];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        textView.scrollEnabled=YES;
        [textBgView addSubview:textView];
        
        for (int i=0; i<20; i++) {
            UIImageView* lineImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Commentline.png"]];
            lineImage.frame=CGRectMake(0,35+textView.font.lineHeight*i, 1319/2,1);
            [textView addSubview:lineImage];
        }
        UIButton* sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame=CGRectMake(415, 280, 308/2, 84/2);
        [sendButton setImage:[UIImage imageNamed:@"ShareBtnHover.png"] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [textBgView addSubview:sendButton];
    }
     
    return self;
}
-(void)closeButtonAction{
    if (count==1) {
    [textView resignFirstResponder];
        count=0;
    }else{
    [self.delegate ShareWorddelegate];
        count=1;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    count=1;
}
-(void)sendButtonAction{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
