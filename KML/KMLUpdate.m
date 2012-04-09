//
//  KMLUpdate.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLUpdate.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractObject.h"
#import "KMLChange.h"
#import "KMLCreate.h"
#import "KMLDelete.h"

@implementation KMLUpdate {
    NSMutableArray *_objects;
}

@synthesize targetHref = _targetHref;
@synthesize objects;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _objects = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _targetHref = [self textForSingleChildElementNamed:@"targetHref" xmlElement:element required:YES];
        
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLChange class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        [self childElementsOfClass:[KMLCreate class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        [self childElementsOfClass:[KMLUpdate class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _objects = array;
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)objects
{
    return [NSArray arrayWithArray:_objects];
}

- (void)addObject:(KMLAbstractObject *)object
{
    if (object) {
        if ([object isKindOfClass:[KMLChange class]]
            || [object isKindOfClass:[KMLUpdate class]]
            || [object isKindOfClass:[KMLDelete class]]) {
            
            NSUInteger index = [_objects indexOfObject:object];
            if (index == NSNotFound) {
                object.parent = self;
                [_objects addObject:object];
            }
        }
    }
}

- (void)addObjects:(NSArray *)array
{
    for (KMLAbstractObject *obejct in array) {
        [self addObject:obejct];
    }
}

- (void)removeObject:(KMLAbstractObject *)object
{
    NSUInteger index = [_objects indexOfObject:object];
    if (index != NSNotFound) {
        object.parent = nil;
        [_objects removeObject:object];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Update";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_targetHref tagName:@"targetHref" indentationLevel:indentationLevel];
    
    for (KMLElement *element in self.objects) {
        [element kml:kml indentationLevel:indentationLevel];
    }
}

@end
