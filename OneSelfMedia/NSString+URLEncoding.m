//
//  NSString+URLEncoding.m
//  JSON
//
//  Created by heromerlin on 12-8-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)
- (NSString*)urlEncodeString{
    NSString* result = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@";/?:@&=$+{}<>", kCFStringEncodingUTF8);
    return [result autorelease];
}
@end
