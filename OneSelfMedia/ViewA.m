//
//  ViewA.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "ViewA.h"

@implementation ViewA
@synthesize titlelabel=_titlelabel,Imageview=_ImageView,contentView=_contentView,weiboEngine;
- (id)initWithFrame:(CGRect)frame withScrollView:(CGSize)NewSize withTitle:(CGRect)titleFarme withImageView:(CGRect)ImageViewFrame withContent:(CGRect)contentFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ContentBg.png"]];
        _titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 40, 600, 50)];
        _titlelabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:35];
        _titlelabel.textAlignment=UITextAlignmentCenter;
        _titlelabel.backgroundColor=[UIColor clearColor];
        _titlelabel.shadowColor=[UIColor lightGrayColor];
        [self addSubview:_titlelabel];
        //内容
        _contentView=[[UIWebView alloc]initWithFrame:CGRectMake(20, 103, 704, 510)];
        //_contentView.scrollView.scrollEnabled=NO;
        _contentView.scrollView.showsVerticalScrollIndicator=NO;
        [_contentView setOpaque:NO];
        _contentView.backgroundColor=[UIColor clearColor];
        [self addSubview:_contentView];
        //评论按钮
        commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        commentButton.frame=CGRectMake(635, 20, 80, 50);
        [commentButton setImage:[UIImage imageNamed:@"Commentbtn.png"] forState:UIControlStateNormal];
        [commentButton addTarget:self action:@selector(commentButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:commentButton];
        
        NSArray* array=[NSArray arrayWithObjects:@"Actionbtn1.png",@"Actionbtn2.png",@"Actionbtn3.png", nil];
        for (int i=0; i<[array count]; i++) {
            button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
            button.frame=CGRectMake(550+i*50, 5, 67/2, 52/2);
            button.tag=100+i;
           [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        bgView=[[UIView alloc]initWithFrame:frame];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.7;
        bgView.hidden=YES;
        [self addSubview:bgView];
        
        _BigImageVIew=[[UIImageView alloc]initWithFrame:CGRectMake(10, 100, ImageViewFrame.size.width*1.4, ImageViewFrame.size.height*1.4)];
        _BigImageVIew.hidden=YES;
        _BigImageVIew.userInteractionEnabled=YES;
        [self addSubview:_BigImageVIew];
        UITapGestureRecognizer* bigTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigTapAction)];
        [_BigImageVIew addGestureRecognizer:bigTapGesture];
        _engine=[[WBEngine alloc]initWithAppKey:SinaAppKey appSecret:SinaAppSecret];
        }
    return self;
}

-(void)buttonAction:(UIButton*)bt{
    NSLog(@"--%d",bt.tag);
    if (bt.tag==100) {
        UIButton *btn=bt;
        SizeSliderViewController* sizeSlider=[[SizeSliderViewController alloc]init:0];
        sizeSlider.delegate=self;
        popover=[[UIPopoverController alloc]initWithContentViewController:sizeSlider];

        popover.popoverContentSize=CGSizeMake(200, 35);
        [popover presentPopoverFromRect:btn.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    //分享文章按钮
    if (bt.tag==101) {
        _shareWordView=[[ShareWordView alloc]initWithFrame:CGRectMake(0, 760, 1024, 768)];
        _shareWordView.delegate=self;
        [self.superview.superview addSubview:_shareWordView];
           self.superview.userInteractionEnabled=NO;
        [UIView transitionWithView:self duration:1 options:UIViewAnimationCurveLinear animations:^{
            _shareWordView.frame=CGRectMake(0, 0, 1024,768);
        } completion:^(BOOL finished) {
            _shareWordView.ShareBgView.hidden=NO;
        }];
    }
    if (bt.tag==102) {//撰写评论的按钮
        _writeRemarkView=[[WriteRemarkView alloc]initWithFrame:CGRectMake(0, 760, 1024, 768)];
        _writeRemarkView.delegate=self;
        [self.superview.superview addSubview:_writeRemarkView];
        [UIView transitionWithView:self duration:1 options:UIViewAnimationCurveLinear animations:^{
            _writeRemarkView.frame=CGRectMake(0, 0, 1024,768);
        } completion:^(BOOL finished) {
            _writeRemarkView.bgView.hidden=NO;
        }];

    }
}
#pragma mark writedeRemarkView代理
-(void)writedelegate{
    [UIView transitionWithView:self duration:1 options:UIViewAnimationCurveLinear animations:^{
        _writeRemarkView.bgView.hidden=YES;
        _writeRemarkView.frame=CGRectMake(0, 760, 1024, 768);
    } completion:^(BOOL finished) {
        [_writeRemarkView removeFromSuperview];
    }];
}
#pragma mark ShareWordView 代理
-(void)ShareWorddelegate{
    
    [UIView transitionWithView:self duration:1 options:UIViewAnimationCurveLinear animations:^{
        _shareWordView.ShareBgView.hidden=YES;
        _shareWordView.frame=CGRectMake(0, 760, 1024, 768);
    } completion:^(BOOL finished) {
        [_shareWordView removeFromSuperview];
        self.superview.userInteractionEnabled=YES;
    }];
}
//移除分享的视图
-(void)reMoveShareWordView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _shareWordView.frame=CGRectMake(0, 680, 724, 620);
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView commitAnimations];
}
-(void)sinaShare{
    if ([[TableViewController shareTableView]sinaIsLogin]) {
        NSLog(@"100");
        [_engine isLoggedIn];
        NSLog(@"_engine.accessToken =%@",_engine.accessToken);
    } 
     NSLog(@"101");
    [[SinaOperator sharedSinaWeiboOperator] ShareFixedContent:@"111"];
    
}
-(void)TCshare
{
    NSLog(@"TCshare =");
    [[TableViewController shareTableView]shareTCWeiBo];
//  [weiboEngine UIBroadCastMsgWithContent:@"" andImage:[UIImage imageNamed:@""] parReserved:nil delegate:self onPostStart:@selector(postStart) onPostSuccess:@selector(createSuccess:) onPostFailure:@selector(createFail:)];
}
//字体大小
-(void)sizeChange:(float)size{
    [[NSUserDefaults standardUserDefaults]setFloat:size forKey:@"value"];
    NSLog(@"=====%f",size);
    NSString* s =[[NSString stringWithFormat:@"%f",size]stringByAppendingString:@"%"];
    NSString *str =[NSString stringWithFormat: @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",s];
    [_contentView stringByEvaluatingJavaScriptFromString:str];

}

-(void)commentButtonAction{
    if (count%2==0) {
        //评论视图
        _commentView=[[CommentView alloc]initWithFrame:CGRectMake(760,30,1298/2,1213/2) withTableView:CGRectMake(40, 50,580, 510)];
        [self addSubview:_commentView];
        
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            commentButton.frame=CGRectMake(0, 20, 80, 50);
            _commentView.frame=CGRectMake(commentButton.frame.origin.x+100, 30, 1298/2,1213/2);
        } completion:nil];
    }else{
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            commentButton.frame=CGRectMake(635, 20, 80, 50);
            _commentView.frame=CGRectMake(commentButton.frame.origin.x+130, 30, 1298/2,1213/2);
        } completion:^(BOOL finished) {
            [_commentView removeFromSuperview];
        }];
    }
    count++;
}

-(void)tapAction{
    bgView.hidden=NO;
    _BigImageVIew.hidden=NO;
    _BigImageVIew.image=_ImageView.image;
}
-(void)bigTapAction{
    bgView.hidden=YES;
    _BigImageVIew.hidden=YES;
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
