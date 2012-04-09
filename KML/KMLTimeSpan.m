//
//  KMLTimeSpan.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLTimeSpan.h"
#import "KMLElementSubclass.h"

@implementation KMLTimeSpan {
    NSString *_beginValue;
    NSString *_endValue;
}

@synthesize begin = _begin;
@synthesize end = _end;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _beginValue = [self textForSingleChildElementNamed:@"begin" xmlElement:element];
        _endValue = [self textForSingleChildElementNamed:@"end" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (NSDate *)begin
{
    return [KMLType dateTime:_beginValue];
}

- (void)setBegin:(NSDate *)begin
{
    _beginValue = [KMLType valueForDateTime:begin];
}

- (NSDate *)end
{
    return [KMLType dateTime:_endValue];
}

- (void)setEnd:(NSDate *)end
{
    _endValue = [KMLType valueForDateTime:end];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"TimeSpan";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_beginValue tagName:@"begin" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_endValue tagName:@"end" indentationLevel:indentationLevel];
}

@end
