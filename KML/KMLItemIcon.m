//
//  KMLItemIcon.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLItemIcon.h"
#import "KMLElementSubclass.h"

@implementation KMLItemIcon {
    NSString *_stateValue;
}

@synthesize state = _state;
@synthesize href = _href;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _stateValue = [self textForSingleChildElementNamed:@"state" xmlElement:element];
        _href = [self textForSingleChildElementNamed:@"href" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (KMLItemIconMode)state
{
    return [KMLType itemIconMode:_stateValue];
}

- (void)setState:(KMLItemIconMode)state
{
    _stateValue = [KMLType valueForItemIconMode:state];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"ItemIcon";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_stateValue defaultValue:@"open" tagName:@"state" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_href tagName:@"href" indentationLevel:indentationLevel];
}

@end
