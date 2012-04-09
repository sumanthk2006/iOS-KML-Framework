//
//  KMLScreenOverlay.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLScreenOverlay.h"
#import "KMLElementSubclass.h"
#import "KMLVec2.h"

@implementation KMLScreenOverlay {
    NSString *_rotationValue;
}

@synthesize overlayXY = _overlayXY;
@synthesize screenXY = _screenXY;
@synthesize rotationXY = _rotationXY;
@synthesize size = _size;
@synthesize rotation = _rotation;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _overlayXY = (KMLVec2 *)[self childElementNamed:@"overlayXY" class:[KMLVec2 class] xmlElement:element];
        _screenXY = (KMLVec2 *)[self childElementNamed:@"screenXY" class:[KMLVec2 class] xmlElement:element];
        _rotationXY = (KMLVec2 *)[self childElementNamed:@"rotationXY" class:[KMLVec2 class] xmlElement:element];
        _size = (KMLVec2 *)[self childElementNamed:@"size" class:[KMLVec2 class] xmlElement:element];

        _rotationValue = [self textForSingleChildElementNamed:@"rotation" xmlElement:element];
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


#pragma mark - tag

+ (NSString *)tagName
{
    return @"ScreenOverlay";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_rotationValue defaultValue:@"0" tagName:@"rotation" indentationLevel:indentationLevel];
    
    if (self.overlayXY) {
        [self.overlayXY kml:kml indentationLevel:indentationLevel];
    }
    if (self.screenXY) {
        [self.screenXY kml:kml indentationLevel:indentationLevel];
    }
    if (self.rotationXY) {
        [self.rotationXY kml:kml indentationLevel:indentationLevel];
    }
    if (self.size) {
        [self.size kml:kml indentationLevel:indentationLevel];
    }
}

@end
