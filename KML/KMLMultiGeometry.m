//
//  NAKLMultiGeometry.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLMultiGeometry.h"
#import "KMLElementSubclass.h"

@implementation KMLMultiGeometry {
    NSMutableArray *_geometries;
}

@synthesize geometries;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _geometries = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLAbstractGeometry class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _geometries = array;
    }
    return self;
}

#pragma mark - Public methods

- (NSArray *)geometries
{
    return [NSArray arrayWithArray:_geometries];
}

- (void)addGeometry:(KMLAbstractGeometry *)geometry
{
    if (geometry) {
        NSUInteger index = [_geometries indexOfObject:geometry];
        if (index == NSNotFound) {
            geometry.parent = self;
            [_geometries addObject:geometry];
        }
    }
}

- (void)addGeometries:(NSArray *)array
{
    for (KMLAbstractGeometry *geometry in array) {
        [self addGeometry:geometry];
    }
}

- (void)removeGeometry:(KMLAbstractGeometry *)geometry
{
    NSUInteger index = [_geometries indexOfObject:geometry];
    if (index != NSNotFound) {
        geometry.parent = nil;
        [_geometries removeObject:geometry];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"MultiGeometry";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLAbstractGeometry *geometry in self.geometries) {
        [geometry kml:kml indentationLevel:indentationLevel];
    }
}

@end
