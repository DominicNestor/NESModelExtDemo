//
//  NESNumberHandlerTest.m
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NESNumberHandler.h"

@interface NESNumberHandlerTest : XCTestCase

@end

@implementation NESNumberHandlerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testStringToFloat
{
    NSNumber *num = [NESNumberHandler numberWith:@"10.123"];
    XCTAssert(abs(num.floatValue - 10.123) < 1e-6);
}

-(void)testInvalidStringToInt
{
    NSNumber *num = [NESNumberHandler numberWith:@"123asdf"];
    XCTAssert([num isEqualToNumber:[NSNumber numberWithInteger:0]]);
}

-(void)testNumberToNumber
{
    NSNumber *num = [NESNumberHandler numberWith:@10];
    XCTAssert([num isEqualToNumber:[NSNumber numberWithInteger:10]]);
}

-(void)testStringToInt
{
    NSNumber *num = [NESNumberHandler numberWith:@"10"];
    XCTAssert(num.integerValue == 10);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
