//
//  KMLSimpleField.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLSimpleField.h"
#import "KMLElementSubclass.h"

@implementation KMLSimpleField

@synthesize type = _type;
@synthesize name = _name;
@synthesize displayName = _displayName;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _type = [KMLXML valueOfAttributeNamed:@"type" forElement:element];
        _name = [KMLXML valueOfAttributeNamed:@"name" forElement:element];
        _displayName = [self textForSingleChildElementNamed:@"displayName" xmlElement:element];
    }
    return self;
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"SimpleField";
}


#pragma mark - KML

- (void)addOpenTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (self.type) {
        [attribute appendFormat:@" type=\"%@\"", self.type];
    }
    if (self.name) {
        [attribute appendFormat:@" name=\"%@\"", self.name];
    }
    
    [kml appendString:[NSString stringWithFormat:@"%@%<%@%@>\r\n"
                       , [self indentForIndentationLevel:indentationLevel]
                       , attribute
                       , [[self class] tagName]
                       ]
     ];
}

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_displayName tagName:@"displayName" indentationLevel:indentationLevel];
}

@end
