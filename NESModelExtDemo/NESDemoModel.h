//
//  NESDemoModel.h
//  NESBaseModelDemo
//
//  Created by Nestor on 15/4/7.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NESOtherModel.h"
#import "NESThirdModel.h"
#import "NESFourthModel.h"

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
@property (nonatomic,assign) NSString * notExists_;

@end
