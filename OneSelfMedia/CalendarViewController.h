//
//  CalendarViewController.h
//  OneSelfMedia
//
//  Created by EG365 on 12-12-18.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
@interface CalendarViewController : UIViewController
<CKCalendarDelegate>
{
    CKCalendarView* calendar;
}
@end
