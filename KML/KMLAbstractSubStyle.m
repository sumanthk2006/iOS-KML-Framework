//
//  KMLAbstractSubStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractSubStyle.h"
#import "KMLElementSubclass.h"
#import "KMLBalloonStyle.h"
#import "KMLListStyle.h"
#import "KMLAbstractColorStyle.h"

@implementation KMLAbstractSubStyle


#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractSubStyle";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLBalloonStyle class]];
    [array addObject:[KMLListStyle class]];
    [array addObjectsFromArray:[KMLAbstractColorStyle implementClasses]];
    return [NSArray arrayWithArray:array];
}

@end
