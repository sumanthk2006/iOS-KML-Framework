//
//  KMLAbstractOverlay.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractOverlay.h"
#import "KMLElementSubclass.h"
#import "KMLIcon.h"
#import "KMLPhotoOverlay.h"
#import "KMLScreenOverlay.h"
#import "KMLGroundOverlay.h"

@implementation KMLAbstractOverlay {
    NSString *_drawOrderValue;
}

@synthesize color = _color;
@synthesize drawOrder = _drawOrder;
@synthesize icon = _icon;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _color = [self textForSingleChildElementNamed:@"color" xmlElement:element];
        _drawOrderValue = [self textForSingleChildElementNamed:@"drawOrder" xmlElement:element];
        
        _icon = (KMLIcon *)[self childElementOfClass:[KMLIcon class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (NSInteger)drawOrder
{
    @try {
        return [_drawOrderValue integerValue];
    }
    @catch (NSException *exception) {
        return 0;
    }
}

- (void)setDrawOrder:(NSInteger)drawOrder
{
    _drawOrderValue = [NSString stringWithFormat:@"%d", drawOrder];
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
    return @"AbstractOverlay";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLPhotoOverlay class]];
    [array addObject:[KMLScreenOverlay class]];
    [array addObject:[KMLGroundOverlay class]];
    return [NSArray arrayWithArray:array];
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_color defaultValue:@"ffffffff" tagName:@"color" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_drawOrderValue defaultValue:@"0" tagName:@"drawOrder" indentationLevel:indentationLevel];
    
    if (self.icon) {
        [self.icon kml:kml indentationLevel:indentationLevel];
    }
}

@end
