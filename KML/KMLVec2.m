//
//  KMLVec2.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLVec2.h"
#import "KMLElementSubclass.h"

@implementation KMLVec2 {
    NSString *_tagName;
    NSString *_xValue;
    NSString *_yValue;
    NSString *_xunitsValue;
    NSString *_yunitsValue;
}

@synthesize x = _x;
@synthesize y = _y;
@synthesize xunits = _xunits;
@synthesize yunits = _yunits;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _tagName = [KMLXML elementName:element];
        _xValue = [KMLXML valueOfAttributeNamed:@"x" forElement:element];
        _yValue = [KMLXML valueOfAttributeNamed:@"y" forElement:element];
        _xunitsValue = [KMLXML valueOfAttributeNamed:@"xunits" forElement:element];
        _yunitsValue = [KMLXML valueOfAttributeNamed:@"yunits" forElement:element];
    }
    return self;
}


#pragma mark - KML

- (void)kml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (_xValue) {
        [attribute appendFormat:@" x=\"%@\"", _xValue];
    }
    if (_yValue) {
        [attribute appendFormat:@" y=\"%@\"", _yValue];
    }
    if (_xunitsValue) {
        [attribute appendFormat:@" xunits=\"%@\"", _xunitsValue];
    }
    if (_yunitsValue) {
        [attribute appendFormat:@" xunits=\"%@\"", _yunitsValue];
    }
    
    [kml appendFormat:@"%@<%@%@ />\r\n", [self indentForIndentationLevel:indentationLevel],  _tagName, attribute];
}

@end
