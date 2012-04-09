//
//  KMLAbstractStyleSelector.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractStyleSelector.h"
#import "KMLElementSubclass.h"
#import "KMLStyle.h"
#import "KMLStyleMap.h"

@implementation KMLAbstractStyleSelector


#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractStyleSelector";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLStyle class]];
    [array addObject:[KMLStyleMap class]];
    return [NSArray arrayWithArray:array];
}

@end
