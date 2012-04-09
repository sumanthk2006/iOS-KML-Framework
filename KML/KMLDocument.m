//
//  KMLDocument.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLDocument.h"
#import "KMLElementSubclass.h"
#import "KMLSchema.h"

@implementation KMLDocument {
    NSMutableArray *_schemata;
}

@synthesize schemata;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _schemata = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLSchema class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _schemata = array;
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)schemata
{
    return [NSArray arrayWithArray:_schemata];
}

- (void)addSchema:(KMLSchema *)schema
{
    NSUInteger index = [_schemata indexOfObject:schema];
    if (index == NSNotFound) {
        if (schema) {
            schema.parent = self;
            [_schemata addObject:schema];
        }
    }
}

- (void)addSchemata:(NSArray *)array
{
    for (KMLSchema *schema in array) {
        [self addSchema:schema];
    }
}

- (void)removeSchema:(KMLSchema *)schema
{
    NSUInteger index = [_schemata indexOfObject:schema];
    if (index != NSNotFound) {
        schema.parent = nil;
        [_schemata removeObject:schema];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Document";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLSchema *schema in self.schemata) {
        [schema kml:kml indentationLevel:indentationLevel];
    }
}

@end
