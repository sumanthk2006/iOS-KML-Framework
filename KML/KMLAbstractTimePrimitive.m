//
//  KMLAbstractTimePrimitive.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractTimePrimitive.h"
#import "KMLElementSubclass.h"
#import "KMLTimeSpan.h"
#import "KMLTimeStamp.h"

@implementation KMLAbstractTimePrimitive

#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractTimePrimitive";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLTimeSpan class]];
    [array addObject:[KMLTimeStamp class]];
    return [NSArray arrayWithArray:array];
}

@end
