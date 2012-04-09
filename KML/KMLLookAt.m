//
//  KMLLookAt.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLookAt.h"
#import "KMLElementSubclass.h"

@implementation KMLLookAt {
    NSString *_longitudeValue;
    NSString *_latitudeValue;
    NSString *_altitudeValue;
    NSString *_headingValue;
    NSString *_tiltValue;
    NSString *_rangeValue;
    NSString *_altitudeModeValue;
}

@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize altitude = _altitude;
@synthesize heading = _heading;
@synthesize tilt = _tilt;
@synthesize range = _range;
@synthesize altitudeMode = _altitudeMode;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _longitudeValue = [self textForSingleChildElementNamed:@"longitude" xmlElement:element];
        _latitudeValue = [self textForSingleChildElementNamed:@"latitude" xmlElement:element];
        _altitudeValue = [self textForSingleChildElementNamed:@"altitude" xmlElement:element];
        _tiltValue = [self textForSingleChildElementNamed:@"tilt" xmlElement:element];
        _rangeValue = [self textForSingleChildElementNamed:@"range" xmlElement:element required:YES];
        _altitudeModeValue = [self textForSingleChildElementNamed:@"altitudeMode" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)longitude
{
    return [KMLType angle180:_longitudeValue];
}

- (void)setLongitude:(CGFloat)longitude
{
    _longitudeValue = [KMLType valueForAngle180:longitude];
}

- (CGFloat)latitude
{
    return [KMLType angle90:_latitudeValue];
}

- (void)setLatitude:(CGFloat)latitude
{
    _latitudeValue = [KMLType valueForAngle90:latitude];
}

- (CGFloat)altitude
{
    @try {
        return [_altitudeValue doubleValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0;
}

- (void)setAltitude:(CGFloat)altitude
{
    _altitudeValue = [NSString stringWithFormat:@"%d", altitude];
}

- (CGFloat)heading
{
    return [KMLType angle360:_headingValue];
}

- (void)setHeading:(CGFloat)heading
{
    _headingValue = [KMLType valueForAngle360:heading];
}

- (CGFloat)tilt
{
    return [KMLType anglepos180:_tiltValue];
}

- (void)setTilt:(CGFloat)tilt
{
    _tiltValue = [KMLType valueForAnglepos180:tilt];
}

- (CGFloat)range
{
    @try {
        return [_rangeValue doubleValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0;
}

- (void)setRange:(CGFloat)range
{
    _rangeValue = [NSString stringWithFormat:@"%d", range];
}

- (KMLAltitudeMode)altitudeMode
{
    return [KMLType altitudeMode:_altitudeModeValue];
}

- (void)setAltitudeMode:(KMLAltitudeMode)altitudeMode
{
    _altitudeModeValue = [KMLType valueForAltitudeMode:altitudeMode];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"LookAt";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_longitudeValue defaultValue:@"0" tagName:@"longitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_latitudeValue defaultValue:@"0" tagName:@"latitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeValue defaultValue:@"0" tagName:@"altitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_tiltValue defaultValue:@"0" tagName:@"tilt" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_rangeValue defaultValue:@"0" tagName:@"range" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeModeValue defaultValue:@"clampToGround" tagName:@"altitudeMode" indentationLevel:indentationLevel];
}

@end
