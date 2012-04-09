//
//  KMLBalloonStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLBalloonStyle.h"
#import "KMLElementSubclass.h"

@implementation KMLBalloonStyle {
    NSString *_displayModeValue;
}

@synthesize bgColor = _bgColor;
@synthesize textColor = _textColor;
@synthesize text = _text;
@synthesize displayMode = _displayMode;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _bgColor = [self textForSingleChildElementNamed:@"bgColor" xmlElement:element];
        _textColor = [self textForSingleChildElementNamed:@"textColor" xmlElement:element];
        _text = [self textForSingleChildElementNamed:@"text" xmlElement:element];
        _displayModeValue = [self textForSingleChildElementNamed:@"displayMode" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (KMLDisplayMode)displayMode
{
    return [KMLType displayMode:_displayModeValue];
}

- (void)setDisplayMode:(KMLDisplayMode)displayMode
{
    _displayModeValue = [KMLType valueForDisplayMode:displayMode];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"BalloonStyle";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_bgColor defaultValue:@"ffffffff" tagName:@"bgColor" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_textColor defaultValue:@"ff000000" tagName:@"textColor" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_text tagName:@"text" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_displayModeValue defaultValue:@"default" tagName:@"displayMode" indentationLevel:indentationLevel];
}

@end
