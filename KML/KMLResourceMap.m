//
//  KMLResourceMap.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLResourceMap.h"
#import "KMLElementSubclass.h"
#import "KMLAlias.h"

@implementation KMLResourceMap {
    NSMutableArray *_aliasList;
}

@synthesize aliasList;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _aliasList = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLAlias class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _aliasList = array;
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)aliasList
{
    return [NSArray arrayWithArray:_aliasList];
}

- (void)addAlias:(KMLAlias *)alias
{
    if (alias) {
        NSUInteger index = [_aliasList indexOfObject:alias];
        if (index == NSNotFound) {
            alias.parent = self;
            [_aliasList addObject:alias];
        }
    }
}

- (void)addAliasList:(NSArray *)array
{
    for (KMLAlias *alias in array) {
        [self addAlias:alias];
    }
}

- (void)removeAlias:(KMLAlias *)alias
{
    NSUInteger index = [_aliasList indexOfObject:alias];
    if (index != NSNotFound) {
        alias.parent = nil;
        [_aliasList removeObject:alias];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"ResourceMap";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLResourceMap *alias in self.aliasList) {
        [alias kml:kml indentationLevel:indentationLevel];
    }
}

@end
