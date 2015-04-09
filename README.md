### NESModelExt
将json对象映射成为本地的model对象,或将model对象转成相应的json字符串

### 导入

* 将`NESModelExtDemo/NESModelExt`文件夹中的所有源代码拽入项目中
* 导入主头文件：`#import "NESModelExt.h"`

### 属性命名

*  1.直接映射,属性名与json键值相同
*  2.间接映射,以字母开头,以`_`连接,前边为任意字符串,后边为json键,例:`test_key`
*  3.数组映射,对于数组类型的属性,用`_`连接模型名称和json键即可完成映射
		例:`test_arr`,在默认情况下将会把json对象中`arr`对应的数组映射成为TestModel模型的数组
*  4.路径映射,当希望将json内部的某个对象直接映射成为模型属性的时候使用,以`_`开头,每一级路径以`_`连接
   以json键作为结尾,路径映射可以包含多级路径
		例:`_path_demo`,对应json对象中path.demo对应的对象
		
### 数据类型

数据大体分为对象,模型,字符串,数字,日期和数组,不同字段会根据类型进行自动映射,日期类型会进行单独处理.
对于日期类型,通过NESDateHandler提供一个默认的NSDateFormatter对该字段进行处理,
默认情况下可以自动转换匹配"yyyy-MM-dd HH:mm:ss"格式的日期字符串
或者根据时间戳获取从"1970-1-1 00:00:00"开始计算的日期对象,
也可以自由修改NESDateHandler的全局配置对日期进行自定义处理.
 
### 示例

* 词典原型

```objc

	-(NSDictionary *)fakeData
	{
		return @{@"name":@"jack",
				 @"id":@"123",
				 @"code":@"4567890-",
				 @"other":@{@"attr1":@"value1",@"attr2":@"150",@"attr3":@"0.8"},
				 @"test":@"3",
				 @"d":@"4.5",
				 @"l":@"3456789",
				 @"f":@"123.123",
				 @"b":@"1",
				 @"date1":@"13567890456",
				 @"date2":@"2015-4-3 11:18:24",
				 @"arr":@[
							@{@"attr1":@"value1",@"attr2":@"150",@"attr3":@"0.8"},
							@{@"attr1":@"value1",@"attr2":@"150",@"attr3":@"0.8"}],
				 @"path":@{
						 @"third":@{@"name":@"rose",@"age":@"123"},
						 @"3rd":@{@"name":@"rose",@"age":@"123"},
						 @"sub":@{
								 @"fourth":@{@"name":@"rose",@"age":@"123"},
								 @"4th":@{@"name":@"rose",@"age":@"123"}}
						 }
				 };
    
	}


* 模型定义

```objc
	@interface NESDemoModel : NSObject
	@property (nonatomic,retain) NSString *name;
	@property (nonatomic,retain) NSString *test_id;
	@property (nonatomic,retain) NSString *code;
	@property (nonatomic,retain) NESOtherModel *other;
	@property (nonatomic,assign) int test;
	@property (nonatomic,assign) double d;
	@property (nonatomic,assign) long l;
	@property (nonatomic,assign) float f;
	@property (nonatomic,assign) BOOL b;
	@property (nonatomic,retain) NSDate *date1;
	@property (nonatomic,retain) NSDate *date2;
	@property (nonatomic,retain) NSArray *other_arr;
	@property (nonatomic,retain) NESThirdModel *_path_third;
	@property (nonatomic,retain) NESThirdModel *_path_3rd;
	@property (nonatomic,retain) NESFourthModel *_path_sub_fourth;
	@property (nonatomic,retain) NESFourthModel *_path_sub_4th;
	@end


* 映射后通过jsonString生成的json字符串

```objc
	{
		"b":"1",
		"test":"3",
		"f":"123.123",
		"name":"jack",
		"id":"123",
		"code":"4567890-",
		"other":{
			"attr3":"0.8",
			"attr1":"value1",
			"attr2":"150"},
		"d":"4.5",
		"l":"3456789",
		"date1":"2399-12-14 02:27:36",
		"date2":"2015-04-03 11:18:24",
		"arr":[
				{"attr3":"0.8","attr1":"value1","attr2":"150"},
				{"attr3":"0.8","attr1":"value1","attr2":"150"}
			],
		"path":{
			"third":{"age":"123","name":"rose"},
			"3rd":{"age":"123","name":"rose"},
			"sub":{
				"fourth":{"age":"123","name":"rose"},
				"4th":{"age":"123","name":"rose"}
					}
				}
	}


### 其他细节

* 对于日期类型字段的处理详见`NESDateHandler`
* 对于数字类型字段的处理详见`NESNumberHandler`
* 对于模型类的命名规则详见`NESModelFormat`
