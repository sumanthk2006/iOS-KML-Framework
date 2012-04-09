//
//  KMLGroundOverlay.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLGroundOverlay.h"
#import "KMLElementSubclass.h"
#import "KMLLatLonBox.h"

@implementation KMLGroundOverlay {
    NSString *_altitudeValue;
    NSString *_altitudeModeValue;
}

@synthesize altitude = _altitude;
@synthesize altitudeMode = _altitudeMode;
@synthesize latLonBox = _latLonBox;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _altitudeValue = [self textForSingleChildElementNamed:@"altitude" xmlElement:element];
        _altitudeModeValue = [self textForSingleChildElementNamed:@"altitudeMode" xmlElement:element];
        
        _latLonBox = (KMLLatLonBox *)[self childElementOfClass:[KMLLatLonBox class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (NSInteger)altitude
{
    @try {
        return [_altitudeValue integerValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0;
}

- (void)setAltitude:(NSInteger)altitude
{
    _altitudeValue = [NSString stringWithFormat:@"%d", altitude];
}

- (KMLAltitudeMode)altitudeMode
{
    return [KMLType altitudeMode:_altitudeModeValue];
}

- (void)setAltitudeMode:(KMLAltitudeMode)altitudeMode
{
    _altitudeModeValue = [KMLType valueForAltitudeMode:altitudeMode];
}

- (void)setLatLonBox:(KMLLatLonBox *)latLonBox
{
    if (_latLonBox != latLonBox) {
        if (_latLonBox) {
            _latLonBox.parent = nil;
        }
        
        _latLonBox = latLonBox;
        if (_latLonBox) {
            _latLonBox.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"GroundOverlay";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_altitudeValue defaultValue:@"0" tagName:@"altitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeModeValue defaultValue:@"clampToGround" tagName:@"altitudeMode" indentationLevel:indentationLevel];
    
    if (self.latLonBox) {
        [self.latLonBox kml:kml indentationLevel:indentationLevel];
    }
}

@end
