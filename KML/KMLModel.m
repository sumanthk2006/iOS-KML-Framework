//
//  KMLModel.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLModel.h"
#import "KMLElementSubclass.h"
#import "KMLLocation.h"
#import "KMLOrientation.h"
#import "KMLScale.h"
#import "KMLLink.h"
#import "KMLResourceMap.h"

@implementation KMLModel {
    NSString *_altitudeModeValue;
}

@synthesize altitudeMode = _altitudeMode;
@synthesize location = _location;
@synthesize orientation = _orientation;
@synthesize scale = _scale;
@synthesize link = _link;
@synthesize resourceMap = _resourceMap;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _altitudeModeValue = [self textForSingleChildElementNamed:@"altitudeMode" xmlElement:element];
        
        _location = (KMLLocation *)[self childElementOfClass:[KMLLocation class] xmlElement:element];
        _orientation = (KMLOrientation *)[self childElementOfClass:[KMLOrientation class] xmlElement:element];
        _scale = (KMLScale *)[self childElementOfClass:[KMLScale class] xmlElement:element];
        _link = (KMLLink *)[self childElementOfClass:[KMLLink class] xmlElement:element];
        _resourceMap = (KMLResourceMap *)[self childElementOfClass:[KMLResourceMap class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (KMLAltitudeMode)altitudeMode
{
    return [KMLType altitudeMode:_altitudeModeValue];
}

- (void)setAltitudeMode:(KMLAltitudeMode)altitudeMode
{
    _altitudeModeValue = [KMLType valueForAltitudeMode:altitudeMode];
}

- (void)setLocation:(KMLLocation *)location
{
    if (_location != location) {
        if (_location) {
            _location.parent = nil;
        }
        
        _location = location;
        if (_location) {
            _location.parent = self;
        }
    }
}

- (void)setOrientation:(KMLOrientation *)orientation
{
    if (_orientation != orientation) {
        if (_orientation) {
            _orientation.parent = nil;
        }

        _orientation = orientation;
        if (_orientation) {
            _orientation.parent = self;
        }
    }
}

- (void)setScale:(KMLScale *)scale
{
    if (_scale != scale) {
        if (_scale) {
            _scale.parent = nil;
        }

        _scale = scale;
        if (_scale) {
            _scale.parent = self;
        }
    }
}

- (void)setLink:(KMLLink *)link
{
    if (_link != link) {
        if (_link) {
            _link.parent = nil;
        }

        _link = link;
        if (_link) {
            _link.parent = self;
        }
    }
}

- (void)setResourceMap:(KMLResourceMap *)resourceMap
{
    if (_resourceMap != resourceMap) {
        if (_resourceMap) {
            _resourceMap.parent = nil;
        }

        _resourceMap = resourceMap;
        if (_resourceMap) {
            _resourceMap.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Model";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_altitudeModeValue defaultValue:@"clampToGround" tagName:@"altitudeMode" indentationLevel:indentationLevel];

    if (self.location) {
        [self.location kml:kml indentationLevel:indentationLevel];
    }
    if (self.orientation) {
        [self.orientation kml:kml indentationLevel:indentationLevel];
    }
    if (self.scale) {
        [self.scale kml:kml indentationLevel:indentationLevel];
    }
    if (self.link) {
        [self.link kml:kml indentationLevel:indentationLevel];
    }
    if (self.resourceMap) {
        [self.resourceMap kml:kml indentationLevel:indentationLevel];
    }
}

@end
