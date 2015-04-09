//
//  NSObject+NESModel.h
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NESModel)

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-09 11:06:18
 *
 *  核心方法,将指定的数组或词典映射成为模型对象.模型对象需要按照约定进行类名和属性名的约定
 *
 *  ###模型类命名
 *  通过`前缀+名称+后缀`完成完整的模型类命名,默认前缀为@"",后缀为@"Model",名称为自定义字符串
 *  可以通过NESModelFormat类调整全局的前缀和后缀字符串
 *
 *  @see NESModelFormat
 *
 *  ###属性命名
 *  1.直接映射,属性名与json键值相同
 *  2.间接映射,以字母开头,以"_"连接,前边为任意字符串,后边为json键,例:"test_key"
 *  3.数组映射,对于数组类型的属性,用"_"连接模型名称和json键即可完成映射
 *      例:"test_arr",在默认情况下将会把json对象中"arr"对应的数组映射成为TestModel模型的数组
 *  4.路径映射,当希望将json内部的某个对象直接映射成为模型属性的时候使用,以"_"开头,每一级路径以"_"连接
 *  以json键作为结尾,路径映射可以包含多级路径
 *      例:"_path_demo",对应json对象中path.demo对应的对象
 *  5.忽略属性,当需要在模型中定义一个json对象中没有的属性,同时在进行json字符串转化时将其忽略的属性时,直接在属性名最后加`_`
 *
 *  ###数据类型
 *  数据大体分为对象,模型,字符串,数字,日期和数组,不同字段会根据类型进行自动映射,日期类型会进行单独处理
 *  对于日期类型,通过NESDateHandler提供一个默认的NSDateFormatter对该字段进行处理,
 *  默认情况下可以自动转换匹配"yyyy-MM-dd HH:mm:ss"格式的日期字符串
 *  或者根据时间戳获取从"1970-1-1 00:00:00"开始计算的日期对象,
 *  也可以自由修改NESDateHandler的全局配置对日期进行自定义处理.
 *
 *  @see NESDateHandler
 *
 *  @param object 需要进行映射的对象,词典,数组均可
 *
 *  @return object为数组:消息接收类的对象所组成的数组
 *             object为词典:消息接收类的对象
 */
+(id)mappingWithObject:(id)object;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-09 11:06:21
 *
 *  将当前对象转成json字符串,可以将任意模型类或者包含模型类的数组转换成json字符串
 *
 *  @return 转换后的json字符串
 *  @warn 该方法对词典等非模型类进行转化时无法得出正确结果
 */
-(NSString *)jsonString;

/**
 *  @author writen by Nestor. Personal site - http://www.nestor.me , 15-04-09 15:09:45
 *
 *  将模型类或者包含模型类的数组转化成为词典类或者包含词典类的数组
 *
 *  @return 转换后的对象
 */
-(id)foundationModel;

@end
