//
//  KMLAbstractView.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractView.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractTimePrimitive.h"
#import "KMLCamera.h"
#import "KMLLookAt.h"

@implementation KMLAbstractView

@synthesize timePrimitive = _timePrimitive;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _timePrimitive = (KMLAbstractTimePrimitive *)[self childElementOfClass:[KMLAbstractTimePrimitive class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (void)setTimePrimitive:(KMLAbstractTimePrimitive *)timePrimitive
{
    if (_timePrimitive) {
        _timePrimitive.parent = nil;
    }
    _timePrimitive = timePrimitive;
    _timePrimitive.parent = self;
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractView";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLCamera class]];
    [array addObject:[KMLLookAt class]];
    return [NSArray arrayWithArray:array];
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];

    if (self.timePrimitive) {
        [self.timePrimitive kml:kml indentationLevel:indentationLevel];
    }
}

@end
