//
//  NESDateHandler.h
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NESDateHandler : NSObject

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 14:20:27
 *
 *  设置全局的日期格式化器,所有使用了`NSObject+NESModel`进行映射的类都会按照用户指定的日期格式进行转换.自定义格式化器与默认的分开存储,随时可以通过`+defaultDateFormatter`方法获取
 *
 *  @param formatter 用户自定义的日期格式化器
 */
+(void)setDateFormatter:(NSDateFormatter *)formatter;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 14:41:46
 *
 *  设置全局日期处理器,与默认的日期处理器分开存储,
 *  仍可以通过`+defaultDateHandler`获取默认日期处理器
 *
 *  @param handler 将id转为NSDate对象的block
 */
+(void)setDateHandler:(NSDate *(^)(id object))handler;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 14:53:13
 *
 *  设置全局日期字符串处理器,与默认的日期字符串处理器分开存储,
 *  仍可以通过`+defaultDateHandler`获取默认日期处理器
 *
 *  @param handler 将NSDate对象转换为字符串的block
 */
+(void)setDateStringHandler:(NSString *(^)(NSDate * date))handler;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 14:54:09
 *
 *  通过id类型的对象获取日期对象,默认调用`+dateWith:using:`方法,
 *  如果没有通过`+setDateHandler:`方法设置自定义的处理器,那么就会使用默认的处理器
 *
 *  @param object 要转换的对象
 *
 *  @return 转换之后的日期对象
 */
+(NSDate *)dateWith:(id)object;


/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 14:58:36
 *
 *  通过id类型的对象获取日期对象
 *
 *  @param object      带转换的对象
 *  @param dateHandler 日期处理器block
 *
 *  @return 转换之后的日期对象,默认情况下如果转换失败返回当前时间
 */
+(NSDate *)dateWith:(id)object using:(NSDate *(^)(id object))dateHandler;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 15:03:31
 *
 *  将日期对象转为字符串,默认调用`+stringWith:using:`方法,
 *  如果没有通过`+setDateStringHandler:`方法设置自定义的处理器,那么就会使用默认的处理器
 *
 *  @param date 要转换的NSDate对象
 *
 *  @return 转换后的字符串
 */
+(NSString *)stringWith:(NSDate *)date;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 15:04:41
 *
 *  将日期对象转为字符串
 *
 *  @param date              要转换的NSDate对象
 *  @param dateStringHandler 日期字符串处理器
 *
 *  @return 转换后的字符串,默认情况下如果`date`参数为nil则返回当前日期对应的字符串
 */
+(NSString *)stringWith:(NSDate *)date using:(NSString *(^)(NSDate *date))dateStringHandler;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 16:18:38
 *
 *  默认的日期日期格式化器:
 *  fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
 *  fmt.timeZone = [NSTimeZone localTimeZone];
 *  fmt.locale = [NSLocale autoupdatingCurrentLocale];
 *
 *  @return dateFormatter对象
 */
+(NSDateFormatter *)defaultDateFormatter;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 15:06:21
 *
 *  返回默认的日期处理器,首先通过全局的dateFormatter按照日期格式字符串进行转化,如果所得结果为nil,则获取id的double值,通过`dateWithTimeIntervalSince1970:`方法进行转化,如果不包含有效的double值则返回当前日期
 *  @note 无论是否手动指定dateFormatter,默认的处理器都不会返回nil,如果无法解析则返回当前日期
 *
 *  @warn 这一设计的目的在于可以方便的处理日期格式字符串和时间戳,但是如果是由于日期字符串部分匹配有可能导致按照时间戳转化而得到一个错误的结果,如@"2015/4/7 15:30:00.123",由于对应的日期格式字符串为"yyyy-MM-dd HH:mm:ss",无法匹配,而字符串取double得到的是`2015`,最终得到的结果将会是[NSDate dateWithTimeIntervalSince1970:2015]对应的结果
 */
+(NSDate *(^)(id))defaultDateHandler;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 15:06:46
 *
 *  返回默认的日期字符串处理器,如果date对象不为nil则按照全局的dateFormatter指定的格式返回字符串,否则返回当前日期的字符串
 */
+(NSString *(^)(NSDate *))defaultDateStringHandler;

@end
