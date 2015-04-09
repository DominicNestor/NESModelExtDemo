//
//  NESModelFormat.h
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/8.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-08 11:21:16
 *
 *  定义模型类类名的约定格式,通过前缀+描述+后缀的形式组成模型的约定命名
 *  主要在模型类的属性为包含另一模型的数组时使用,针对这类属性的命名统一约定为`模型描述字符串_JsonKey`
 *  例:
 *  NESDemoModel, 其中`NES`为前缀, `Model`为后缀, `Demo`为描述字符串.
 *  该模型有一个`NSArray`类型的属性,数组中的每一个元素都是NESOtherModel类型的模型,在json对象中储存该属性数据的key为"array"
 *  根据约定,该属性的命名应为`other_array`,那么将会自动将json对象中的`array`数组映射成为`NESOtherModel`对象的数组
 *
 */
@interface NESModelFormat : NSObject

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-08 11:21:45
 *
 *  设置全局模型名前缀,默认为空字符串,即@""
 *
 *  @param prefix 全局前缀
 */
+(void)setModelPrefix:(NSString *)prefix;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-08 11:22:15
 *
 *  @return 全局模型名前缀
 */
+(NSString *)prefix;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-08 11:21:45
 *
 *  设置全局模型名后缀,默认为@"Model"
 *
 *  @param prefix 全局前缀
 */
+(void)setModelSuffix:(NSString *)suffix;
+(NSString *)suffix;

@end
