//
//  WeiBoContentView.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-18.
//  Copyright (c) 2012年 EG365. All rights reserved.
//
#import "JSON.h"
#import "WeiBoContentView.h"
#import "WeiBoCell.h"
#import "commentCell.h"
#import "Reachability.h"
#import "MainViewController.h"

@implementation WeiBoContentView
@synthesize tableData,_tableView,tranView,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        //关闭微博按钮
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, 90, self.frame.size.height);
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeTable) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];

        
        
        
        UIView* tableBgView=[[UIView alloc]initWithFrame:CGRectMake(90, 0, 1341/2, 1225/2)];
        tableBgView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jurunBg.png"]];
        [self addSubview:tableBgView];
        
        fileManager =[NSFileManager defaultManager];
        _commentArray =[[NSMutableArray alloc]init];
        logoImageArr =[[NSMutableArray alloc]init];
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(60, 0, 600, 600)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [tableBgView addSubview:_tableView];
                // Initialization code
        NSLog(@"%@",tableData.ID);
        blogImageBool=NO;
        tranImageBool=NO;
       // [self requestData:tableData.ID];
        
    }
    return self;
}
// 微博的三个功能 分享 转发和 评论
-(void)commentWeiBo:(UIButton*)sender
{
    NSLog(@"sender.tag =%d",sender.tag);  
    //评论的方法
    if (sender.tag==200) {
        [[SinaOperator sharedSinaWeiboOperator] bindSinaWeiBo];
        writeView =[[WriteRemarkView alloc]initWithFrame:CGRectMake(0, 768, 1024, 768)];
        writeView.delegate=self;
        [self.superview.superview.superview addSubview:writeView];
        [UIView transitionWithView:self duration:1 options:UIViewAnimationCurveLinear animations:^{
            writeView.frame=CGRectMake(0, 0, 1024,768);
        } completion:^(BOOL finished) {
            writeView.bgView.hidden=NO;
        }];
    }
    // 分享的方法
    if (sender.tag==201) {
         NSString* acc=[[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
        if (acc ==nil) {
            [[SinaOperator sharedSinaWeiboOperator]bindSinaWeiBo];
        }  else {
            transpondView =[[TranspondView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
            [self.superview.superview.superview addSubview:transpondView];
            if (tableData.tranWeiBoData!=nil) {
                NSString *beforeText=[[@"//@" stringByAppendingFormat:tableData.blogName] stringByAppendingFormat:@":%@",tableData.weiBoData];;
                transpondView._textView.text =beforeText;
            }
            transpondView.delegate=self;
        }
       
    }
    // 转载的方法
    if (sender.tag==202) {
        NSString *index= tableData.ID;
       
        NSURL* url=[NSURL URLWithString:@"https://api.weibo.com/2/favorites/create.json"];
        NSString* acc=[[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
         NSLog(@"%@",acc);
        if (acc !=nil) {
            ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
            [request setPostValue:acc forKey:@"access_token"];
            [request setPostValue:index forKey:@"id"];
            request.accessibilityLabel=@"share";
            [request setDelegate:self];
            [request startSynchronous];
        }
        else {
            [[SinaOperator sharedSinaWeiboOperator]bindSinaWeiBo];
        }
       
        
    }

}
//WriteRemarkView 代理 
#pragma mark WriteRemarkView Degegate
-(void)writedelegate
{  [UIView transitionWithView:self duration:1 options:UIViewAnimationCurveLinear animations:^{
    writeView.bgView.hidden=YES;
    writeView.frame=CGRectMake(0, 760, 1024, 768);
} completion:^(BOOL finished) {
    [writeView removeFromSuperview];
}];
    
}
//发送评论
-(void)sendMassage:(NSString *)str
{
    
    NSString *index= tableData.ID;
    NSURL* url=[NSURL URLWithString:@"https://api.weibo.com/2/comments/create.json"];
    NSString* acc=[[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:str forKey:@"comment"];
    [request setPostValue:@"0" forKey:@"comment_ori"];
    [request setPostValue:acc forKey:@"access_token"];
    [request setPostValue:index forKey:@"id"];
    [request setDelegate:self];
    [request startSynchronous];
    [writeView removeFromSuperview];
    int c = [tableData.commentCount intValue];
    
    NSString *count =[NSString stringWithFormat:@"%d",c+1];
    
    [self requestData:tableData.ID andCount:count];
    [_tableView reloadData];
}
//关闭转发试图 transpond的代理方法
#pragma mark transpondDelegate
-(void)closeTextView{
    
    [transpondView removeFromSuperview];
    
}
-(void)tranSpondText:(NSString *)str
{
    
    NSLog(@"tranSpondText  %@",str);
    [transpondView removeFromSuperview];
    
    NSString *index= tableData.ID;
    NSURL* url=[NSURL URLWithString:@"https://api.weibo.com/2/statuses/repost.json"];
    NSString* acc=[[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
    NSLog(@"%@",acc);
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:str forKey:@"status"];
    [request setPostValue:@"3" forKey:@"is_comment"];
    [request setPostValue:acc forKey:@"access_token"];
    [request setPostValue:index forKey:@"id"];
    request.accessibilityLabel=@"tran";
    [request setDelegate:self];
    [request startSynchronous];
    
    
    
}


// 关闭微博
-(void)closeTable
{
    [fileManager removeItemAtPath:SandBox(@"100") error:nil];
    [fileManager removeItemAtPath:SandBox(@"101") error:nil];
    [fileManager removeItemAtPath:SandBox(@"102") error:nil];
    [fileManager removeItemAtPath:SandBox(@"103") error:nil];
    [_commentArray removeAllObjects];
    [logoImageArr removeAllObjects];
    [requestHTTP clearDelegatesAndCancel];
    [self.delegate huadongAction];
    
}
#pragma  mark tableViewDatasoure and Delegate

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//   
//    if (section==0) {
//        return @"正文";
//    }
//    return @"评论";
//}
//section高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 84/2;
    }
    return 63/2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section //自定义的section
{
    if (section==0) {
        UIView * section1View = [[UIView alloc] initWithFrame:CGRectMake(-25, 0,1247/2, 84/2)] ;
        [section1View setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"juruntitle.png"]]];
        
        return section1View;

    }
    if (section==1) {
        UIView * section2View = [[UIView alloc] initWithFrame:CGRectMake(-25, 0,1247/2, 63/2)] ;
        [section2View setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"juruntitle2.png"]]];

        return section2View;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else  {
        NSLog(@"评论数目 = %d",_commentArray.count);
        if (_commentArray.count==0) {
            return 1;
        }else {
            return _commentArray.count;
        }
    }
}
    -(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) 
    {
        static NSString* CellID=@"WeiBoCell";
        WeiBoCell* cell=[tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell==Nil) {
            cell=[[WeiBoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            cell.textLabel.numberOfLines =0;
            cell.textLabel.lineBreakMode =UILineBreakModeCharacterWrap;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
     
        
    NSArray* array=[NSArray arrayWithObjects:@"jurunbtn1.png",@"jurunbtn2.png",@"jurunbtn3.png",nil];
        // 评论按钮呢
        for (int i=0; i<array.count; i++) {
            UIButton *commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [commentBtn setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
            commentBtn.frame=CGRectMake(330 +60*i, 20, 71/2, 71/2);
            commentBtn.tag = 200+i;
            [commentBtn addTarget:self action:@selector(commentWeiBo:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:commentBtn];
        }
        
        cell.logoImage.frame=CGRectMake(5, 5, 100, 100);//微博头像
        NSData *data=[NSData dataWithContentsOfFile:SandBox(@"555")];
        cell.logoImage.image=[UIImage imageWithData:data];
        
        cell.blogName.frame=CGRectMake(120, 5, 100, 30);
        cell.blogName.text =tableData.blogName;
        
        CGSize blogContentSize=[tableData.weiBoData sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(560, CGFLOAT_MAX)lineBreakMode:UILineBreakModeCharacterWrap];
        
        cell.blogContent.frame=CGRectMake(15, 105, 560, blogContentSize.height);//微博的内容
        cell.blogContent.backgroundColor=[UIColor clearColor];
        cell.blogContent.font=[UIFont systemFontOfSize:18];
        cell.blogContent.text=tableData.weiBoData;
        cell.blogContent.numberOfLines=0;
        cell.blogContent.lineBreakMode=UILineBreakModeCharacterWrap;
        if (tableData.articleSmallImage!=nil) {
            
            UIImage* image =weiBoImage;
            cell.articleImage.frame=CGRectMake((560- image.size.width)/2, 120+blogContentSize.height, image.size.width, image.size.height);

            cell.articleImage.backgroundColor=[UIColor blueColor];
            NSLog(@"%@",tableData.articleSmallImage);
            cell.articleImage.image=[UIImage imageWithContentsOfFile:SandBox(@"100")];
            cell.articleImage.userInteractionEnabled=YES;
            cell.articleImage.accessibilityLabel=tableData.articleOriginalImage;
            cell.articleImage.accessibilityValue=@"102";
            cell.articleImage.accessibilityIdentifier=@"100";
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImage:)];
            [cell.articleImage addGestureRecognizer:tap];
            
        }
        else {
            NSLog(@"写的微博没有图片");
            cell.articleImage.frame=CGRectZero;
        }
        // 转载的内容不为空
         NSLog(@"=============%d",tranImageBool);
        if (tableData.tranWeiBoData!=nil)
        {
            CGSize tranLogoSize=[tableData.tranWeiBoData sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(600, CGFLOAT_MAX)lineBreakMode:UILineBreakModeCharacterWrap];
            
            UILabel* tranLogo=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 570, tranLogoSize.height)];
            tranLogo.backgroundColor=[UIColor clearColor];
            tranLogo.numberOfLines=0;
            tranLogo.lineBreakMode =UILineBreakModeCharacterWrap;
            tranLogo.text= [tableData.tranLogoName stringByAppendingString:[NSString stringWithFormat:@":%@",tableData.tranWeiBoData]];
            tranLogo.textColor=[UIColor blackColor];
            [tranView addSubview:tranLogo];
            
            int tranImage=0;
            //转载的图片不为空
            if (tableData.tranSmallImage !=nil) {
                
                myImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, tranLogoSize.height+10, 100, 100)];
                myImage.backgroundColor =[UIColor blueColor];
                if (tranImageBool) {
                    myImage.image=[UIImage imageWithContentsOfFile:SandBox(@"101")];
                    
                }
                myImage.userInteractionEnabled=YES;
                myImage.accessibilityLabel=tableData.tranOriginalImage;
                NSLog(@"%@",tableData.tranSmallImage);
                myImage.accessibilityValue=@"103";
                myImage.accessibilityIdentifier=@"101";
                UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImage:)];
                [myImage addGestureRecognizer:tap];
                [tranView addSubview:myImage];
                tranImage=120;
            }
            UIImageView* sanjiao=[[UIImageView alloc]initWithFrame:CGRectMake(120, 110+blogContentSize.height+cell.articleImage.frame.size.height+10, 47/2, 25/2)];
            sanjiao.image=[UIImage imageNamed:@"jurunArrow.png"];
            [cell addSubview:sanjiao];
            //转载的试图
            tranView.frame=CGRectMake(10, 120+blogContentSize.height+cell.articleImage.frame.size.height+10, 580, tranLogoSize.height+10+tranImage);
            tranView.backgroundColor=[UIColor lightGrayColor];
            [cell addSubview:tranView];
        }
        else {
            NSLog(@"没有转载");
        tranView.frame=CGRectZero;
        }
        return cell;
    }
    else {
        static NSString* CellID=@"commentCell";
        commentCell* cell=[tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell==Nil) {
            cell=[[commentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            cell.textLabel.numberOfLines =0;
            cell.textLabel.lineBreakMode =UILineBreakModeCharacterWrap;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (_commentArray.count==0) {
            
            cell.blogText.frame=CGRectMake(5, 5, 200, 40);
            cell.blogText.text=@" 暂时没有任何评论";
            return cell;
        }
        commentData =[_commentArray objectAtIndex:indexPath.row];
        cell.logoImageView.frame=CGRectMake(5, 5, 40, 40);
        NSString *str=[NSString stringWithFormat:@"00%d",indexPath.row];
        cell.logoImageView.image=[UIImage imageWithContentsOfFile:SandBox(str)];  
        
        CGSize commentSize=[commentData.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(530, CGFLOAT_MAX)lineBreakMode:UILineBreakModeCharacterWrap];
        cell.blogText.frame=CGRectMake(60, 5, commentSize.width , commentSize.height);
        cell.blogText.font=[UIFont systemFontOfSize:16];
        cell.blogText.text=commentData.text;
        cell.blogText.numberOfLines=0;
        cell.blogText.lineBreakMode=UILineBreakModeCharacterWrap;
        NSString* detal =[commentData.creatTime stringByAppendingString:@"   来自"];
        detal =[detal stringByAppendingString:commentData.sourceFrom];
        cell.blogFrom.frame=CGRectMake(60, cell.blogText.frame.size.height +10, 300, 20);
        cell.blogFrom.font=[UIFont systemFontOfSize:14];
        cell.blogFrom.text=detal;
        return cell;
    }
       
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//cell view 的高度
{    // 這裏返回需要的高度
    if (indexPath.section==0)
    {
        CGSize blogContentSize=[tableData.weiBoData sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(self.frame.size.width-20, CGFLOAT_MAX)lineBreakMode:UILineBreakModeCharacterWrap];
        int imageHeight=0; int tranImage=0;
        if (tableData.articleSmallImage!=nil){
            weiBoImage=[UIImage imageWithContentsOfFile:SandBox(@"100")];
            imageHeight=weiBoImage.size.height;
        }
        if (tableData.tranSmallImage!=nil) {
            reWeiBoimage=[UIImage imageWithContentsOfFile:@"101"];
            tranImage=120;
        }        
//        CGSize tranLogoSize=[tableData.tranWeiBoData sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(530, CGFLOAT_MAX)lineBreakMode:UILineBreakModeCharacterWrap];
        return blogContentSize.height+imageHeight+180+tranView.frame.size.height;
    }
    else {
        if (_commentArray.count==0) {
            return 40;
        }
        commentData =[_commentArray objectAtIndex:indexPath.row];
         CGSize commentSize=[commentData.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(560, CGFLOAT_MAX)lineBreakMode:UILineBreakModeCharacterWrap];
        NSLog(@"%f",commentSize.height);
        return commentSize.height+35;
    }
}
 //图片被点击 放大的方法
-(void)enlargeImage:(UITapGestureRecognizer*)tap
{   
    NSString* path= tap.view.accessibilityLabel;
    NSString *name=tap.view.accessibilityValue;
    [self getImageFromURL:path andName:name];
    imageScrollView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    imageScrollView.backgroundColor =[UIColor clearColor];
    //    [imageScrollView setOpaque:NO];
    
    UIView* bgVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    bgVIew.backgroundColor=[UIColor blackColor];
    bgVIew.alpha=0.7;
    [imageScrollView addSubview:bgVIew];
    
    reImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];//图片视图
    reImage.userInteractionEnabled=YES;
    //添加
    UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];    
    
    [panRcognize setEnabled:YES];    
    [panRcognize delaysTouchesEnded];    
    [panRcognize cancelsTouchesInView];   
    
    [reImage addGestureRecognizer:panRcognize];  
    UIPinchGestureRecognizer* pinchGesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    [reImage addGestureRecognizer:pinchGesture];
    
    reImage.image=[UIImage imageWithContentsOfFile:SandBox(tap.view.accessibilityIdentifier)];
    reImage.center= imageScrollView.center;
    [imageScrollView addSubview:reImage];
    
    hud =[MBProgressHUD showHUDAddedTo:imageScrollView animated:YES];
    hud.labelText=@"loading";
    [hud show:YES];
    
    // 关闭按钮
    UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeScrollImageView) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setFrame:CGRectMake(900, 0, 60, 60)];
    [imageScrollView addSubview:closeBtn];
    [self.superview.superview.superview addSubview:imageScrollView];
    
}
-(void)handlePan:(UIPanGestureRecognizer*)pan//拖拽手势
{
    if (pan.state == UIGestureRecognizerStateChanged) { 
    CGPoint translation = [pan translationInView:reImage];
    pan.view.center=CGPointMake(pan.view.center.x+translation.x, pan.view.center.y+translation.y);
        [pan setTranslation:CGPointZero inView:pan.view];
    }      
}
-(void)pinchAction:(UIPinchGestureRecognizer*)pinch{//捏合手势
    if (pinch.state==UIGestureRecognizerStateChanged) {
        CGFloat scale=pinch.scale;
        pinch.view.transform=CGAffineTransformScale(pinch.view.transform, scale, scale);
        pinch.scale=1;
    }
}
//关闭弹出的图片
-(void)closeScrollImageView
{
    [imageScrollView removeFromSuperview];
}
-(void) getImageFromURL:(NSString *)fileURL andName:(NSString*)name {
    NSLog(@"%@",fileURL);
    requestHTTP=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:fileURL]];
    requestHTTP.delegate=self;
    requestHTTP.accessibilityLabel=@"image";
    requestHTTP.accessibilityValue=name;
    [requestHTTP setDownloadDestinationPath:SandBox(name)];
    [requestHTTP startAsynchronous];
    NSLog(@"执行图片下载函数");
   
}
-(UIImage*)getImage:(NSString*)fileUrl
{
    UIImage *result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileUrl]];
    result = [UIImage imageWithData:data];
    return result;
}
//请求评论数据
-(void)requestData:(NSString*)index andCount:(NSString*)count{
    NSLog(@"id = %@",index);
    NSString* sss=[NSString stringWithFormat:@"https://api.weibo.com/2/comments/show.json?count=%@&id=%@&access_token=2.00BxTHnBEqec3Ec825ee149eWN_plC",count,index];
    NSURL* url=[NSURL URLWithString:sss];
    requestHTTP=[ASIHTTPRequest requestWithURL:url];
    requestHTTP.delegate=self;
    requestHTTP.accessibilityLabel=@"comment";
    [requestHTTP startAsynchronous];

}
//请求评论者图像
-(void)requestLogoImage:(NSString*)str andName:(NSString*)name
{
    NSURL* url=[NSURL URLWithString:str];
    NSLog(@"%@",str);
    requestHTTP=[ASIHTTPRequest requestWithURL:url];
    requestHTTP.delegate=self;
    requestHTTP.downloadDestinationPath =SandBox(name);
    NSLog(@"%@",SandBox(name));
    requestHTTP.accessibilityLabel=@"logoImage";
    [requestHTTP startAsynchronous];
    
}

 #pragma ASIHTTPRequestDelegate

-(void)requestFailed:(ASIHTTPRequest *)request
{ 
    if ([request.accessibilityLabel isEqualToString:@"comment"]){
    NSLog(@"requestFailed");
    }if ([request.accessibilityLabel isEqualToString:@"send"]){
        NSLog(@"requestFailed");
    }
    return;

}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished");
    if ([request.accessibilityLabel isEqualToString:@"image"]) {
        [MBProgressHUD hideHUDForView:imageScrollView animated:YES];
        NSString *name =request.accessibilityValue;
        UIImage *image=[UIImage imageWithContentsOfFile:SandBox(name)];
        myImage.image=[UIImage imageWithContentsOfFile:SandBox(@"101")];
        if ([fileManager fileExistsAtPath:SandBox(@"100")])
        { blogImageBool=YES;
        }
        if ([fileManager fileExistsAtPath:SandBox(@"101")])
        { tranImageBool=YES;
        }
        if (name==@"102"||name==@"103") {
            if (image.size.width<1024&& image.size.height<690) {
                reImage.frame=CGRectMake(0, 0, image.size.width, image.size.height);
                reImage.center = imageScrollView.center;
            }
            else if (image.size.width<1024 && image.size.height>690) {
                reImage.frame=CGRectMake((1024-image.size.width)/2, 0, image.size.width, image.size.height);
            }
            else if(image.size.width>1024 && image.size.height<690){
                reImage.frame=CGRectMake(0, (690-image.size.height)/2, image.size.width, image.size.height);
                
            }
            else {
                reImage.frame=CGRectMake(0, 0,image.size.width, image.size.height);
            }
            reImage.image=image;
        }
        
     
    }
    if ([request.accessibilityLabel isEqualToString:@"comment"]) {
        id bookJsobject=[request.responseString JSONValue];
        [self adddataArray:bookJsobject];
        
        [_tableView reloadData];
        NSLog(@"刷新数据");
        for (int i =0; i<_commentArray.count; i++) {
            CommentDataModel *comm =[[CommentDataModel alloc]init];
            comm =[_commentArray objectAtIndex:i];
            NSLog(@"%@",comm.userImage);
            [self requestLogoImage:comm.userImage andName:[NSString stringWithFormat:@"00%d",i]];
            [logoImageArr addObject:[NSString stringWithFormat:@"00%d",i]];
        }
        
}
    if  ([request.accessibilityLabel isEqualToString:@"logoImage"]) {
        NSLog(@"logoImage requestFinished ");
        [_tableView reloadData];
    }
    if ([request.accessibilityLabel isEqualToString:@"send"]) {
        NSLog(@"---------------requestFinished send-")  ;
    }
    if ([ request.accessibilityLabel isEqualToString:@"share"]) {
        NSLog(@"requestFinished = share");
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"收藏成功！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        
    }
    if ([ request.accessibilityLabel isEqualToString:@"tran"]) {
        NSLog(@"requestFinished = tran");
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"转发成功！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        
    }

}
//评论数据获取后添加到数组
-(void)adddataArray:(id)bookJsobject//
{
    if (bookJsobject == nil) {
        return;
    }
    if (bookJsobject !=nil)
    {
        if([bookJsobject isKindOfClass:[NSMutableDictionary class]])
        {
            [_commentArray removeAllObjects];
            NSMutableDictionary *dicBooks=(NSMutableDictionary*)bookJsobject;
            NSMutableArray *comments=[dicBooks objectForKey:@"comments"];
            NSLog(@"%d",comments.count);
            for (int i =0; i<comments.count; i++) {
                commentData =[[CommentDataModel alloc]init];
                NSString *creat =[[comments objectAtIndex:i]objectForKey:@"created_at"];
                commentData.creatTime = [self timeLineStr:creat];
                commentData.text=[[comments objectAtIndex:i]objectForKey:@"text"];
                commentData.userName=[[[comments objectAtIndex:i]objectForKey:@"user"]objectForKey:@"name"];
                commentData.userImage=[[[comments objectAtIndex:i]objectForKey:@"user"]objectForKey:@"profile_image_url"];
                NSString* date =[[comments objectAtIndex:i]objectForKey:@"source"];
                commentData.sourceFrom=[self weiBODataFrom:date];
                [_commentArray addObject:commentData];
            }
        }
    }
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

-(NSString*)timeLineStr:(NSString*)str//获取发布时间
{
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



@end
