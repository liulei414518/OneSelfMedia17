//
//  AppDelegate.h
//  OneSelfMedia
//
//  Created by EG365 on 12-11-28.
//  Copyright (c) 2012年 EG365. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SinaAppKey @"184257575"
#define SinaAppSecret @"104f87fcedcd41d88d9031a2a4f7a550"
#define access  @"2.00LBQSQC04oHTMcb9c5d04460ZHWpD"
#define TxAppKey @"801285069"
#define TxAppSecret @"e473386671ff491b54a329e0e8b5d53c"

#define DIR @"EG365/XUDANEI/"

#define SandBox(A) [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@%@", DIR, A]
//#define SandBox(A) [NSString stringWithFormat:@"/Users/EG365/Desktop/res/%@",A]
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
  
@end
