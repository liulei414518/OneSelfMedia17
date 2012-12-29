//
//  ViewC.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//
//*****图解*****
#import "ViewC.h"

@implementation ViewC
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame withScrollView:(CGSize)NewSize
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"photoContentBg.jpg"]];
        _dataArray=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",nil];
        
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, 724, 670)];
        _scrollView.showsVerticalScrollIndicator=NO;
//        [_scrollView setContentSize:NewSize];
        _scrollView.backgroundColor=[UIColor clearColor];
        [self addSubview:_scrollView];
        
        for (int i=0; i<_dataArray.count; i++) {
            _view=[[UIView alloc]initWithFrame:CGRectMake(20+x*239,20+320*y, 452/2, 577/2)];
            _view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"photoimg.png"]];
     
            x++;
            if(i%3==2) {
                y++;
                x=0;
            }
            [_scrollView addSubview:_view];
            _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(6, 6, 213, 190)];
            _imageView.image=[UIImage imageNamed:@"diagram.jpg"];
            _imageView.tag=i;
            _imageView.userInteractionEnabled=YES;
            [_view addSubview:_imageView];
            
            _introLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, 220, 50)];
            _introLabel.text=@"图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取图说文字截取";
            _introLabel.textAlignment=UITextAlignmentCenter;
            _introLabel.lineBreakMode=UILineBreakModeTailTruncation;
            _introLabel.numberOfLines=2;
            _introLabel.backgroundColor=[UIColor clearColor];
            [_view addSubview:_introLabel];
            
            button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"photoicon1.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"photoicon1Hover.png"] forState:UIControlStateSelected];
            button.frame=CGRectMake(100, 257, 29, 29);
            [_view addSubview:button];
            
            UIButton* pinlun=[UIButton buttonWithType:UIButtonTypeCustom];
            pinlun.frame=CGRectMake(150, 257, 29, 29);
            [pinlun setImage:[UIImage imageNamed:@"photoicon2.png"] forState:UIControlStateNormal];
            [pinlun setImage:[UIImage imageNamed:@"photoicon2Hover.png"] forState:UIControlStateHighlighted];
            [_view addSubview:pinlun];
            _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(175, 256, 45, 30)];
            _numLabel.text=@"1234";
            _numLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            _numLabel.textColor=[UIColor grayColor];
            _numLabel.textAlignment=UITextAlignmentCenter;
            _numLabel.backgroundColor=[UIColor clearColor];
            [_view addSubview:_numLabel];
            
            UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [_imageView addGestureRecognizer:tapGesture];
        }
  
        [_scrollView setContentSize:CGSizeMake(724, 330*(y+1))];

        
    }
    return self;
}
-(void)tapAction:(UITapGestureRecognizer*)Gesture{
    if (Gesture.state==UIGestureRecognizerStateEnded) {
        NSLog(@"%d",Gesture.view.tag);
        [self.delegate jumpController:Gesture.view.tag];
        
    }
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
