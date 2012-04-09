//
//  KMLPoint.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLPoint.h"
#import "KMLElementSubclass.h"
#import "KMLCoordinate.h"

@implementation KMLPoint {
    NSString *_extrudeValue;
    NSString *_altitudeModeValue;
    NSString *_coordinatesValue;
}

@synthesize extrude = _extrude;
@synthesize altitudeMode = _altitudeMode;
@synthesize coordinate = _coordinate;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _extrudeValue = [self textForSingleChildElementNamed:@"extrude" xmlElement:element];
        _altitudeModeValue = [self textForSingleChildElementNamed:@"altitudeMode" xmlElement:element];
        _coordinatesValue = [self textForSingleChildElementNamed:@"coordinates" xmlElement:element required:YES];
    }
    return self;
}


#pragma mark - Public methods

- (BOOL)extrude
{
    return [KMLType boolean:_extrudeValue];
}

- (void)setExtrude:(BOOL)extrude
{
    _extrudeValue = [KMLType valueForBoolean:extrude];
}

- (KMLAltitudeMode)altitudeMode
{
    return [KMLType altitudeMode:_altitudeModeValue];
}

- (void)setAltitudeMode:(KMLAltitudeMode)altitudeMode
{
    _altitudeModeValue = [KMLType valueForAltitudeMode:altitudeMode];
}

- (KMLCoordinate *)coordinate
{
    if (!_coordinate) {
        _coordinate = [[KMLCoordinate alloc] initWithText:_coordinatesValue];
    }
    
    return _coordinate;
}

- (void)setCoordinate:(KMLCoordinate *)coordinate
{
    if (_coordinate != coordinate) {
        if (_coordinate) {
            _coordinate.parent = nil;
        }
        
        _coordinate = coordinate;
        if (_coordinate) {
            _coordinate.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Point";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_extrudeValue defaultValue:@"0" tagName:@"extrude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeModeValue defaultValue:@"clampToGround" tagName:@"altitudeMode" indentationLevel:indentationLevel];

    [kml appendFormat:@"%@<coordinates>", [self indentForIndentationLevel:indentationLevel]];
    [self.coordinate kml:kml indentationLevel:indentationLevel];
    [kml appendString:@"</coordinates>\r\n"];
}

@end
