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

@end

@implementation NESModelExtDemoTests

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
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
