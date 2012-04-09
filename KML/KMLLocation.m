//
//  KMLLocation.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLocation.h"
#import "KMLElementSubclass.h"

@implementation KMLLocation {
    NSString *_longitudeValue;
    NSString *_latitudeValue;
    NSString *_altitudeValue;
}

@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize altitude = _altitude;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _longitudeValue = [self textForSingleChildElementNamed:@"longitude" xmlElement:element];
        _latitudeValue = [self textForSingleChildElementNamed:@"latitude" xmlElement:element];
        _altitudeValue = [self textForSingleChildElementNamed:@"altitude" xmlElement:element];
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


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Location";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_longitudeValue tagName:@"longitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_latitudeValue tagName:@"latitude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeValue defaultValue:@"0" tagName:@"altitude" indentationLevel:indentationLevel];
    
}

@end
