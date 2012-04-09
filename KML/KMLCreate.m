//
//  KMLCreate.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLCreate.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractContainer.h"

@implementation KMLCreate

@synthesize container = _container;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _container = (KMLAbstractContainer *)[self childElementOfClass:[KMLAbstractContainer class] xmlElement:element];

    }
    return self;
}


#pragma mark - Public methods

- (void)setContainer:(KMLAbstractContainer *)container
{
    if (_container != container) {
        if (_container) {
            _container.parent = nil;
        }
        _container = container;
        if (_container) {
            _container.parent = self;
        }
    }
}

#pragma mark - tag

+ (NSString *)tagName
{
    return @"Create";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    if (self.container) {
        [self.container kml:kml indentationLevel:indentationLevel];
    }
}

@end
