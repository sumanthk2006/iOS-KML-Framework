//
//  KMLLatLonAltBox.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLatLonAltBox.h"
#import "KMLElementSubclass.h"

@implementation KMLLatLonAltBox {
    NSString *_northValue;
    NSString *_southValue;
    NSString *_eastValue;
    NSString *_westValue;
    NSString *_minAltitudeValue;
    NSString *_maxAltitudeValue;
    NSString *_altitudeModeValue;
}


@synthesize north = _north;
@synthesize south = _south;
@synthesize east = _east;
@synthesize west = _west;
@synthesize minAltitude = _minAltitude;
@synthesize maxAltitude = _maxAltitude;
@synthesize altitudeMode = _altitudeMode;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _northValue = [self textForSingleChildElementNamed:@"north" xmlElement:element required:YES];
        _southValue = [self textForSingleChildElementNamed:@"south" xmlElement:element required:YES];
        _eastValue = [self textForSingleChildElementNamed:@"east" xmlElement:element required:YES];
        _westValue = [self textForSingleChildElementNamed:@"west" xmlElement:element required:YES];
        _minAltitudeValue = [self textForSingleChildElementNamed:@"minAltitude" xmlElement:element];
        _maxAltitudeValue = [self textForSingleChildElementNamed:@"maxAltitude" xmlElement:element];
        _altitudeModeValue = [self textForSingleChildElementNamed:@"altitudeMode" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)north
{
    return [KMLType angle90:_northValue];
}

- (void)setNorth:(CGFloat)north
{
    _northValue = [KMLType valueForAngle90:north];
}

- (CGFloat)south
{
    return [KMLType angle90:_southValue];
}

- (void)setSouth:(CGFloat)south
{
    _southValue = [KMLType valueForAngle90:south];
}

- (CGFloat)east
{
    return [KMLType angle180:_eastValue];
}

- (void)setEast:(CGFloat)east
{
    _eastValue = [KMLType valueForAngle180:east];
}

- (CGFloat)west
{
    return [KMLType angle180:_westValue];
}

- (void)setWest:(CGFloat)west
{
    _westValue = [KMLType valueForAngle180:west];
}

- (CGFloat)minAltitude
{
    @try {
        return [_minAltitudeValue floatValue];
    }
    @catch (NSException *exception) {
    }

    return 0;
}

- (void)setMinAltitude:(CGFloat)minAltitude
{
    _minAltitudeValue = [NSString stringWithFormat:@"%f", minAltitude];
}

- (CGFloat)maxAltitude
{
    @try {
        return [_maxAltitudeValue floatValue];
    }
    @catch (NSException *exception) {
    }

    return 0;
}

- (void)setMaxAltitude:(CGFloat)maxAltitude
{
    _maxAltitudeValue = [NSString stringWithFormat:@"%f", maxAltitude];
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
    return @"LatLonAltBox";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_northValue tagName:@"north" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_southValue tagName:@"south" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_eastValue tagName:@"east" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_westValue tagName:@"west" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_minAltitudeValue defaultValue:@"0" tagName:@"minAltitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_maxAltitudeValue defaultValue:@"0" tagName:@"maxAltitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeModeValue defaultValue:@"clampToGround" tagName:@"altitudeMode" indentationLevel:indentationLevel];
}

@end
