//
//  WriteRemarkView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-21.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "WriteRemarkView.h"

@implementation WriteRemarkView
@synthesize bgView,delegate;
- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.hidden=YES;
        bgView.alpha=0.7;
        [self addSubview:bgView];
        
        UIView* textBgView=[[UIView alloc]initWithFrame:CGRectMake(160, 115,1457/2, 1352/2)];
        textBgView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Commentbg.png"]];
        [self addSubview:textBgView];
        
        UIButton* sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame=CGRectMake(660, 5, 86/2, 61/2);
        [sendButton setImage:[UIImage imageNamed:@"Commentbtn2.png"] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [textBgView addSubview:sendButton];
        NSLog(@"%@",sendButton);
        
        UIButton* closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame=CGRectMake(20, 5, 86/2,61/2 );
        [closeButton setImage:[UIImage imageNamed:@"Commentbtn2.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [textBgView addSubview:closeButton];
        
        UITextView* textView=[[UITextView alloc]initWithFrame:CGRectMake(20, 60, textBgView.frame.size.width-60, textBgView.frame.size.height-80)];
        textView.backgroundColor=[UIColor clearColor];
        textView.delegate=self;
        textView.font=[UIFont systemFontOfSize:26];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        textView.scrollEnabled=YES;
        [textBgView addSubview:textView];
        
        for (int i=0; i<50; i++) {
            UIImageView* lineImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Commentline.png"]];
            lineImage.frame=CGRectMake(0,38+textView.font.lineHeight*i, 1319/2,1);
            [textView addSubview:lineImage];
        }
    }
    return self;
}
-(void)sendButtonAction{
    NSLog(@"---------");
     [self.delegate sendMassage:sendText];
}
-(void)closeButtonAction{
    [self.delegate writedelegate];
}
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"---%d",textView.selectedRange.location);  
     sendText=textView.text;
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
