//
//  NESNumberHandler.h
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NESNumberHandler : NSObject

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 16:41:51
 *
 *  当要转换的对象为nil时所返回的对象,默认为@0
 *
 *  @param value 全局nil处理对象
 */
+(void)setDefaultValueForNull:(NSNumber *)value;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 17:00:05
 *
 *  设置自定义的NumberFormatter,直接覆盖默认的NumberFormatter,全局有效
 *
 *  @param numberFormatter 自定义的NSNumberFormatter对象
 */
+(void)setNumberFormatter:(NSNumberFormatter *)numberFormatter;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-07 16:42:18
 *
 *  将object对象转为NSNumber对象,
 *  1. 当object为NSNumber时直接返回
 *  2. 当object为NSString是通过默认的NSNumberFormatter转化,如果转化失败返回全局默认对象,默认为@0
 *  3. 当object为nil时返回全局默认对象,默认为@0
 *
 *  @param object 要转换的对象
 *
 *  @return 转换后的值
 */
+(NSNumber *)numberWith:(id)object;

@end
