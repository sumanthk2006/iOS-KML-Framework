//
//  KMLAbstractContainer.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractContainer.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractFeature.h"
#import "KMLFolder.h"
#import "KMLDocument.h"

@implementation KMLAbstractContainer {
    NSMutableArray *_features;
}

@synthesize features;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _features = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLAbstractFeature class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _features = array;
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)features
{
    return [NSArray arrayWithArray:_features];
}

- (void)addFeature:(KMLAbstractFeature *)feature
{
    if (feature) {
        NSUInteger index = [_features indexOfObject:feature];
        if (index == NSNotFound) {
            feature.parent = self;
            [_features addObject:feature];
        }
    }
}

- (void)addFeatures:(NSArray *)array
{
    for (KMLAbstractFeature *feature in array) {
        [self addFeature:feature];
    }
}

- (void)removeFeature:(KMLAbstractFeature *)feature
{
    NSUInteger index = [_features indexOfObject:feature];
    if (index != NSNotFound) {
        feature.parent = nil;
        [_features removeObject:feature];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractContainer";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLDocument class]];
    [array addObject:[KMLFolder class]];
    return [NSArray arrayWithArray:array];
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLAbstractFeature *feature in self.features) {
        [feature kml:kml indentationLevel:indentationLevel];
    }
}

@end
