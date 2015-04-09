//
//  NESModelFormat.m
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/8.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import "NESModelFormat.h"

__strong static NSString *__prefix = nil;
__strong static NSString *__suffix = nil;

@implementation NESModelFormat

+(void)load
{
    __prefix = @"";
    __suffix = @"Model";
}

+(void)setModelPrefix:(NSString *)prefix
{
    __prefix = prefix;
}

+(void)setModelSuffix:(NSString *)suffix
{
    __suffix = suffix;
}

+(NSString *)prefix
{
    return __prefix;
}

+(NSString *)suffix
{
    return __suffix;
}



@end
