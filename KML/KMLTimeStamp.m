//
//  KMLTimeStamp.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLTimeStamp.h"
#import "KMLElementSubclass.h"

@implementation KMLTimeStamp {
    NSString *_whenValue;
}

@synthesize when = _when;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _whenValue = [self textForSingleChildElementNamed:@"when" xmlElement:element];
    }
    return self;
}


#pragma mark - Public mehtods

- (NSDate *)when
{
    return [KMLType dateTime:_whenValue];
}

- (void)setWhen:(NSDate *)when
{
    _whenValue = [KMLType valueForDateTime:when];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"TimeStamp";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_whenValue tagName:@"when" indentationLevel:indentationLevel];
}

@end
