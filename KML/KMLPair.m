//
//  KMLPair.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLPair.h"
#import "KMLElementSubclass.h"
#import "KMLStyle.h"

@implementation KMLPair

@synthesize key = _key;
@synthesize styleUrl = _styleUrl;
@synthesize style = _style;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _key = [self textForSingleChildElementNamed:@"key" xmlElement:element required:YES];
        _styleUrl = [self textForSingleChildElementNamed:@"styleUrl" xmlElement:element required:YES];
        
        _style = (KMLStyle *)[self childElementOfClass:[KMLStyle class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (void)setStyle:(KMLStyle *)style
{
    if (_style == style) {
        if (_style) {
            _style.parent = nil;
        }

        _style = style;
        if (_style) {
            _style.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Pair";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_key tagName:@"key" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_styleUrl tagName:@"styleUrl" indentationLevel:indentationLevel];
    
    if (self.style) {
        [self.style kml:kml indentationLevel:indentationLevel];
    }
}

@end
