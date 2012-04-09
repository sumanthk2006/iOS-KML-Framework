//
//  KMLPhotoOverlay.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLPhotoOverlay.h"
#import "KMLElementSubclass.h"
#import "KMLViewVolume.h"
#import "KMLImagePyramid.h"
#import "KMLPoint.h"

@implementation KMLPhotoOverlay {
    NSString *_rotationValue;
    NSString *_shapeValue;
}

@synthesize rotation = _rotation;
@synthesize viewVolume = _viewVolume;
@synthesize imagePyramid = _imagePyramid;
@synthesize point = _point;
@synthesize shape = _shape;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _rotationValue = [self textForSingleChildElementNamed:@"rotation" xmlElement:element];
        _shapeValue = [self textForSingleChildElementNamed:@"shape" xmlElement:element];
        
        _viewVolume = (KMLViewVolume *)[self childElementOfClass:[KMLViewVolume class] xmlElement:element];
        _imagePyramid = (KMLImagePyramid *)[self childElementOfClass:[KMLImagePyramid class] xmlElement:element];
        _point = (KMLPoint *)[self childElementOfClass:[KMLPoint class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)rotation
{
    return [KMLType angle180:_rotationValue];
}

- (void)setRotation:(CGFloat)rotation
{
    _rotationValue = [KMLType valueForAngle180:rotation];
}

- (KMLShape)shape
{
    return [KMLType shape:_shapeValue];
}

- (void)setShape:(KMLShape)shape
{
    _shapeValue = [KMLType valueForShape:shape];
}

- (void)setViewVolume:(KMLViewVolume *)viewVolume
{
    if (_viewVolume != viewVolume) {
        if (_viewVolume) {
            _viewVolume.parent = nil;
        }

        _viewVolume = viewVolume;
        if (_viewVolume) {
            _viewVolume.parent = self;
        }
    }
}

- (void)setImagePyramid:(KMLImagePyramid *)imagePyramid
{
    if (_imagePyramid != imagePyramid) {
        if (_imagePyramid) {
            _imagePyramid.parent = nil;
        }

        _imagePyramid = imagePyramid;
        if (_imagePyramid) {
            _imagePyramid.parent = self;
        }
    }
}

- (void)setPoint:(KMLPoint *)point
{
    if (_point != point) {
        if (_point) {
            _point.parent = nil;
        }

        _point = point;
        if (_point) {
            _point.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"PhotoOverlay";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_rotationValue defaultValue:@"0" tagName:@"rotation" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_shapeValue defaultValue:@"rectangle" tagName:@"shape" indentationLevel:indentationLevel];
    
    if (self.viewVolume) {
        [self.viewVolume kml:kml indentationLevel:indentationLevel];
    }
    if (self.imagePyramid) {
        [self.imagePyramid kml:kml indentationLevel:indentationLevel];
    }
    if (self.point) {
        [self.point kml:kml indentationLevel:indentationLevel];
    }
}

@end
