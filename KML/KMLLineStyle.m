//
//  KMLLineStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLineStyle.h"
#import "KMLElementSubclass.h"

@implementation KMLLineStyle {
    NSString *_widthValue;
}

@synthesize width = _width;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _widthValue = [self textForSingleChildElementNamed:@"width" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)width
{
    if(_widthValue) {
        @try {
            return [_widthValue floatValue];
        }
        @catch (NSException *exception) {
        }
    }
    
    return 1.f;
}

- (void)setWidth:(CGFloat)width
{
    _widthValue = [NSString stringWithFormat:@"%f", width];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"LineStyle";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_widthValue defaultValue:@"1" tagName:@"width" indentationLevel:indentationLevel];
}

@end
