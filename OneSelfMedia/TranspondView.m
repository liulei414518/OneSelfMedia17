//
//  TranspondView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "TranspondView.h"

@implementation TranspondView
@synthesize delegate,_textView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.7;
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(5, 50, 400, 300)];
        _textView.delegate=self;
        
        UIView *backView= [[UIView alloc]initWithFrame:CGRectMake(200, 100, 600, 400)];
        backView.backgroundColor=[UIColor redColor];
        
        UIButton* closeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        closeBtn.frame=CGRectMake(10, 5, 60, 30);
        [closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:closeBtn];
        
        UIButton* sendBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sendBtn setTitle:@"转发" forState:UIControlStateNormal];
        sendBtn.frame=CGRectMake(530, 5, 60,30);
        [sendBtn addTarget:self action:@selector(sendBtn) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:sendBtn];
        [backView addSubview:_textView];
        [self addSubview:backView];
        
       
    }
    return self;
}
-(void)closeView
{
    NSLog(@"21111");
    [delegate closeTextView];
}
-(void)sendBtn
{

    [delegate tranSpondText:sendText];

}
- (void)textViewDidChange:(UITextView *)textView
{
    sendText=textView.text;
}


@end
