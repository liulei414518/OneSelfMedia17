//
//  CityTableViewViewController.m
//  OneSelfMedia
//
//  Created by EG365 on 12-12-6.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import "CityTableViewViewController.h"

@interface CityTableViewViewController ()

@end

@implementation CityTableViewViewController
@synthesize CityID,CityName,delegate;
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
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 450)style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
    NSString* path=[[NSBundle mainBundle]pathForResource:@"cityId" ofType:@"txt"];
    NSError* error=nil;
    NSString* cityId=[[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@",error);
        exit(-1);
    }
[self dd:cityId];
}
-(void)dd:(NSString*)citys{
    //城市
    city_array=[[NSMutableArray alloc]initWithCapacity:0];
    NSRange cityRange=NSMakeRange(0, 0);
    for (int i=0; i<[citys length]; i++) {
        if ([citys characterAtIndex:i]==':') {
            for (int j=i; j>0; j--) {
                if ([citys characterAtIndex:j]>='0'&&[citys characterAtIndex:j]<='9') {
                    cityRange.location=j;
                    break;
                }else{
                    cityRange.length++;
                }
            }
            if (i==2) {
                cityRange.location-=1;
                cityRange.length+=1;
            }
            cityRange.location+=1;
            cityRange.length-=1;
            [city_array addObject:[citys substringWithRange:cityRange]];
            cityRange.location=0;
            cityRange.length=0;
        }
    }
    NSLog(@"%d",city_array.count);
    
    //区号
    NSRange range=NSMakeRange(0, 10);
   number=[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<[citys length]; i++) {
        if ([citys characterAtIndex:i]==':') {
            range.location=i;
            [number addObject:[citys substringWithRange:range]];
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [city_array count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"cellID";
    UITableViewCell* Cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!Cell) {
    Cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    Cell.textLabel.text=[city_array objectAtIndex:indexPath.row];
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%@",[number objectAtIndex:indexPath.row]);
    CityID=[number objectAtIndex:indexPath.row];
    CityName=[city_array objectAtIndex:indexPath.row];
    [self.delegate customCityID];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
