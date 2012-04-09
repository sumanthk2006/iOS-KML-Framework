//
//  KMLPolyStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLPolyStyle.h"
#import "KMLElementSubclass.h"

@implementation KMLPolyStyle {
    NSString *_fillValue;
    NSString *_outlineValue;
}

@synthesize fill = _fill;
@synthesize outline = _outline;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _fillValue = [self textForSingleChildElementNamed:@"fill" xmlElement:element];
        _outlineValue = [self textForSingleChildElementNamed:@"outline" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (BOOL)fill
{
    return [KMLType boolean:_fillValue defaultValue:YES];
}

- (void)setFill:(BOOL)fill
{
    _fillValue = [KMLType valueForBoolean:fill];
}

- (BOOL)outline
{
    return [KMLType boolean:_outlineValue defaultValue:YES];
}

- (void)setOutline:(BOOL)outline
{
    _outlineValue = [KMLType valueForBoolean:outline];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"PolyStyle";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_fillValue defaultValue:@"1" tagName:@"fill" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_outlineValue defaultValue:@"1" tagName:@"outline" indentationLevel:indentationLevel];
}


@end
