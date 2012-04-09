//
//  KMLAbstractGeometry.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractGeometry.h"
#import "KMLElementSubclass.h"
#import "KMLPoint.h"
#import "KMLLineString.h"
#import "KMLLinearRing.h"
#import "KMLPolygon.h"
#import "KMLMultiGeometry.h"
#import "KMLModel.h"

@implementation KMLAbstractGeometry


#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractGeometry";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLPoint class]];
    [array addObject:[KMLLineString class]];
    [array addObject:[KMLLinearRing class]];
    [array addObject:[KMLPolygon class]];
    [array addObject:[KMLMultiGeometry class]];
    [array addObject:[KMLModel class]];
    return [NSArray arrayWithArray:array];
}

@end
