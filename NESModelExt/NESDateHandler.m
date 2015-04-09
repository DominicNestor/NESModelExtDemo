//
//  NESDateHandler.m
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import "NESDateHandler.h"

__strong static NSDateFormatter * __defaultDateFormatter = nil;
__strong static NSDateFormatter * __customDateFormatter = nil;
__strong static NSDate *(^__defaultDateHandler)(id object) = nil;
__strong static NSDate *(^__customDateHandler)(id object) = nil;
__strong static NSString *(^__defaultDateStringHandler)(NSDate *date) = nil;
__strong static NSString *(^__customDateStringHandler)(NSDate *date) = nil;


@implementation NESDateHandler

+(void)load
{
    __defaultDateFormatter = [[NSDateFormatter alloc] init];
    __defaultDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    __defaultDateFormatter.timeZone = [NSTimeZone localTimeZone];
    __defaultDateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
    
    __defaultDateHandler = ^(id object){
        NSDate *date = [__customDateFormatter == nil ? __defaultDateFormatter : __customDateFormatter dateFromString:object];
        date = date ? date : [object doubleValue] == 0 ? [NSDate date] : [NSDate dateWithTimeIntervalSince1970:[object doubleValue]];
        return date;
    };
    
    __defaultDateStringHandler = ^(NSDate *date){
        return [__customDateFormatter == nil ? __defaultDateFormatter : __customDateFormatter stringFromDate:date ? date : [NSDate date]];
    };
    
}

+(NSDate *)dateWith:(id)object
{
    return [self dateWith:object using:__customDateHandler == nil ? [self defaultDateHandler] : __customDateHandler];
}

+(NSDate *)dateWith:(id)object using:(NSDate *(^)(id))dateHandler
{
    return dateHandler(object);
}

+(NSString *)stringWith:(NSDate *)date
{
    return [self stringWith:date using:__customDateStringHandler == nil ? [self defaultDateStringHandler] : __customDateStringHandler];
}

+(NSString *)stringWith:(NSDate *)date using:(NSString *(^)(NSDate *))dateStringHandler
{
    return dateStringHandler(date);
}

+(void)setDateFormatter:(NSDateFormatter *)formatter
{
    __customDateFormatter = formatter;
}

+(void)setDateHandler:(NSDate *(^)(id))handler
{
    __customDateHandler = handler;
}

+(void)setDateStringHandler:(NSString *(^)(NSDate *))handler
{
    __customDateStringHandler = handler;
}

+(NSDateFormatter *)defaultDateFormatter
{
    return __defaultDateFormatter;
}

+(NSDate *(^)(id))defaultDateHandler
{
    return __defaultDateHandler;
}

+(NSString *(^)(NSDate *))defaultDateStringHandler
{
    return __defaultDateStringHandler;
}

@end
