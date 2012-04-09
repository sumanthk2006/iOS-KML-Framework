//
//  KMLScale.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLScale.h"
#import "KMLElementSubclass.h"

@implementation KMLScale {
    NSString *_xValue;
    NSString *_yValue;
    NSString *_zValue;
}

@synthesize x = _x;
@synthesize y = _y;
@synthesize z = _z;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _xValue = [self textForSingleChildElementNamed:@"x" xmlElement:element];
        _yValue = [self textForSingleChildElementNamed:@"y" xmlElement:element];
        _zValue = [self textForSingleChildElementNamed:@"z" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)x
{
    @try {
        return [_xValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 1.f;
}

- (void)setX:(CGFloat)x
{
    _xValue = [NSString stringWithFormat:@"%f", x];
}

- (CGFloat)y
{
    @try {
        return [_yValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 1.f;
}

- (void)setY:(CGFloat)y
{
    _yValue = [NSString stringWithFormat:@"%f", y];
}

- (CGFloat)z
{
    @try {
        return [_zValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 1.f;
}

- (void)setZ:(CGFloat)z
{
    _zValue = [NSString stringWithFormat:@"%f", z];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Scale";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_xValue defaultValue:@"1" tagName:@"x" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_yValue defaultValue:@"1" tagName:@"y" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_zValue defaultValue:@"1" tagName:@"z" indentationLevel:indentationLevel];
    
}

@end
