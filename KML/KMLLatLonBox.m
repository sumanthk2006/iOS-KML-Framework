//
//  KMLLatLonBox.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLatLonBox.h"
#import "KMLElementSubclass.h"

@implementation KMLLatLonBox {
    NSString *_northValue;
    NSString *_southValue;
    NSString *_eastValue;
    NSString *_westValue;
    NSString *_rotationValue;
}

@synthesize north = _north;
@synthesize south = _south;
@synthesize east = _east;
@synthesize west = _west;
@synthesize rotation = _rotation;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _northValue = [self textForSingleChildElementNamed:@"north" xmlElement:element];
        _southValue = [self textForSingleChildElementNamed:@"south" xmlElement:element];
        _eastValue = [self textForSingleChildElementNamed:@"east" xmlElement:element];
        _westValue = [self textForSingleChildElementNamed:@"west" xmlElement:element];
        _rotationValue = [self textForSingleChildElementNamed:@"rotation" xmlElement:element];
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

- (CGFloat)rotation
{
    return [KMLType angle180:_rotationValue];
}

- (void)setRotation:(CGFloat)rotation
{
    _rotationValue = [KMLType valueForAngle180:rotation];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"LatLonBox";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_northValue tagName:@"north" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_southValue tagName:@"south" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_eastValue tagName:@"east" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_westValue tagName:@"west" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_rotationValue defaultValue:@"0" tagName:@"rotation" indentationLevel:indentationLevel];
}

@end
