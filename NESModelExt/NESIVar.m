//
//  NESIVar.m
//  NESWebKit
//
//  Created by Nestor on 15/4/1.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import "NESIVar.h"
#import "NESModelFormat.h"

static const char * numTypes = "islqCISLQfdB";

@implementation NESIVar

+(NESIVar *)ivarWith:(Ivar)v
{
    NESIVar *ivar = [[NESIVar alloc] init];
    
    const char * name = ivar_getName(v);
    ivar.ivarName = [NSString stringWithUTF8String:name];
    if (*name == '_') name++;
    
    ivar.propertyName = [NSString stringWithUTF8String:name];
    
    if ([ivar.propertyName hasPrefix:@"_"]) {
        NSArray *temp = [ivar.propertyName componentsSeparatedByString:@"_"];
        ivar.path = [[temp subarrayWithRange:NSMakeRange(1, temp.count - 2)] componentsJoinedByString:@"."];
    }
    
    ivar.keyName = [[ivar.propertyName componentsSeparatedByString:@"_"] lastObject];
    
    if ((ivar.isTransparent = ivar.keyName.length == 0)) return ivar;
    
    const char * typeEncoding = ivar_getTypeEncoding(v);
    
    ivar.typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    ivar.isObject = *typeEncoding == '@';
    
    if (ivar.isObject) {
        ivar.className = [[NSString stringWithUTF8String:typeEncoding] substringFromIndex:2];
        ivar.className = [ivar.className substringToIndex:ivar.className.length -1 ];
        
        if ([ivar.className hasSuffix:[NESModelFormat suffix]])
            ivar.isModel = YES;
        else if ([ivar.className isEqualToString:@"NSString"] || [ivar.className isEqualToString:@"NSMutableString"])
            ivar.isString = YES;
        else if ([ivar.className isEqualToString:@"NSDate"])
            ivar.isDate = YES;
        else if ([ivar.className isEqualToString:@"NSArray"] || [ivar.className isEqualToString:@"NSMutableArray"])
        {
            ivar.isArray = YES;
            ivar.className = [[[ivar.propertyName componentsSeparatedByString:@"_"] firstObject] capitalizedString];
            ivar.className = [[[NESModelFormat prefix] stringByAppendingString:ivar.className] stringByAppendingString:[NESModelFormat suffix]];
        }
    }
    else
    {
        const char c = *typeEncoding;
        char *ptr = (char *)numTypes;
        while (!(ivar.isNumber = *ptr == c) && *ptr++);
    }
    
    return ivar;
}


@end
