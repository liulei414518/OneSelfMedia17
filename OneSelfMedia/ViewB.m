//
//  ViewB.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "ViewB.h"

@implementation ViewB

- (id)initWithFrame:(CGRect)frame withScrllView:(CGSize)newSize
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"hotContentBg.jpg"]];
       //主要滑动视图
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, 724, 670)];
        _scrollView.showsVerticalScrollIndicator=NO;
        [_scrollView setContentSize:newSize];
        _scrollView.backgroundColor=[UIColor clearColor];
        [self addSubview:_scrollView];
        
   //画出每一个视图并加入各个控件*******************
        for (int i=0; i<30; i++) {
          _view=[[UIView alloc]initWithFrame:CGRectMake(30+x*235,30+330*y, 440/2, 577/2)];
          _view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"hotimg.png"]];
            _view.tag=100+i;
             x++;
        if(i%3==2) {
                y++;
                x=0;
        }
        //小图
        _smallImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 45, 193, 230)];
        _smallImageView.image=[UIImage imageNamed:@"image_small.jpg"];
        [_view addSubview:_smallImageView];
          //每个图的名字
            _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,8,130, 25)];
            _TitleLabel.text=@"某某晚报";
            _TitleLabel.textAlignment=UITextAlignmentCenter;
            _TitleLabel.font=[UIFont systemFontOfSize:20];
            _TitleLabel.backgroundColor=[UIColor clearColor];
        [_view addSubview:_TitleLabel];
            
        UITapGestureRecognizer* tapGesture=[[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_view addGestureRecognizer:tapGesture];
            
        [_scrollView addSubview:_view];
            
//      UITapGestureRecognizer* bigtapGesture=[[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigtapAction:)];
//        _bigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(150, 100, 400,500)];
//            _bigImageView.image=_smallImageView.image;
//            _bigImageView.hidden=YES;
 //          _bigImageView.tag=200+i;
//            _bigImageView.userInteractionEnabled=YES;

//            [self addSubview:_bigImageView];
//          [_bigImageView addGestureRecognizer:bigtapGesture];
        }
             [_scrollView setContentSize:CGSizeMake(724, 305*(y+1))];
//**************************************
        
        
       //模糊的view起到模糊背景的效果
        BigView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 724, 670)];
        BigView.backgroundColor=[UIColor blackColor];
        BigView.alpha=0.6;
        BigView.hidden=YES;
        [self addSubview:BigView];
        
        UITapGestureRecognizer* bigtapGesture=[[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigtapAction:)];
        //大图
        _bigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(150, 100, 400,500)];
        _bigImageView.userInteractionEnabled=YES;
        _bigImageView.hidden=YES;
        [self addSubview:_bigImageView];
        [_bigImageView addGestureRecognizer:bigtapGesture];
        
    }
    return self;
}
//每个小图的手势
-(void)tapAction:(UITapGestureRecognizer*)Gesture{
    if (Gesture.state==UIGestureRecognizerStateEnded) {
        NSLog(@"%d",Gesture.view.tag);
        _bigImageView.image=_smallImageView.image;
        _bigImageView.hidden=NO;
        BigView.hidden=NO;
    }
}
//每个大图的手势
-(void)bigtapAction:(UITapGestureRecognizer*)Gesture{
      if (Gesture.state==UIGestureRecognizerStateEnded) {
            NSLog(@"%d",Gesture.view.tag);
          _bigImageView.hidden=YES;
          BigView.hidden=YES;
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
