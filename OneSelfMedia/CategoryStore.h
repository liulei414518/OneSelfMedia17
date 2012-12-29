#import <Foundation/Foundation.h>
#import "Datal.h"
@class Datal;

@interface CategoryStore : NSObject
{
    NSMutableArray *allCategorys;
   
}

// Notice that this is a class method, and is prefixed with a + instead of a -
+ (CategoryStore *)defaultStore;

-(id)myDatal;


@end
