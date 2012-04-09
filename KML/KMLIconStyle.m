//
//  KMLIconStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLIconStyle.h"
#import "KMLElementSubclass.h"
#import "KMLIcon.h"
#import "KMLVec2.h"

@implementation KMLIconStyle {
    NSString *_scaleValue;
    NSString *_headingValue;
}

@synthesize scale = _scale;
@synthesize heading = _heading;
@synthesize icon = _icon;
@synthesize hotSpot = _hotSpot;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _scaleValue = [self textForSingleChildElementNamed:@"scale" xmlElement:element];
        _headingValue = [self textForSingleChildElementNamed:@"heading" xmlElement:element];
        
        _icon = (KMLIcon *)[self childElementOfClass:[KMLIcon class] xmlElement:element];
        _hotSpot = (KMLVec2 *)[self childElementNamed:@"hotSpot" class:[KMLVec2 class] xmlElement:element];
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

- (CGFloat)heading
{
    @try {
        return [_headingValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setHeading:(CGFloat)heading
{
    _headingValue = [NSString stringWithFormat:@"%f", heading];
}

- (void)setIcon:(KMLIcon *)icon
{
    if (_icon != icon) {
        if (_icon) {
            _icon.parent = nil;
        }

        _icon = icon;
        if (_icon) {
            _icon.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"IconStyle";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_scaleValue defaultValue:@"1" tagName:@"scale" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_headingValue defaultValue:@"0" tagName:@"heading" indentationLevel:indentationLevel];
    
    if (self.icon) {
        [self.icon kml:kml indentationLevel:indentationLevel];
    }
    if (self.hotSpot) {
        [self.hotSpot kml:kml indentationLevel:indentationLevel];
    }
}



@end
