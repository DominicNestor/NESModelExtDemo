//
//  NESModelExtDemoTests.m
//  NESModelExtDemoTests
//
//  Created by Nestor on 15/4/9.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSObject+NESModel.h"
#import "NESDemoModel.h"

@interface NESModelExtDemoTests : XCTestCase

@property (nonatomic,retain) NSDictionary *fakeData;

@end

@implementation NESModelExtDemoTests

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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testModelToJson
{
    NESOtherModel *model = [NESOtherModel new];
    model.attr1 = @"test";
    NSLog(@"%s-[%s]:%@",__func__,__TIME__,model.jsonString);
}

-(void)testDictToJson
{
    NSDictionary * dict = @{@"test":@"123",@"aaa":@"bbb"};
    NSString *str = dict.jsonString;
    NSLog(@"%s-[%s]:%@",__func__,__TIME__,str);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i=0; i<1000; i++) {
        [arr addObject:self.fakeData];
    }
    
    [self measureBlock:^{
        
        NSArray *modes = [NESDemoModel mappingWithObject:arr];
        NSLog(@"%s-[%s]:%lu",__func__,__TIME__,modes.count);
        // Put the code you want to measure the time of here.
    }];
}

@end
