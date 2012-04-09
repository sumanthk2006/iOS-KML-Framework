//
//  KMLLod.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLod.h"
#import "KMLElementSubclass.h"

@implementation KMLLod {
    NSString *_minLodPixelsValue;
    NSString *_maxLodPixelsValue;
    NSString *_minFadeExtentValue;
    NSString *_maxFadeExtentValue;
}

@synthesize minLodPixels = _minLodPixels;
@synthesize maxLodPixels = _maxLodPixels;
@synthesize minFadeExtent = _minFadeExtent;
@synthesize maxFadeExtent = _maxFadeExtent;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _minLodPixelsValue = [self textForSingleChildElementNamed:@"minLodPixels" xmlElement:element required:YES];
        _maxLodPixelsValue = [self textForSingleChildElementNamed:@"maxLodPixels" xmlElement:element];
        _minFadeExtentValue = [self textForSingleChildElementNamed:@"minFadeExtent" xmlElement:element];
        _maxFadeExtentValue = [self textForSingleChildElementNamed:@"maxFadeExtent" xmlElement:element];
    }
    return self;
}


#pragma mark - Public mehthods

- (CGFloat)minLodPixels
{
    @try {
        return [_minLodPixelsValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setMinLodPixels:(CGFloat)minLodPixels
{
    _minLodPixelsValue = [NSString stringWithFormat:@"%f", minLodPixels];
}


- (CGFloat)maxLodPixels
{
    @try {
        return [_maxLodPixelsValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return -1.f;
}

- (void)setMaxLodPixels:(CGFloat)maxLodPixels
{
    _maxLodPixelsValue = [NSString stringWithFormat:@"%f", maxLodPixels];
}

- (CGFloat)minFadeExtent
{
    @try {
        return [_minFadeExtentValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setMinFadeExtent:(CGFloat)minFadeExtent
{
    _minFadeExtentValue = [NSString stringWithFormat:@"%f", minFadeExtent];
}

- (CGFloat)maxFadeExtent
{
    @try {
        return [_maxFadeExtentValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setMaxFadeExtent:(CGFloat)maxFadeExtent
{
    _maxFadeExtentValue = [NSString stringWithFormat:@"%f", maxFadeExtent];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Lod";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_minLodPixelsValue defaultValue:@"0" tagName:@"minLodPixels" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_maxLodPixelsValue defaultValue:@"-1" tagName:@"maxLodPixels" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_minFadeExtentValue defaultValue:@"0" tagName:@"minFadeExtent" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_maxFadeExtentValue defaultValue:@"0" tagName:@"maxFadeExtent" indentationLevel:indentationLevel];
}

@end
