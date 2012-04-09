//
//  KMLImagePyramid.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLImagePyramid.h"
#import "KMLElementSubclass.h"

@implementation KMLImagePyramid {
    NSString *_tileSizeValue;
    NSString *_maxWidthValue;
    NSString *_maxHeightValue;
    NSString *_gridOriginValue;
}

@synthesize tileSize = _tileSize;
@synthesize maxWidth = _maxWidth;
@synthesize maxHeight = _maxHeight;
@synthesize gridOrigin = _gridOrigin;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _tileSizeValue = [self textForSingleChildElementNamed:@"tileSize" xmlElement:element];
        _maxWidthValue = [self textForSingleChildElementNamed:@"maxWidth" xmlElement:element];
        _maxHeightValue = [self textForSingleChildElementNamed:@"maxHeight" xmlElement:element];
        _gridOriginValue = [self textForSingleChildElementNamed:@"gridOrigin" xmlElement:element];
    }
    return self;
}

#pragma mark - Public methods

- (NSInteger)tileSize
{
    return [_tileSizeValue integerValue];
}

- (void)setTileSize:(NSInteger)tileSize
{
    _tileSizeValue = [NSString stringWithFormat:@"%d", tileSize];
}

- (NSInteger)maxWidth
{
    return [_maxWidthValue integerValue];
}

- (void)setMaxWidth:(NSInteger)maxWidth
{
    _maxWidthValue = [NSString stringWithFormat:@"%d", maxWidth];
}

- (NSInteger)maxHeight
{
    return [_maxWidthValue integerValue];
}

- (void)setMaxHeight:(NSInteger)maxHeight
{
    _maxHeightValue = [NSString stringWithFormat:@"%d", maxHeight];
}

- (KMLGridOrigin)gridOrigin
{
    return [KMLType gridOrigin:_gridOriginValue];
}

- (void)setGridOrigin:(KMLGridOrigin)gridOrigin
{
    _gridOriginValue = [KMLType valueForGridOrigin:gridOrigin];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"ImagePyramid";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_tileSizeValue defaultValue:@"256" tagName:@"tileSize" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_maxWidthValue tagName:@"maxWidth" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_maxHeightValue tagName:@"maxHeight" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_gridOriginValue defaultValue:@"lowerLeft" tagName:@"gridOrigin" indentationLevel:indentationLevel];
}

@end
