//
//  KMLLabelStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLabelStyle.h"
#import "KMLElementSubclass.h"

@implementation KMLLabelStyle {
    NSString *_scaleValue;
}

@synthesize scale = _scale;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _scaleValue = [self textForSingleChildElementNamed:@"scale" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)scale
{
    @try {
        return [_scaleValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 1.f;
}

- (void)setScale:(CGFloat)scale
{
    _scaleValue = [NSString stringWithFormat:@"%f", scale];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"LabelStyle";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_scaleValue defaultValue:@"1" tagName:@"scale" indentationLevel:indentationLevel];
}

@end
