//
//  KMLRegion.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLRegion.h"
#import "KMLElementSubclass.h"
#import "KMLLatLonAltBox.h"
#import "KMLLod.h"

@implementation KMLRegion

@synthesize latLonAltBox = _latLonAltBox;
@synthesize lod = _lod;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _latLonAltBox = (KMLLatLonAltBox *)[self childElementOfClass:[KMLLatLonAltBox class] xmlElement:element required:YES];
        _lod = (KMLLod *)[self childElementOfClass:[KMLLod class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (void)setLatLonAltBox:(KMLLatLonAltBox *)latLonAltBox
{
    if (_latLonAltBox != latLonAltBox) {
        if (_latLonAltBox) {
            _latLonAltBox.parent = nil;
        }

        _latLonAltBox = latLonAltBox;
        if (_latLonAltBox) {
            _latLonAltBox.parent = self;
        }
    }
}

- (void)setLod:(KMLLod *)lod
{
    if (_lod != lod) {
        if (_lod) {
            _lod.parent = nil;
        }

        _lod = lod;
        if (_lod) {
            _lod.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Region";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    if (self.latLonAltBox) {
        [self.latLonAltBox kml:kml indentationLevel:indentationLevel];
    }
    if (self.lod) {
        [self.lod kml:kml indentationLevel:indentationLevel];
    }
}

@end
