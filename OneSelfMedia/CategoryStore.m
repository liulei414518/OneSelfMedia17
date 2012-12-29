#import "CategoryStore.h"


static CategoryStore *defaultStore = nil;

@implementation CategoryStore

+ (CategoryStore *)defaultStore
{
    if (!defaultStore) {
        // Create the singleton
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}

// Prevent creation of additional instances
+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    // If we already have an instance of PossessionStore...
    if (defaultStore) {
        
        // Return the old one
        return defaultStore;
    }
    
    self = [super init];
    if (self) {
        allCategorys = [[NSMutableArray alloc] init];
        Datal *user1=[[Datal alloc]init];
        user1.bookName=@" ";
       
        [allCategorys addObject:user1];
        
       
    }
    return self;
}

/*
-(id)release
{
    // Do nothing
    return nil;
}

-(id)retain
{
    // Do nothing
    return self;
}
*/

-(NSUInteger)retainCount
{
    return NSUIntegerMax;
}

-(id)myDatal{
   
    return [allCategorys objectAtIndex:0];
  
}

@end
