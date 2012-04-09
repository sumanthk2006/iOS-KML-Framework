//
//  KMLViewVolume.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLViewVolume.h"
#import "KMLElementSubclass.h"

@implementation KMLViewVolume {
    NSString *_leftFovValue;
    NSString *_rightFovValue;
    NSString *_bottomFovValue;
    NSString *_topFovValue;
    NSString *_nearValue;
}

@synthesize leftFov = _leftFov;
@synthesize rightFov = _rightFov;
@synthesize bottomFov = _bottomFov;
@synthesize topFov = _topFov;
@synthesize near = _near;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _leftFovValue = [self textForSingleChildElementNamed:@"leftFov" xmlElement:element];
        _rightFovValue = [self textForSingleChildElementNamed:@"rightFov" xmlElement:element];
        _bottomFovValue = [self textForSingleChildElementNamed:@"bottomFov" xmlElement:element];
        _topFovValue = [self textForSingleChildElementNamed:@"topFov" xmlElement:element];
        _nearValue = [self textForSingleChildElementNamed:@"near" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)leftFov
{
    return [KMLType angle180:_leftFovValue];
}

- (void)setLeftFov:(CGFloat)leftFov
{
    _leftFovValue = [KMLType valueForAngle180:leftFov];
}

- (CGFloat)rightFov
{
    return [KMLType angle180:_rightFovValue];
}

- (void)setRightFov:(CGFloat)rightFov
{
    _rightFovValue = [KMLType valueForAngle180:rightFov];
}

- (CGFloat)bottomFov
{
    return [KMLType angle90:_bottomFovValue];
}

- (void)setBottomFov:(CGFloat)bottomFov
{
    _bottomFovValue = [KMLType valueForAngle90:bottomFov];
}

- (CGFloat)topFov
{
    return [KMLType angle90:_topFovValue];
}

- (void)setTopFov:(CGFloat)topFov
{
    _topFovValue = [KMLType valueForAngle90:topFov];
}

- (CGFloat)near
{
    @try {
        return [_nearValue doubleValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0;
}

- (void)setNear:(CGFloat)near
{
    _nearValue = [NSString stringWithFormat:@"%d", near];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"ViewVolume";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_leftFovValue defaultValue:@"0" tagName:@"leftFov" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_rightFovValue defaultValue:@"0" tagName:@"rightFov" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_bottomFovValue defaultValue:@"0" tagName:@"bottomFov" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_topFovValue defaultValue:@"0" tagName:@"topFov" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_nearValue defaultValue:@"0" tagName:@"near" indentationLevel:indentationLevel];
}

@end
