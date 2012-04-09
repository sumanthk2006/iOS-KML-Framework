//
//  KMLDelete.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLDelete.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractFeature.h"

@implementation KMLDelete

@synthesize feature = _feature;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _feature = (KMLAbstractFeature *)[self childElementOfClass:[KMLAbstractFeature class] xmlElement:element];
    }
    return self;
}


#pragma mark - Publci methods

- (void)setFeature:(KMLAbstractFeature *)feature
{
    if (_feature != feature) {
        if (_feature) {
            _feature.parent = nil;
        }
        _feature = feature;
        if (_feature) {
            _feature.parent = self;
        }    
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Delete";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    if (self.feature) {
        [self.feature kml:kml indentationLevel:indentationLevel];
    }
}

@end
