//
//  KMLAbstractColorStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractColorStyle.h"
#import "KMLElementSubclass.h"
#import "KMLLineStyle.h"
#import "KMLPolyStyle.h"
#import "KMLIconStyle.h"
#import "KMLLabelStyle.h"

@implementation KMLAbstractColorStyle {
    NSString *_colorModeValue;
}

@synthesize color = _color;
@synthesize colorMode = _colorMode;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _color = [self textForSingleChildElementNamed:@"color" xmlElement:element];
        _colorModeValue = [self textForSingleChildElementNamed:@"colorMode" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (KMLColorMode)colorMode
{
    return [KMLType colorMode:_colorModeValue];
}

- (void)setColorMode:(KMLColorMode)colorMode
{
    _colorModeValue = [KMLType valueForColorMode:colorMode];
}

- (UIColor *)UIColor
{
    if (self.color && self.color.length == 8) {
        // validate ffffffff fromat
        NSRange match = [self.color rangeOfString:@"^[0-9a-fA-F]{8}$" options:NSRegularExpressionSearch];
        if (match.location != NSNotFound) {
            uint hex = strtoul([self.color UTF8String], NULL, 16);		
            return [UIColor colorWithRed:(CGFloat)(hex & 0xff) / 255.0f  
                                   green:(CGFloat)((hex>>8) & 0xff) / 255.0f  
                                    blue:(CGFloat)((hex>>16) & 0xff) / 255.0f  
                                   alpha:(CGFloat)((hex>>24) & 0xff) / 255.0f ];
        }
    }
    
    return [UIColor whiteColor];
}

- (void)setUIColor:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    int componentsCount = CGColorGetNumberOfComponents(color.CGColor);
    
    NSInteger red = (int)(components[0] * 0xff);
    NSInteger green = (int)(components[(componentsCount == 4 ? 1 : 0)] * 0xff);
    NSInteger blue = (int)(components[(componentsCount == 4 ? 2 : 0)] * 0xff);
    NSInteger alpha = (int)(components[(componentsCount == 4 ? 3 : 1)] * 0xff);

    self.color = [NSString stringWithFormat:@"%02x%02x%02x%02x", alpha, blue, green, red];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractColorStyle";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLLineStyle class]];
    [array addObject:[KMLPolyStyle class]];
    [array addObject:[KMLIconStyle class]];
    [array addObject:[KMLLabelStyle class]];
    return [NSArray arrayWithArray:array];
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_color defaultValue:@"ffffffff" tagName:@"color" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_colorModeValue defaultValue:@"normal" tagName:@"colorMode" indentationLevel:indentationLevel];
}

@end
