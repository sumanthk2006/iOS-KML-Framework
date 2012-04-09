//
//  KMLCoordinate.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLCoordinate.h"
#import "KMLElementSubclass.h"

@implementation KMLCoordinate {
    NSString *_longitudeValue;
    NSString *_latitudeValue;
    NSString *_altitudeValue;
}

@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize altitude = _altitude;


#pragma mark - instance

- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        double lon;
        double lat;
        double alt;
        
        NSScanner *scanner = [[NSScanner alloc] initWithString:text];
        [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@","]];

        if ([scanner scanDouble:&lon]) {
            _longitudeValue = [[NSNumber numberWithDouble:lon] stringValue];
        }
        if ([scanner scanDouble:&lat]) {
            _latitudeValue = [[NSNumber numberWithDouble:lat] stringValue];
        }
        if ([scanner scanDouble:&alt]) {
            _altitudeValue = [[NSNumber numberWithDouble:alt] stringValue];
        }
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)longitude
{
    if (!_longitude) {
        if (_longitudeValue) {
            _longitude = [_longitudeValue floatValue];
        } else {
            _longitude = 0.f;
        }
    }

    return _longitude;
}

- (void)setLongitude:(CGFloat)longitude
{
    _longitudeValue = [NSString stringWithFormat:@"%f", longitude];
}

- (CGFloat)latitude
{
    if (!_latitude) {
        if (_latitudeValue) {
            _latitude = [_latitudeValue floatValue];
        } else {
            _latitude = 0.f;
        }
    }
    
    return _latitude;
}

- (void)setLatitude:(CGFloat)latitude
{
    _latitudeValue = [NSString stringWithFormat:@"%f", latitude];
}

- (CGFloat)altitude
{
    if (!_altitude) {
        if (_altitudeValue) {
            _altitude = [_altitudeValue floatValue];
        } else {
            _altitude = 0.f;
        }
    }
    
    return _altitude;
}

- (void)setAltitude:(CGFloat)altitude
{
    _altitudeValue = [NSString stringWithFormat:@"%f", altitude];
}


#pragma mark - KML

- (void)kml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [kml appendFormat:@"%f,%f,%f", self.longitude, self.latitude, self.altitude];
}

@end
