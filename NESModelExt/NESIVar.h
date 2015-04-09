//
//  NESIVar.h
//  NESWebKit
//
//  Created by Nestor on 15/4/1.
//  Copyright (c) 2015年 NesTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NESIVar : NSObject

@property (nonatomic,copy) NSString *typeEncoding;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,copy) NSString *ivarName;
@property (nonatomic,copy) NSString *propertyName;
@property (nonatomic,copy) NSString *keyName;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,assign) BOOL isObject;
@property (nonatomic,assign) BOOL isString;
@property (nonatomic,assign) BOOL isNumber;
@property (nonatomic,assign) BOOL isDate;
@property (nonatomic,assign) BOOL isArray;
@property (nonatomic,assign) BOOL isModel;
@property (nonatomic,assign) BOOL isTransparent;

+(NESIVar *)ivarWith:(Ivar)v;

@end
