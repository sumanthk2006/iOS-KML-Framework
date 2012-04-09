//
//  KMLChange.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLChange.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractObject.h"

@implementation KMLChange

@synthesize object = _object;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _object = (KMLAbstractObject *)[self childElementOfClass:[KMLAbstractObject class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (void)setObject:(KMLAbstractObject *)object
{
    if (_object != object) {
        if (_object) {
            _object.parent = nil;
        }
        _object = object;
        if (_object) {
            _object.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Change";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    if (self.object) {
        [self.object kml:kml indentationLevel:indentationLevel];
    }
}

@end
