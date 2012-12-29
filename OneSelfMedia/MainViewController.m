//
//  MainViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "MainViewController.h"
#import "SBJSON.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    
    
    //侧面滑动视图
    _MainSideScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 270, 768)];
//  _MainSideScrollView.backgroundColor=[UIColor redColor];
    _MainSideScrollView.pagingEnabled=YES;
    _MainSideScrollView.scrollEnabled=NO;
    CGSize newSize=CGSizeMake(270, 1180);
    [_MainSideScrollView setContentSize:newSize];
    [_MainSideScrollView setContentOffset:CGPointMake(0, 410)];
    [self.view addSubview:_MainSideScrollView];
    //设置视图
    _SetVIew=[[UIView alloc]initWithFrame:CGRectMake(23/2, 90, 230, 420)];
    _SetVIew.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"SetBg.png"]];
    [_MainSideScrollView addSubview:_SetVIew];
    
    UISwipeGestureRecognizer* upSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upAction)];
    [upSwipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [_SetVIew addGestureRecognizer:upSwipeGesture];
    UISwipeGestureRecognizer* downSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downAction)];
    [downSwipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [_SetVIew addGestureRecognizer:downSwipeGesture];
    NSLog(@"%@",_SetVIew);
    
    
     accountButton=[UIButton buttonWithType:UIButtonTypeCustom];
     accountButton.frame=CGRectMake(5, 30, 220, 40);
    [accountButton setImage:[UIImage imageNamed:@"grzhbtn.png"] forState:UIControlStateNormal];
    [accountButton addTarget:self action:@selector(accuntAction) forControlEvents:UIControlEventTouchUpInside];
    [_SetVIew addSubview:accountButton];
    
    
    _cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 2, 110, 30)];
    _cityLabel.font=[UIFont systemFontOfSize:17];
    _cityLabel.textColor=[UIColor whiteColor];
    _cityLabel.lineBreakMode=UILineBreakModeWordWrap;
    _cityLabel.numberOfLines=2;
    _cityLabel.backgroundColor=[UIColor clearColor];
    
    locationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame=CGRectMake(5, 80, 220, 40);
    [locationButton setImage:[UIImage imageNamed:@"wzxxbtn.png"] forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(loationAction) forControlEvents:UIControlEventTouchUpInside];
    [_SetVIew addSubview:locationButton];
    [locationButton addSubview:_cityLabel];

    
    //初始化GPS
     _gpsCoord=[[GPSCoord alloc]initGps];
    [self getCity];
    
    UIImageView* setImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"adjustBg.png"]];
    setImage.frame=CGRectMake(10, 163, 420/2, 243/2);
    setImage.userInteractionEnabled=YES;
    [_SetVIew addSubview:setImage];
    
    _slider=[[UISlider alloc]initWithFrame:CGRectMake(100, 170, 100, 20)];
    [_slider addTarget:self action:@selector(sliderAction) forControlEvents:UIControlEventValueChanged];
    _slider.value=0.7;
    [_SetVIew addSubview:_slider];
    [self sliderAction];//亮度


    //附属滑动视图
    _SubsidiaryScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 520, 270, 580)];
    _SubsidiaryScrollView.backgroundColor=[UIColor clearColor];
    _SubsidiaryScrollView.showsVerticalScrollIndicator=NO;
    CGSize newSize2=CGSizeMake(270, 768);
    [_SubsidiaryScrollView setContentSize:newSize2];
    [_MainSideScrollView addSubview:_SubsidiaryScrollView];
    
  //------------------------------------------------
    //主内容视图
    _MainView=[[UIView alloc]initWithFrame:CGRectMake(260, 10, 1024-300, 748)];
    _MainView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_MainView];
    _idArray=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",nil];
     _moduleImageArray=[NSArray arrayWithObjects:@"mtzjbtn.png",@"tbbtn.png",@"tjbtn.png",@"jhbtn.png",nil];
    NSArray* selectedImageArray=[NSArray arrayWithObjects:@"mtzjbtnHover.png",@"tbbtnHover.png",@"tjbtnHover.png",@"jhbtnHover.png",nil];
    for (int i=0; i<_moduleImageArray.count; i++) {
         UIButton* button1=[UIButton buttonWithType:UIButtonTypeCustom];

            [button1 setImage:[UIImage imageNamed:[_moduleImageArray objectAtIndex:i]] forState:UIControlStateNormal];
            [button1 setImage:[UIImage imageNamed:[selectedImageArray objectAtIndex:i]] forState:UIControlStateSelected];
            button1.frame=CGRectMake(20+i*200,0 , 182/2, 167/2);
            button1.tag=100+i;
        if(i==0){
            button1.selected=YES;
            selectedButton=button1;
        }
            [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_MainView addSubview:button1];
    }

    
    [self CreateView];
}
-(void)CreateView{
   
//    NSString *path= [[NSFileManager defaultManager]fileExistsAtPath:@"/Users/xujun/desktop/image"];
//    NSLog(@"%@",path);
//    NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
    
    _viewa=[[ViewA alloc]initWithFrame:CGRectMake(0, 90, 1477/2, 1272/2) withScrollView:CGSizeMake(724, 800) withTitle:CGRectMake(200, 20, 300, 50) withImageView:CGRectMake(100, 30, 500, 300) withContent:CGRectMake(10,350, 704,550)];
    _viewa.Imageview.image=[UIImage imageNamed:@"tbg2.png"];
//    _viewa.Imageview.image=[UIImage imageWithContentsOfFile:path];

    _viewa.titlelabel.text=@"文章标题";
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
    [_viewa.contentView loadRequest:request];
    [_viewa sizeChange:100];
    [_MainView addSubview:_viewa];
    
    
    _viewb=[[ViewB alloc]initWithFrame:CGRectMake(0, 90, 1497/2, 1315/2) withScrllView:CGSizeMake(724, 3350)];
    _viewb.hidden=YES;
    [_MainView addSubview:_viewb];
    
    _viewc=[[ViewC alloc]initWithFrame:CGRectMake(0, 90, 1497/2,1315/2) withScrollView:CGSizeMake(724, 1350)];
    _viewc.delegate=self;
    _viewc.hidden=YES;
    [_MainView addSubview:_viewc];
    
    
    _viewd=[[ViewD alloc]initWithFrame:CGRectMake(0, 90, 1489/2, 1226/2)];
    _viewd.hidden=YES;
    [_MainView addSubview:_viewd];

    
    //**左侧滑动视图的模块**
    _mainTitleView=[[MainTitleView alloc]initWithFrame:CGRectMake(23/2, 0, 230, 206/2)];
   
    [self.view addSubview:_mainTitleView];
    
    //设置按钮
    UIButton* setButton=[UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame=CGRectMake(175,20, 30, 30);
    [setButton setImage:[UIImage imageNamed:@"headSETbtn.png"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainTitleView addSubview:setButton];
    //日历按钮
    CalendarButton=[UIButton buttonWithType:UIButtonTypeCustom];
    CalendarButton.frame=CGRectMake(20, 20, 30, 30);
    [CalendarButton setImage:[UIImage imageNamed:@"headRLbtn.png"] forState:UIControlStateNormal];
    [CalendarButton addTarget:self action:@selector(CalendarAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainTitleView addSubview:CalendarButton];
    
    //***左侧副滑动模块**
    //天气模块
    _weatherView=[[WeatherView alloc]initWithFrame:CGRectMake(27/2, 10,453/2, 100)];

    [_SubsidiaryScrollView addSubview:_weatherView];
    
//    [Citydata setObject:@"content" forKey:@"cityName"];
    
    UIView* threeView=[[UIView alloc]initWithFrame:CGRectMake(27/2, 140, 453/2, 400/2)];
    threeView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"FavoriteBG.png"]];
    [_SubsidiaryScrollView addSubview:threeView];
    
    NSArray* threeButtonImage=[NSArray arrayWithObjects:@"FavoriteBtn.png", @"CommentsBtn.png", @"ReplyBtn.png",nil];
    NSArray* selectThree=[NSArray arrayWithObjects:@"FavoriteBtnHoverBg.png",@"CommentsBtnHover.png",@"ReplyBtnHover3.png",nil];
    for (int i=0; i<threeButtonImage.count; i++) {
        UIButton* threeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        threeButton.frame=CGRectMake(0, 20+i*45, 453/2, 80/2);
        threeButton.tag=500+i;
        [threeButton setImage:[UIImage imageNamed:[threeButtonImage objectAtIndex:i]] forState:UIControlStateNormal];
        [threeButton setImage:[UIImage imageNamed:[selectThree objectAtIndex:i]] forState:UIControlStateSelected];
        [threeButton addTarget:self action:@selector(threeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [threeView addSubview:threeButton];
    }
    
//    //我的收藏
//    _myCollect=[[MyCollect alloc]initWithFrame:CGRectMake(0, 220, 270, 200)];
//    [_SubsidiaryScrollView addSubview:_myCollect];
//    
//    //其他模块
//    _otherView=[[OtherView alloc]initWithFrame:CGRectMake(0, 430, 270, 200)];
//    [_SubsidiaryScrollView addSubview:_otherView];
}

-(void)threeButtonAction:(UIButton*)button{
    NSLog(@"%d",button.tag);
    if (button!=selectedButton) {
        button.selected=YES;
        selectedButton.selected=NO;
        selectedButton=button;
    }
    switch (button.tag) {
        case 500:
            
            break;
            case 501:
            
            break;
            
            case 502:
            
            break;
        default:
            break;
    }
}
//亮度调节
-(void)sliderAction{
     [[UIScreen mainScreen] setBrightness: _slider.value];
}
//获得城市
-(void)getCity{
        //从plist读取城市
    NSArray* paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir=[paths objectAtIndex:0];
    NSString* filePath=[docDir stringByAppendingPathComponent:@"cityName.plist"];
    NSDictionary* dic=[[NSDictionary alloc]initWithContentsOfFile:filePath];
    [[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"city"]);
    //如果没有就GPS
    if (dic!=Nil){
        for (NSString* ss in dic) {
            _cityLabel.text=ss;//显示当前城市
            [self getCityID:ss];
        }
    }else{
    if (_gpsCoord.city==Nil) {
    if (time==6) {
          UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查GPS，或设置选择城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
    [self performSelector:@selector(getCity) withObject:self afterDelay:2];

        }
        time++;
    }else{
    _cityLabel.text=_gpsCoord.city;//显示当前城市
    [self getCityID:_gpsCoord.city];
    }
    }
}
//CityTableViewViewController的代理
-(void)customCityID{
    _cityLabel.text=_cityTableView.CityName;
    [self getCityID:_cityTableView.CityName];
    [_CityPopover dismissPopoverAnimated:YES];
    [[NSUserDefaults standardUserDefaults]setValue:@"city" forKey:_cityTableView.CityName];

    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"cityName.plist"];
    NSMutableDictionary* Citydata=[[NSMutableDictionary alloc]init];
    
     NSLog(@"%@",filename);
    [Citydata setObject:@"city" forKey:_cityTableView.CityName];
 
    [Citydata setValue:@"city" forKey:_cityTableView.CityName];
    //输入写入
    [Citydata writeToFile:filename atomically:YES];
   
    NSLog(@"citydata=%@",Citydata);
}
//获得城市的ID
-(void)getCityID:(NSString*)cityName{
    NSString* path=[[NSBundle mainBundle]pathForResource:@"cityId" ofType:@"txt"];
    NSError* error=nil;
    NSString* cityId=[[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@",error);
        exit(-1);
    }
    //切割字符串
    NSRange range=[cityId rangeOfString:cityName];
        int count=9-cityName.length;
        range.location+=range.length+1;
        range.length+=count;
        NSString *ss= NSStringFromRange(range);
        NSRange hhh=NSRangeFromString(ss);
        NSString *ID=[cityId substringWithRange:hhh];
        NSLog(@"id=%@",ID);
        [self weatherAPI:ID];
}

-(void)weatherAPI:(NSString*)cityID{
    NSString* weatherUrl=[NSString stringWithFormat:@"http://m.weather.com.cn/data/%@.html",cityID];
    
    NSURL* url=[NSURL URLWithString:weatherUrl];
    [self downloadASIHTTPResquest:url];
}
-(void)downloadASIHTTPResquest:(NSURL*)url{
    ASIHTTPRequest* request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    [request startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
//         NSLog(@"----%@",request.responseString);
    [self parseJSONData:request.responseString];
    
}
-(void)parseJSONData:(NSString*)data{
    SBJsonParser* sbjson=[[SBJsonParser alloc]init];
    NSDictionary* sjson=[sbjson objectWithString:data];
    NSDictionary* tianqi=[sjson objectForKey:@"weatherinfo"];
         _weatherModel=[[WeatherModel alloc]init];
        NSString* city=[tianqi objectForKey:@"city"];
        _weatherModel.cityName=city;
        NSString* date=[tianqi objectForKey:@"date_y"];
        _weatherModel.date=date;
        NSString* weather=[tianqi objectForKey:@"weather1"];
        _weatherModel.weather=weather;
        NSString* wind=[tianqi objectForKey:@"wind1"];
        _weatherModel.wind=wind;
        NSString* qiwen=[tianqi objectForKey:@"temp1"];
        _weatherModel.qiwen=qiwen;
    [self loadWeatherData];
}
//给天气模块加载数据
-(void)loadWeatherData{
    NSString* cityName=_weatherModel.cityName;
    _weatherView.cityLabel.text=[NSString stringWithFormat:@"%@天气",cityName];//天气模块显示当前城市
    _weatherView.dateLabel.text=_weatherModel.date;
    _weatherView.weatherLabel.text=_weatherModel.weather;
    _weatherView.windLabel.text=_weatherModel.wind;
    _weatherView.qiwenlabel.text=_weatherModel.qiwen;
    _weatherView.imageView.image=[UIImage imageNamed:@"WeatherSun.png"];
      [_weatherView reload];
}
//滑动上
-(void)upAction{
    NSLog(@"upup");
    [_MainSideScrollView setContentOffset:CGPointMake(0, 410) animated:YES];
}
//滑动下
-(void)downAction{
    [_MainSideScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    NSLog(@"downdown");
}
//设置按钮
-(void)setButtonAction{
    if (_MainSideScrollView.contentOffset.y==410) {
        [_MainSideScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [_MainSideScrollView setContentOffset:CGPointMake(0, 410) animated:YES];
    }
}
//日历按钮
-(void)CalendarAction{
    calendar=[[CalendarViewController alloc]init];
    _popover=[[UIPopoverController alloc]initWithContentViewController:calendar];
    _popover.popoverContentSize=CGSizeMake(400, 400);
    [_popover presentPopoverFromRect:CalendarButton.frame inView:_mainTitleView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}
//设置账户
-(void)accuntAction{
      _zhanghuTableView=[[TableViewController alloc]init];
    UINavigationController* nar=[[UINavigationController alloc]initWithRootViewController:_zhanghuTableView];
    _popover=[[UIPopoverController alloc]initWithContentViewController:nar];
    _popover.popoverContentSize=CGSizeMake(300, 435);
    [_popover presentPopoverFromRect:accountButton.frame inView:_SetVIew permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}
//城市位置
-(void)loationAction{
    _cityTableView=[[CityTableViewViewController alloc]init];
    _cityTableView.delegate=self;
    _CityPopover=[[UIPopoverController alloc]initWithContentViewController:_cityTableView];
    _CityPopover.popoverContentSize=CGSizeMake(300, 450);
    [_CityPopover presentPopoverFromRect:locationButton.frame inView:_SetVIew permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}
//按钮监听
-(void)buttonAction:(UIButton*)btn{
    for (int i=0; i<_idArray.count;i++) {
            if (btn.tag==100+i) {
                NSLog(@"%d",btn.tag);
                [self hwp:[_idArray objectAtIndex:i]];
        }
    }
    if(btn!=selectedButton){
        selectedButton.selected=NO;
        selectedButton=btn;
        btn.selected=YES;
        
    }
}
//根据id 让对应ID 的视图显示
-(void)hwp:(NSString*)ViewID{
    switch ([ViewID intValue]) {
        case 1://媒体札记
            [self state:NO :YES :YES: YES];
            break;
        case 2://头条
            [self state:YES :NO :YES :YES];
            break;
        case 3://图解
            [self state:YES :YES :NO :YES];
            break;
        case 4:
            [self state:YES :YES :YES :NO];
            break;
        default:
            break;
    }
}
//按钮和视图的状态
-(void)state :(BOOL)aBool :(BOOL)bBool :(BOOL)cBool :(BOOL)dBool{
    if (_viewa.hidden) {
        _viewa.hidden=aBool;
        _viewb.hidden=bBool;
        _viewc.hidden=cBool;
        _viewd.hidden=dBool;
    }
    if (_viewb.hidden) {
        _viewa.hidden=aBool;
        _viewb.hidden=bBool;
        _viewc.hidden=cBool;
        _viewd.hidden=dBool;
    }
    if (_viewc.hidden) {
        _viewa.hidden=aBool;
        _viewb.hidden=bBool;
        _viewc.hidden=cBool;
        _viewd.hidden=dBool;
    }
    if (_viewd.hidden) {
        _viewa.hidden=aBool;
        _viewb.hidden=bBool;
        _viewc.hidden=cBool;
        _viewd.hidden=dBool;
    }
}
//跳转控制器  ViewC的代理
-(void)jumpController:(int)glideValue{
    _particular=[[ParticularViewController alloc]init:glideValue];
    _particular.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:_particular animated:YES];
    
}
//支持旋转
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
