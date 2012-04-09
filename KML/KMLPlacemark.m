//
//  KMLPlacemark.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLPlacemark.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractGeometry.h"

@implementation KMLPlacemark

@synthesize geometry = _geometry;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _geometry = (KMLAbstractGeometry *)[self childElementOfClass:[KMLAbstractGeometry class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public method

- (void)setGeometry:(KMLAbstractGeometry *)geometry
{
    if (_geometry != geometry) {
        if (_geometry) {
            _geometry.parent = nil;
        }

        _geometry = geometry;
        if (_geometry) {
            _geometry.parent = self;
        }
    }
}


#pragma mark - Tag

+ (NSString *)tagName
{
    return @"Placemark";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    if (self.geometry) {
        [self.geometry kml:kml indentationLevel:indentationLevel];
    }
}

@end
