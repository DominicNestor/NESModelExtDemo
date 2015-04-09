//
//  NESDateHandlerTest.m
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NESDateHandler.h"

@interface NESDateHandlerTest : XCTestCase

@end

@implementation NESDateHandlerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testBlockHandler
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *date1 = [NESDateHandler dateWith:@"date:2015-10-10" using:^NSDate *(id object) {
        NSString *dateString = [[object componentsSeparatedByString:@":"] lastObject];
        return [fmt dateFromString:dateString];
    }];
    NSDate *date2 = [fmt dateFromString:@"2015-10-10"];
    XCTAssertEqualObjects(date1, date2);
}

-(void)testCustomFormatter
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    [NESDateHandler setDateFormatter:fmt];
    
    NSDate *date1 = [NESDateHandler dateWith:@"2015-10-10 11:11:11"];
    NSDate *date2 = [NESDateHandler dateWith:@"2015"];
    
    XCTAssertEqualObjects(date1, date2);
    
    date1 = [NESDateHandler dateWith:@"2015-10-10"];
    date2 = [fmt dateFromString:@"2015-10-10"];
    
    XCTAssertEqualObjects(date1, date2);
    
    [NESDateHandler setDateFormatter:[NESDateHandler defaultDateFormatter]];
}

-(void)testDefaultDateStringHandler
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:60*60*24*365*45 + 60*60*24 * 11];
    //45年+11个闰年+8个时区
    NSString *str = @"2015-01-01 08:00:00";
    NSString *target = [NESDateHandler stringWith:date];
    NSLog(@"%s-[%s]:%@",__func__,__TIME__,date);
    XCTAssertEqualObjects(str, target);
}

-(void)testCustomDateStringHandler
{
    NSString *str = @"自定义日期处理器";
    
    [NESDateHandler setDateStringHandler:^NSString *(NSDate * date) {
        return @"自定义日期处理器";
    }];
    
    NSString *target = [NESDateHandler stringWith:[NSDate date]];
    
    XCTAssertEqualObjects(str, target);
    
    [NESDateHandler setDateStringHandler:[NESDateHandler defaultDateStringHandler]];
    
}

-(void)testCustomDateHandler
{
    [NESDateHandler setDateHandler:^NSDate *(id object) {
        return [NSDate dateWithTimeIntervalSince1970:60*60*24*365*100];
    }];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:60*60*24*365*100];
    NSDate *target = [NESDateHandler dateWith:@"2015"];
    
    XCTAssertNotNil(target);
    XCTAssertEqualObjects(date, target);
    
    [NESDateHandler setDateHandler:[NESDateHandler defaultDateHandler]];
    
}

-(void)testDateFromInvalidateString
{
    NSDate *date = [NESDateHandler dateWith:@"a876yikdvhas"];
    NSDate *dateNow = [NSDate date];
    XCTAssertNotNil(date);
    NSTimeInterval t = dateNow.timeIntervalSince1970 - date.timeIntervalSince1970;
    XCTAssert(t > 0 && t < 0.001);
}

-(void)testDateFromTimeInterval
{
    NSDate *date1 = [NESDateHandler dateWith:@"2015/4/5 22:11:11.123"];
    NSDate *date2 = [NESDateHandler dateWith:@"2015"];
    XCTAssertNotNil(date1);
    XCTAssertNotNil(date2);
    XCTAssertEqualObjects(date1, date2);
}

-(void)testDateFromValidateString
{
    NSDate *date1 = [NESDateHandler dateWith:@"2014-4-5 22:10:19"];
    XCTAssertNotNil(date1);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
