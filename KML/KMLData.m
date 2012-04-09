//
//  KMLData.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLData.h"
#import "KMLElementSubclass.h"

@implementation KMLData

@synthesize name = _name;
@synthesize displayName = _displayName;
@synthesize value = _value;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _name = [KMLXML valueOfAttributeNamed:@"name" forElement:element];
        _displayName = [self textForSingleChildElementNamed:@"displayName" xmlElement:element];
        _value = [self textForSingleChildElementNamed:@"value" xmlElement:element];
    }
    return self;
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Data";
}


#pragma mark - KML

- (void)addOpenTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (_name) {
        [attribute appendFormat:@" name=\"%@\"", _name];
    }
    
    [kml appendString:[NSString stringWithFormat:@"%@%<%@%@>\r\n"
                       , [self indentForIndentationLevel:indentationLevel]
                       , [[self class] tagName]
                       , attribute
                       ]
     ];
}

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_displayName tagName:@"displayName" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_value tagName:@"value" indentationLevel:indentationLevel];
}

@end
