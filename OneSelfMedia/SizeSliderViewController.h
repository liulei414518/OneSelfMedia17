//
//  SizeSliderViewController.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-7.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SizeChangeDelegate<NSObject>
-(void)sizeChange:(float)size;
@end
@interface SizeSliderViewController : UIViewController
{
    UISlider* _slider;
    int tmp;
    id <SizeChangeDelegate>delegate;

}
-(id)init:(int)count;
@property(strong,nonatomic)id <SizeChangeDelegate>delegate;

@end
