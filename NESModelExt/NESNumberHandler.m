//
//  NESNumberHandler.m
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import "NESNumberHandler.h"

__strong static NSNumberFormatter *__defaultNumberFormatter = nil;
__strong static NSNumber *__defalutValueForNull = nil;

@implementation NESNumberHandler

+(void)load
{
    __defaultNumberFormatter = [[NSNumberFormatter alloc] init];
    __defalutValueForNull = @0;
}

+(void)setDefaultValueForNull:(NSNumber *)value
{
    __defalutValueForNull = value;
}

+(void)setNumberFormatter:(NSNumberFormatter *)numberFormatter
{
    __defaultNumberFormatter = numberFormatter;
}

+(NSNumber *)numberWith:(id)object
{
    if (object == nil) return __defalutValueForNull;
    
    if ([object isKindOfClass:[NSNumber class]]) return object;
    NSNumber *num = [__defaultNumberFormatter numberFromString:object];
    return num ? num : __defalutValueForNull;
}

@end
