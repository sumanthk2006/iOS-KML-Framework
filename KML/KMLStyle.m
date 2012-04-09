//
//  KMLStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLStyle.h"
#import "KMLElementSubclass.h"
#import "KMLIconStyle.h"
#import "KMLLabelStyle.h"
#import "KMLLineStyle.h"
#import "KMLPolyStyle.h"
#import "KMLBalloonStyle.h"
#import "KMLListStyle.h"

@implementation KMLStyle

@synthesize iconStyle = _iconStyle;
@synthesize labelStyle = _labelStyle;
@synthesize lineStyle = _lineStyle;
@synthesize polyStyle = _polyStyle;
@synthesize balloonStyle = _balloonStyle;
@synthesize listStyle = _listStyle;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _iconStyle = (KMLIconStyle *)[self childElementOfClass:[KMLIconStyle class] xmlElement:element];
        _labelStyle = (KMLLabelStyle *)[self childElementOfClass:[KMLLabelStyle class] xmlElement:element];
        _lineStyle = (KMLLineStyle *)[self childElementOfClass:[KMLLineStyle class] xmlElement:element];
        _polyStyle = (KMLPolyStyle *)[self childElementOfClass:[KMLPolyStyle class] xmlElement:element];
        _balloonStyle = (KMLBalloonStyle *)[self childElementOfClass:[KMLBalloonStyle class] xmlElement:element];
        _listStyle = (KMLListStyle *)[self childElementOfClass:[KMLListStyle class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (void)setIconStyle:(KMLIconStyle *)iconStyle
{
    if (_iconStyle != iconStyle) {
        if (_iconStyle) {
            _iconStyle.parent = nil;
        }

        _iconStyle = iconStyle;
        if (_iconStyle) {
            _iconStyle.parent = self;
        }
    }
}

- (void)setLabelStyle:(KMLLabelStyle *)labelStyle
{
    if (_labelStyle != labelStyle) {
        if (_labelStyle) {
            _labelStyle.parent = nil;
        }

        _labelStyle = labelStyle;
        if (_labelStyle) {
            _labelStyle.parent = self;
        }
    }
}

- (void)setLineStyle:(KMLLineStyle *)lineStyle
{
    if (_lineStyle != lineStyle) {
        if (_lineStyle) {
            _lineStyle.parent = nil;
        }

        _lineStyle = lineStyle;
        if (_lineStyle) {
            _lineStyle.parent = self;
        }
    }
}

- (void)setPolyStyle:(KMLPolyStyle *)polyStyle
{
    if (_polyStyle != polyStyle) {
        if (_polyStyle) {
            _polyStyle.parent = nil;
        }

        _polyStyle = polyStyle;
        if (_polyStyle) {
            _polyStyle.parent = self;
        }
    }
}

- (void)setBalloonStyle:(KMLBalloonStyle *)balloonStyle
{
    if (_balloonStyle != balloonStyle) {
        if (_balloonStyle) {
            _balloonStyle.parent = nil;
        }

        _balloonStyle = balloonStyle;
        if (_balloonStyle) {
            _balloonStyle.parent = self;
        }
    }
}

- (void)setListStyle:(KMLListStyle *)listStyle
{
    if (_listStyle != listStyle) {
        if (_listStyle) {
            _listStyle.parent = nil;
        }

        _listStyle = listStyle;
        if (_listStyle) {
            _listStyle.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Style";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    if (self.iconStyle) {
        [self.iconStyle kml:kml indentationLevel:indentationLevel];
    }
    if (self.labelStyle) {
        [self.labelStyle kml:kml indentationLevel:indentationLevel];
    }
    if (self.lineStyle) {
        [self.lineStyle kml:kml indentationLevel:indentationLevel];
    }
    if (self.polyStyle) {
        [self.polyStyle kml:kml indentationLevel:indentationLevel];
    }
    if (self.balloonStyle) {
        [self.balloonStyle kml:kml indentationLevel:indentationLevel];
    }
    if (self.listStyle) {
        [self.listStyle kml:kml indentationLevel:indentationLevel];
    }
    
}

@end
