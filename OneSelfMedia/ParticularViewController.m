//
//  ParticularViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-29.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "ParticularViewController.h"

@interface ParticularViewController ()

@end

@implementation ParticularViewController
@synthesize glideCount,bgView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)init:(int)glideValue{
    
    glideCount=glideValue;
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"photorunBg.jpg"]];
    
    backbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:[UIImage imageNamed:@"Pullingbtn.png"] forState:UIControlStateNormal];
    backbutton.frame=CGRectMake(458, 20, 214/2, 43/2);
    [backbutton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    NSArray* array=[NSArray arrayWithObjects:@"Actionbtn1.png",@"Actionbtn2.png",@"Actionbtn3.png", nil];
    for (int i=0; i<[array count]; i++) {
        button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
        button.frame=CGRectMake(800+i*60, 10, 67/2, 52/2);
        button.tag=100+i;
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    //数据数组
   _dataArray=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",nil];
    _catalogueView=[[CatalogueView alloc]initWithFrame:CGRectMake(0, 45, 534/2, 768-50)];
    _catalogueView.delegate=self;
    _catalogueView.TitleArray=_dataArray;
    [self.view addSubview:_catalogueView];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(271, 45, 750, 705)];
    _scrollView.scrollEnabled=NO;
    
    [_scrollView setContentSize:CGSizeMake(750, 705*[_dataArray count])];
    [_scrollView setContentOffset:CGPointMake(0, glideCount*705)];


    [self.view addSubview:_scrollView];

    //内容文字
    for (int i=0; i<_dataArray.count; i++) {
        _contentWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, i*705, 750, 705)];
        _contentWebView.scrollView.delegate=self;

        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
        [_contentWebView loadRequest:request];

        _contentWebView.backgroundColor=[UIColor clearColor];
        [_contentWebView setOpaque:NO];
        [self sizeChange:100];
        _contentWebView.tag=i+300;
        [_scrollView addSubview:_contentWebView];
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        label.text=[_dataArray objectAtIndex:i];
        label.backgroundColor=[UIColor clearColor];
        [_contentWebView addSubview:label];
        
       [self upRefresh:i];
       [self downRefresh:i];
    }
    
    //阴影
    _BgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    _BgView.backgroundColor=[UIColor blackColor];
    _BgView.alpha=0.6;
    _BgView.hidden=YES;
    [self.view addSubview:_BgView];
    //评论按钮
    commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame=CGRectMake(950, 120, 175/2, 81/2);
    [commentButton setImage:[UIImage imageNamed:@"Commentbtn.png"]  forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(commentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentButton];

   //大图
   _BigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(200, 100, 600,550 )];
   _BigImageView.userInteractionEnabled=YES;
   _BigImageView.hidden=YES;
   [self.view addSubview:_BigImageView];
    
    UITapGestureRecognizer* bigTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigtapAction:)];
    [_BigImageView addGestureRecognizer:bigTapGesture];
    
    
    
}
//上更新提示
-(void)upRefresh:(int)i{
    _upRefresh=[[UPRefreshView alloc]initWithFrame:CGRectMake(100, -50, 200, 50)];
    if (i==0) {
        _upRefresh.label.text=@"没有了!";
    }else{
        _upRefresh.label.text=[NSString stringWithFormat:@"上一篇 %@",[_dataArray objectAtIndex:i-1]];
    }
    [_contentWebView.scrollView insertSubview:_upRefresh atIndex:0];
}
//下更新提示
-(void)downRefresh:(int)i{
    _downRefresh=[[DownRefreshView alloc]initWithFrame:CGRectMake(100, _contentWebView.scrollView.contentSize.height+10, 200, 50)];
    _downRefresh.tag=i+500;
    if (i==_dataArray.count-1) {
        _downRefresh.label.text=@"没有了!";
    }else{
        _downRefresh.label.text=[NSString stringWithFormat:@"下一篇： %@",[_dataArray objectAtIndex:i+1]];
    }
    [_contentWebView.scrollView insertSubview:_downRefresh atIndex:0];
}
//-(void)tapAction:(UITapGestureRecognizer*)Gesture{
//    if (Gesture.state==UIGestureRecognizerStateEnded) {
//        _BgView.hidden=NO;
//        _BigImageView.hidden=NO;
////        _BigImageView.image=_imageView.image;
//    }
//}
//-(void)bigtapAction:(UITapGestureRecognizer*)Gesture{
//    if (Gesture.state==UIGestureRecognizerStateEnded) {
//        _BgView.hidden=YES;
//        _BigImageView.hidden=YES;
//    }
//}
-(void)buttonAction:(UIButton*)bt{
     UIButton *btn=bt;
    if (bt.tag==100) {
        SizeSliderViewController* sizeSlider=[[SizeSliderViewController alloc]init:1];
        sizeSlider.delegate=self;
        _popover=[[UIPopoverController alloc]initWithContentViewController:sizeSlider];
        _popover.popoverContentSize=CGSizeMake(200, 35);
        [_popover presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    if (bt.tag==101) {
        _shareWordView=[[ShareWordView alloc]initWithFrame:CGRectMake(0, 768, 1024, 768)];
        _shareWordView.delegate=self;
        [self.view addSubview:_shareWordView];
        [UIView transitionWithView:self.view duration:1 options:UIViewAnimationCurveLinear animations:^{
            _shareWordView.frame=CGRectMake(0, 0, 1024, 768);
        } completion:^(BOOL finished) {
                  _shareWordView.ShareBgView.hidden=NO;
        }];
    }
    if (bt.tag==102) {
        _writeRemarkView=[[WriteRemarkView alloc]initWithFrame:CGRectMake(0, 768, 1024, 768)];
        _writeRemarkView.delegate=self;
        [self.view addSubview:_writeRemarkView];
        [UIView transitionWithView:self.view duration:1 options:UIViewAnimationCurveLinear animations:^{
            _writeRemarkView.frame=CGRectMake(0, 5, 1024, 768);
        } completion:^(BOOL finished) {
            _BgView.hidden=NO;
        }];
    }
}
-(void)ShareWorddelegate{
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationCurveLinear animations:^{
        _shareWordView.ShareBgView.hidden=YES;
        _shareWordView.frame=CGRectMake(0, 760, 1024,768);
    } completion:^(BOOL finished) {
        [_shareWordView removeFromSuperview];
    }];
}
-(void)writedelegate{
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationCurveLinear animations:^{
        _BgView.hidden=YES;
        _writeRemarkView.frame=CGRectMake(0, 760, 1024,768);
    } completion:^(BOOL finished) {
        [_writeRemarkView removeFromSuperview];
    }];
}
//字体大小SizeSliderViewController的代理
-(void)sizeChange:(float)size{
    for (int i=0 ; i<_dataArray.count; i++) {

        UIWebView *webView= (UIWebView*)[_scrollView viewWithTag:300+i];
        [[NSUserDefaults standardUserDefaults]setFloat:size forKey:@"value2"];
        NSString* s =[[NSString stringWithFormat:@"%f",size]stringByAppendingString:@"%"];
        NSString *str =[NSString stringWithFormat: @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",s];
        [webView stringByEvaluatingJavaScriptFromString:str];
    }
}
//评论滑动按钮
-(void)commentButtonAction{
    if (count%2==0) {
        //评论视图
        _commentView=[[CommentView alloc]initWithFrame:CGRectMake(1024,45,1298/2,1213/2) withTableView:CGRectMake(40, 50,580, 510)];
        [self.view addSubview:_commentView];
        [self commentAnimation:265:NO];
    }else{
        [self commentAnimation:950:YES];
    }
    count++;
}
//评论界面的动画
-(void)commentAnimation:(int)x:(BOOL)isbool{
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        commentButton.frame=CGRectMake(x, 120, 80, 50);
        _commentView.frame=CGRectMake(commentButton.frame.origin.x+80, 45, 1298/2,1213/2);
    } completion:^(BOOL finished) {
         _BgView.hidden=NO;
        if (isbool) {
            _BgView.hidden=YES;
              [_commentView removeFromSuperview];
        }
    }];
}
//返回按钮
-(void)backButtonAction{

    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIWebView.ScrollView
// 拖动结束后
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_scrollView.contentOffset.y==0) {
        [self contentViewDownAction:scrollView];
    }else
    if (_scrollView.contentOffset.y>=660*([_dataArray count]-1)) {
        [self contentViewUpAction:scrollView];
    }else{
        [self contentViewUpAction:scrollView];
        [self contentViewDownAction:scrollView];
    }
    //当前webView的高减去当前WebView的滑动y的位置
      NSLog(@"=========%f",scrollView.contentSize.height-scrollView.contentOffset.y);
    
    //根据每个WebVIew的高度 动态改变Downrefresh的y
    for (int i=0; i<_dataArray.count; i++) {
        UIView* view=(UIView*)[scrollView viewWithTag:i+500];
        view.frame=CGRectMake(100,scrollView.contentSize.height, 200, 50);
//        NSLog(@"%f",view.frame.origin.y);
    }
}
#pragma ------------------------------

//切换内容向上滑动
-(void)contentViewUpAction:(UIScrollView*)scrollView{
    
    if (scrollView.contentSize.height-scrollView.contentOffset.y>scrollView.contentSize.height+80) {
        glideCount--;
        [_scrollView setContentOffset:CGPointMake(0,glideCount*705) animated:YES];
    }
}
//切换内容向下滑动
-(void)contentViewDownAction:(UIScrollView*)scrollView{
    if (scrollView.contentSize.height-scrollView.contentOffset.y<=610) {
        glideCount++;
        [_scrollView setContentOffset:CGPointMake(0,glideCount*705) animated:YES];
    }
}

-(void)catalogueIndex{
    glideCount=_catalogueView.count;
    [_scrollView setContentOffset:CGPointMake(0,glideCount*705)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
