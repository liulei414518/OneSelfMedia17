//
//  ViewD.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-5.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "ViewD.h"
#import "SinaOperator.h"
#import "JSON.h"

@implementation ViewD
@synthesize _tableView,weiBoView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
   
    if (self) {
        
        // Initialization code
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"juheContentBg.jpg"]];
        fileManager=[NSFileManager defaultManager];
        _dataArray=[[NSMutableArray alloc]init];
        
        if ([[SinaOperator sharedSinaWeiboOperator]isExistenceNetwork]) {//判断网络链接
            indexCount=20;
            [self dataResquest:indexCount];
            networkBool=YES;
        }
        else {
            if (![fileManager fileExistsAtPath:SandBox(@"345")]) 
                return self;
            else {
                NSError *error;
                NSData *data= [NSData dataWithContentsOfFile:SandBox(@"345")];
                id jsobject =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                jsobject =[jsobject JSONValue];
                [self adddataArray:jsobject];
            }
            
        }    
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 50, 720, 550)];

        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self addSubview:_tableView];
        
        blogWebView=[[UIWebView alloc]initWithFrame:CGRectMake(10, 50, 720, 550)];
        NSURLRequest *requset =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://blog.sina.com.cn/u/1653120747"]];
        blogWebView.hidden=YES;
        blogWebView.scalesPageToFit=YES;
        [blogWebView loadRequest:requset];
        [self addSubview:blogWebView];
        
         downRefresh =[[DownRefreshView alloc]initWithFrame:CGRectMake(0, _tableView.contentSize.height+10, _tableView.frame.size.width, 50)];
        UIView* leftView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 700, 50)];
        leftView.backgroundColor=[UIColor clearColor];
        [self addSubview:leftView];
        
        NSArray* array=[NSArray arrayWithObjects:@"juhebtn2.png",@"juhebtn3.png", nil];
        NSArray* selectarray=[NSArray arrayWithObjects:@"juhebtn2Hover.png",@"juhebtn3Hover.png" ,nil];
        for (int i=0; i<array.count; i++) {
            UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(400+i*100,5, 80, 40);
            button.tag=i+100;
            if (i==0) {
                button.selected=YES;
                selectButton=button;
            }
            [button setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[selectarray objectAtIndex:i]] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [leftView addSubview:button];      
        }
    }
    return self;
}
-(void)dataResquest:(int)index{
    //    NSString* accessToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
    NSString* name=[@"徐达内" urlEncodeString];
    NSString* sss=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?count=%d&screen_name=%@&access_token=2.00BxTHnBEqec3Ec825ee149eWN_plC",index,name];
    NSURL* url=[NSURL URLWithString:sss];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    [request startAsynchronous];
    
}
// 获取数据，添加到数组
-(void)adddataArray:(id)bookJsobject
{
    if (bookJsobject == nil) {
        return;
    }
    
    
    if (bookJsobject !=nil)
    {
        [_dataArray removeAllObjects];
        if([bookJsobject isKindOfClass:[NSMutableDictionary class]])
        {
            NSMutableDictionary *dicBooks=(NSMutableDictionary*)bookJsobject;
            NSMutableArray *statues=[dicBooks objectForKey:@"statuses"];
//            NSLog(@"%d",statues.count);
            for (int s =0; s< statues.count; s++) {
               
                tabData =[[TableData alloc]init];
                tabData.weiBoData=[[statues objectAtIndex:s]objectForKey:@"text"];// 自己的微博内容
                tabData.tranWeiBoData =[[[statues objectAtIndex:s]objectForKey:@"retweeted_status"]objectForKey:@"text"];//转发的微博内容
                 NSString* creatTime=[[statues objectAtIndex:s]objectForKey:@"created_at"];
                tabData.timeline = [self timeLineStr:creatTime];// 自己的微博撰写时间
                NSString* tranCreatTime=[[[statues objectAtIndex:s]objectForKey:@"retweeted_status"]objectForKey:@"created_at"];
                tabData.tranTimeLine=[self timeLineStr:tranCreatTime]; //转载的微博的撰写时间
                NSString *source=[[statues objectAtIndex:s]objectForKey:@"source"];
                tabData.weiBoFrom=[self weiBODataFrom:source];//撰写来自哪儿
                NSString *tranSource=[[[statues objectAtIndex:s]objectForKey:@"retweeted_status"]objectForKey:@"source"];
                tabData.tranWeiBOFrom=[self weiBODataFrom:tranSource];//转载的微博来自哪
                tabData.tranLogoName=[[[[statues objectAtIndex:s]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"name"];
                tabData.tranSmallImage=[[[statues objectAtIndex:s]objectForKey:@"retweeted_status"]objectForKey:@"thumbnail_pic"];
                tabData.tranOriginalImage=[[[statues objectAtIndex:s]objectForKey:@"retweeted_status"]objectForKey:@"original_pic"];

                
                tabData.tranCount=[NSString stringWithFormat:@"%@",[[statues objectAtIndex:s]objectForKey:@"reposts_count"]] ;
                tabData.commentCount=[NSString stringWithFormat:@"%@",[[statues objectAtIndex:s]objectForKey:@"comments_count"]];
                NSDictionary *user=[[statues objectAtIndex:s]objectForKey:@"user"];
                tabData.blogName=[user objectForKey:@"name"];//博客名
                tabData.logoImage=[user objectForKey:@"avatar_large"];// 博客图片
                
                tabData.articleSmallImage=[[statues objectAtIndex:s]objectForKey:@"thumbnail_pic"];
                tabData.articleOriginalImage=[[statues objectAtIndex:s]objectForKey:@"original_pic"];
                tabData.ID=[[statues objectAtIndex:s]objectForKey:@"id"];//id
               
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *DocumentDirectory=[paths objectAtIndex:0];
                NSString *path = [DocumentDirectory stringByAppendingPathComponent:DIR];
               
                if (![fileManager fileExistsAtPath:path]) {
                    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                }
                if (! [fileManager fileExistsAtPath:SandBox(@"555")]) {
                    NSLog(@"%@",tabData.logoImage);
                    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:tabData.logoImage]];
                    [data writeToFile:SandBox(@"555") atomically:YES];
                }  
                [_dataArray addObject:tabData];
            }    
        }
    }



}
-(void)requestFinished:(ASIHTTPRequest *)request
{
  
    NSError *error;
    NSData *jsdata =[NSJSONSerialization dataWithJSONObject:request.responseString options:NSJSONReadingAllowFragments error:&error];
    [jsdata writeToFile:SandBox(@"345") atomically:YES];
    id bookJsobject=[request.responseString JSONValue];
    [self adddataArray:bookJsobject];
    [_tableView reloadData];

   

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentSize.height-scrollView.contentOffset.y<=500) {
        NSLog(@"===%f",scrollView.contentSize.height-scrollView.contentOffset.y);
        
        if (networkBool) {
            indexCount+=10;
            [self dataResquest:indexCount];
             [_tableView reloadData];
        }
    }
}
-(void)downRefreshTableView
{  
//    NSLog(@"==============%f",_tableView.contentOffset.y);
 
    downRefresh.frame=CGRectMake(0, _tableView.contentSize.height+10, _tableView.frame.size.width, 50);
    if (networkBool) {
      downRefresh.label.text=@"上拉刷新";
    }   else {
        downRefresh.label.text=@"网络未连接";
    }
    [_tableView insertSubview:downRefresh aboveSubview:_tableView];




}
-(NSString*)timeLineStr:(NSString*)str//获取发布时间
{
    if ([str isEqualToString:@""]) {
        return nil;
    }
    NSString *year=[[str substringFromIndex:26]substringToIndex:4];
    NSString *month=[[str substringFromIndex:4]substringToIndex:3];
    if ([month isEqualToString:@"Jan"]) {
        month =@"01";
    }if ([month isEqualToString:@"Feb"]) {
        month =@"02";
    }
    if ([month isEqualToString:@"Mar"]) {
        month =@"03";
    }
    if ([month isEqualToString:@"Apr"]) {
        month =@"04";
    }
    if ([month isEqualToString:@"May"]) {
        month =@"05";
    }
    if ([month isEqualToString:@"Jun"]) {
        month =@"06";
    }
    if ([month isEqualToString:@"Jul"]) {
        month =@"07";
    }
    if ([month isEqualToString:@"Aug"]) {
        month =@"08";
    }
    if ([month isEqualToString:@"Sep"]) {
        month =@"09";
    }
    if ([month isEqualToString:@"Oct"]) {
        month =@"10";
    }
    if ([month isEqualToString:@"Nov"]) {
        month =@"11";
    }
    if ([month isEqualToString:@"Dec"]) {
        month =@"12";
    }

    NSString *day=[[str substringFromIndex:8]substringToIndex:2];
    NSString *time=[[str substringFromIndex:11]substringToIndex:5];
    year = [year stringByAppendingString:@"-"];
    month =[month stringByAppendingString:@"-"];
    day =[day stringByAppendingString:@" "];
    str =[[[year stringByAppendingString:month]stringByAppendingString:day] stringByAppendingString:time];
    
    return str;
}
-(NSString*)weiBODataFrom:(NSString*)str//微博的来自的字符串切割
{
    if (![str isEqualToString:@""]) {
        NSArray* sourceArr=[str componentsSeparatedByString:@">"];
        NSString *a=[sourceArr objectAtIndex:1];
        NSArray *sourceArr2=[a componentsSeparatedByString:@"<"];
        str = [sourceArr2 objectAtIndex:0];
       
         return str;
    }
  return str;
   
}
-(void)buttonAction:(UIButton*)button{
    if (button!=selectButton) {
        button.selected=YES;
        selectButton.selected=NO;
        selectButton=button;
    }
    if (button.tag==100) {
        _tableView.hidden=NO;
        blogWebView.hidden=YES;
    }
    
    if (button.tag==101) {
        _tableView.hidden=YES;
        blogWebView.hidden=NO;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"TableCell";
    TableCell* cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell==Nil) {
        cell=[[TableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.textLabel.numberOfLines =0;
        cell.textLabel.lineBreakMode =UILineBreakModeCharacterWrap;
    }
    
    TableData* tb=[[TableData alloc ]init];
    tb=[_dataArray objectAtIndex:indexPath.row];
    

    cell.logoImage.frame= CGRectMake(5, 10, 110, 110);//cell的logo 图标
    NSData *data=[NSData dataWithContentsOfFile:SandBox(@"555")];
    cell.logoImage.image=[UIImage imageWithData:data];   
    
    CGSize blogNameSize=[ tb.blogName sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20] constrainedToSize:CGSizeMake(150, 30)lineBreakMode:UILineBreakModeCharacterWrap];
    
    cell.blogName.frame=CGRectMake(120, 5, blogNameSize.width, 30);//博客名
    cell.blogName.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
//    cell.blogName.textColor =[UIColor lightTextColor];
    cell.blogName.text=tb.blogName;
    cell.blogName.textAlignment=UITextAlignmentLeft;
    
    cell.iconImage.image=[UIImage imageNamed:@"logo@2x.png"];// icon 图标
    cell.iconImage.frame=CGRectMake(125+blogNameSize.width, 5, 60, 30);
    
    cell.fromLable.frame=CGRectMake(195+blogNameSize.width, 5, 150, 30);//来自哪儿
    cell.fromLable.font =[UIFont systemFontOfSize:14];
    cell.fromLable.text=[NSString stringWithFormat:@"来自于:%@",tb.weiBoFrom];
    
    cell.timeLine.frame =CGRectMake(500, 5, 150, 30);//发布日期
    cell.timeLine.text =tb.timeline;
    
    cell.weiBoData.frame=CGRectMake(120, 35, 560, 83);//中间的数据。微博内容
    cell.weiBoData.numberOfLines=3;
    cell.weiBoData.lineBreakMode=UILineBreakModeTailTruncation;
    cell.weiBoData.text=tb.weiBoData;
    
   // cell.retranImage.frame=CGRectMake(560, 120, 20, 20);//转载图标
    cell.retranImage.image=[UIImage imageNamed:@"jurunbtn2.png"];
    
    cell.retranCount.frame = CGRectMake(585, 120, 30, 20);//z转载数
    cell.retranCount.font =[UIFont systemFontOfSize:14];
  
    cell.retranCount.text=tb.tranCount;
    
    //cell.discussImage.frame= CGRectMake(620, 120, 20, 20);//评论图标
    cell.discussImage.image =[UIImage imageNamed:@"jurunbtn1.png"];
    
    cell.discussCount.frame=CGRectMake(645, 120, 30, 20);//评论的次数
    cell.discussCount.font =[UIFont systemFontOfSize:14];
    cell.discussCount.text=tb.commentCount;
    
    [self downRefreshTableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//cell view 的高度
{
    
    // 這裏返回需要的高度
      return 150;
       
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (weiBoView) {
        [weiBoView removeFromSuperview];
    }
    NSLog(@"%d",indexPath.row);
    NSLog(@"%d",indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    weiBoView=[[WeiBoContentView alloc]initWithFrame:CGRectMake(110+600, 0, 760, 640)];
    weiBoView.delegate=self;
    tabData=[_dataArray objectAtIndex:indexPath.row];

    weiBoView.tableData =[[TableData alloc]init];
    weiBoView.tableData=tabData;
    if (tabData.tranSmallImage!=nil) {
        [weiBoView.self getImageFromURL:tabData.tranSmallImage andName:@"101"];
    }//把自己写的微博图像保存为100
    if (tabData.articleSmallImage!=nil) {
        [weiBoView.self getImageFromURL:tabData.articleSmallImage andName:@"100"];
    }

    [weiBoView.self requestData:tabData.ID andCount:tabData.commentCount];
    
    [weiBoView._tableView reloadData];
    if (tabData.tranWeiBoData!=nil) {
        weiBoView.tranView =[[UIView alloc]init];
    }
    [self addSubview:weiBoView];
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationCurveLinear animations:^{
        weiBoView.frame=CGRectMake(0, 0, 760, 640);
    } completion:Nil];

}
//WeiBoContentView代理
-(void)huadongAction{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationCurveLinear animations:^{
        weiBoView.frame=CGRectMake(710, 0, 760, 640);
    } completion:^(BOOL finished) {
        [weiBoView removeFromSuperview];
    }];
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
