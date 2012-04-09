//
//  KMLSimpleData.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLSimpleData.h"
#import "KMLElementSubclass.h"

@implementation KMLSimpleData

@synthesize name = _name;
@synthesize value = _value;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _name = [KMLXML valueOfAttributeNamed:@"name" forElement:element];
        _value = [KMLXML textForElement:element];
    }
    return self;
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"SimpleData";
}


#pragma mark - KML

- (void)kml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (attribute) {
        [attribute appendFormat:@"name=\"%@\"", _name];
    }
    
    [kml appendFormat:@"<%@%@>%@</%@>\r\n"
                    , [[self class] tagName]
                    , attribute
                    , (_value ? _value : @"")
                    , [[self class] tagName]
     ];
}

@end
