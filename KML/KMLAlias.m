//
//  KMLAlias.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAlias.h"
#import "KMLElementSubclass.h"

@implementation KMLAlias

@synthesize targetHref = _targetHref;
@synthesize sourceHref = _sourceHref;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _targetHref = [self textForSingleChildElementNamed:@"targetHref" xmlElement:element];
        _sourceHref = [self textForSingleChildElementNamed:@"sourceHref" xmlElement:element];
    }
    return self;
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Alias";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];

    [self kml:kml addPropertyForValue:_targetHref tagName:@"targetHref" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_sourceHref tagName:@"sourceHref" indentationLevel:indentationLevel];
}

@end
