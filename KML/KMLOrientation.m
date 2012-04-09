//
//  KMLOrientation.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLOrientation.h"
#import "KMLElementSubclass.h"

@implementation KMLOrientation {
    NSString *_headingValue;
    NSString *_tiltValue;
    NSString *_rollValue;
}

@synthesize heading = _heading;
@synthesize tilt = _tilt;
@synthesize roll = _roll;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _headingValue = [self textForSingleChildElementNamed:@"heading" xmlElement:element];
        _tiltValue = [self textForSingleChildElementNamed:@"tilt" xmlElement:element];
        _rollValue = [self textForSingleChildElementNamed:@"roll" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)heading
{
    @try {
        CGFloat f = [_headingValue floatValue];
        if (0.f <= f && f <= 360.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setHeading:(CGFloat)heading
{
    _headingValue = [NSString stringWithFormat:@"%f", heading];
}

- (CGFloat)tilt
{
    @try {
        CGFloat f = [_tiltValue floatValue];
        if (0.f <= f && f <= 360.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setTilt:(CGFloat)tilt
{
    _tiltValue = [NSString stringWithFormat:@"%f", tilt];
}

- (CGFloat)roll
{
    @try {
        CGFloat f = [_rollValue floatValue];
        if (0.f <= f && f <= 360.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setRoll:(CGFloat)roll
{
    _rollValue = [NSString stringWithFormat:@"%f", roll];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Orientation";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_headingValue defaultValue:@"0" tagName:@"heading" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_tiltValue defaultValue:@"0" tagName:@"tilt" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_rollValue defaultValue:@"0" tagName:@"roll" indentationLevel:indentationLevel];
    
}

@end
