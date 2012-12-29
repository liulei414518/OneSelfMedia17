//
//  SinaOperator.h
//  NewSN
//
//  Created by eg365 on 12-10-9.
//
//

#import <Foundation/Foundation.h>
#import "WBEngine.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#define DEFAULTAVATARURKEY @"AvatarURL"
#define DEFAULTUSERNAMEKEY @"UserName"

typedef enum{
    TagRequestPersonalInfo = 188,
    TagRequestShareContent,
    TagRequestNone,
} TagRequestKind;

@protocol ContentViewDelegate <NSObject>

- (void)initContentViewDelegate;
- (void)disappearKeyBoard;

@end


@protocol SwicthDelegate <NSObject>

- (void)saveSwicth;
- (void)noSaveSwicth;

@end



@interface SinaOperator : NSObject<WBEngineDelegate,UIAlertViewDelegate>{
    TagRequestKind currentRequest;
    UIImage *myImage;
    id <ContentViewDelegate> contentDelegate;
}

@property (nonatomic, strong) WBEngine *wbEngine;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) id <ContentViewDelegate> contentDelegate;
@property (nonatomic, strong) id <SwicthDelegate> switchDelegate;
@property (nonatomic, strong) MBProgressHUD *hud;

+ (SinaOperator *)sharedSinaWeiboOperator;
- (BOOL) isBindSinaWeiBo;
- (void) bindSinaWeiBo;
- (void) cancleBindSinaWeiBo;
- (void) ShareFixedContent:(NSString *)Mytext;//分享微博
- (UIImage*)rotateImageByAngle:(float)angleInRadians withCG:(CGImageRef)Image;//旋转
- (NSString *)GetUseName;
-(BOOL)isExistenceNetwork;
@end
