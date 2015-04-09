//
//  NSObject+NESModel.m
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import "NSObject+NESModel.h"
#import "NESIVar.h"
#import "NESNumberHandler.h"
#import "NESDateHandler.h"
#import <objc/runtime.h>

@implementation NSObject (NESModel)

-(id)foundationModel
{
    return [NSJSONSerialization JSONObjectWithData:[self.jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
}

-(id)foundationArrayWith:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    
    dispatch_queue_t queue = dispatch_queue_create("foundationArrayQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_apply(arr.count, queue, ^(size_t i) {
        NSDictionary *dict = [[array objectAtIndex:i] foundationModel];
        if (dict) [arr addObject:dict];
    });
    
    return array;
}

+(id)mappingWithObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
        return [self mappingWithDictionary:object];
    else if ([object isKindOfClass:[NSArray class]])
        return [self mappingWithArray:object];
    return nil;
}

+(id)mappingWithDictionary:(NSDictionary *)dict
{
    id model = [[[self class] alloc] init];
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    static dispatch_queue_t queue = NULL;
    
    if (!queue) queue = dispatch_queue_create("mapping queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_apply(count, queue, ^(size_t i) {

        NESIVar *ivar = [NESIVar ivarWith:ivarList[i]];
        id value = nil;
        NSString *key = ivar.path == nil ? ivar.keyName : [NSString stringWithFormat:@"%@.%@",ivar.path,ivar.keyName];
        
        if (ivar.isTransparent) return;
        
        if (ivar.isModel || ivar.isArray) {
            value = [NSClassFromString(ivar.className) mappingWithObject:[dict valueForKeyPath:key]];
        }
        else if (ivar.isString)
        {
            value = [dict valueForKeyPath:key];
        }
        else if (ivar.isNumber)
        {
            value = [NESNumberHandler numberWith:[dict valueForKeyPath:key]];
        }
        else if (ivar.isDate)
        {
            value = [NESDateHandler dateWith:[dict valueForKeyPath:key]];
        }
        
        [model setValue:value forKey:ivar.propertyName];
    });
    
    free(ivarList);
    return model;
}

+(id)mappingWithArray:(NSArray *)array
{
    NSMutableArray *list = [NSMutableArray array];
    
    NSUInteger count = array.count;
    
    dispatch_queue_t queue = dispatch_queue_create("ListMappingQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(count, queue, ^(size_t i) {
        id model = [self mappingWithObject:[array objectAtIndex:i]];
        if (model) [list addObject:model];
    });
    
    return list;
}

-(NSString *)jsonString
{
    NSMutableString *jsonString = [[NSMutableString alloc] init];
    
    if ([self isKindOfClass:[NSArray class]]) {
        return [self jsonStringFromArr:(NSArray *)self];
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        return [self jsonStringFromDict:(NSDictionary *)self];
    }
    
    [jsonString appendString:@"{"];
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    NSMutableDictionary *pathDict = [NSMutableDictionary dictionary];
    
    for (int i=0; i<count; i++) {
        NESIVar *ivar = [NESIVar ivarWith:ivarList[i]];
        if (ivar.isTransparent) continue;
        id value = [self valueForKey:ivar.ivarName];
        if (ivar.path) {
            NSArray *paths = [ivar.path componentsSeparatedByString:@"."];
            __block NSMutableDictionary *lastPath = pathDict;
            [paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSMutableDictionary *temp = [lastPath objectForKey:obj];
                if (!temp) {
                    temp = [NSMutableDictionary dictionary];
                    [lastPath setObject:temp forKey:obj];
                }
                lastPath = temp;
            }];
            [lastPath setObject:value forKey:ivar.keyName];
            continue;
        }
        
        if (ivar.isModel)
            value = [value jsonString];
        else if(ivar.isDate)
            value = [NESDateHandler stringWith:value];
        else if(ivar.isArray)
        {
            value = [self jsonStringFromArr:value];
        }
        
        if (![value isKindOfClass:[NSString class]] || !([value hasPrefix:@"{"] || [value hasPrefix:@"["]))
            value = [NSString stringWithFormat:@"\"%@\"",value];
        
        [jsonString appendString:[NSString stringWithFormat:@"\"%@\":%@,",ivar.keyName,value]];
    }
    
    if (pathDict.count > 0) {
        NSString *temp = pathDict.jsonString;
        [jsonString appendString:temp];
    }
    else
        [jsonString deleteCharactersInRange:NSMakeRange(jsonString.length - 1, 1)];
    
    [jsonString appendString:@"}"];
    
    free(ivarList);
    
    return jsonString;
}

-(NSString *)jsonStringFromDict:(NSDictionary *)dict
{

    NSMutableString *jsonString = [[NSMutableString alloc] init];
    
    NSArray *keys = [dict allKeys];
    
    __block BOOL isDict = NO;
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [jsonString appendString:[NSString stringWithFormat:@"\"%@\":",obj]];
        id value = [dict objectForKey:obj];
        if ((isDict = [value isKindOfClass:[NSDictionary class]]))
            [jsonString appendString:@"{"];
        [jsonString appendString:[value jsonString]];
        [jsonString appendString:@","];
    }];
    
    [jsonString deleteCharactersInRange:NSMakeRange(jsonString.length - 1, 1)];
    if (isDict) [jsonString appendString:@"}"];
    
    return jsonString;
}

-(NSString *)jsonStringFromArr:(NSArray *)arr
{
    NSMutableString *jsonString = [[NSMutableString alloc] init];
    [jsonString appendString:@"["];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [jsonString appendString:[obj jsonString]];
        [jsonString appendString:@","];
    }];
    [jsonString deleteCharactersInRange:NSMakeRange(jsonString.length-1, 1)];
    [jsonString appendString:@"]"];
    return jsonString;
}

@end
