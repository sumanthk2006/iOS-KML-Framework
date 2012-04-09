//
//  KMLStyleMap.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLStyleMap.h"
#import "KMLConst.h"
#import "KMLElementSubclass.h"
#import "KMLPair.h"

@implementation KMLStyleMap {
    NSMutableArray *_pairs;
}

@synthesize pairs;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _pairs = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLPair class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element]; 
                        }];
        _pairs = array;
        
        if (_pairs.count == 0) {
            NSString *description = [NSString stringWithFormat:@"%@ element require %@ element.", [[self class] tagName], [KMLPair tagName]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
        }
                            
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)pairs
{
    return [NSArray arrayWithArray:_pairs];
}

- (void)addPair:(KMLPair *)pair
{
    if (pair) {
        NSUInteger index = [_pairs indexOfObject:pair];
        if (index == NSNotFound) {
            pair.parent = self;
            [_pairs addObject:pair];
        }
    }
}

- (void)addPairs:(NSArray *)array
{
    for (KMLPair *pair in array) {
        [self addPair:pair];
    }
}

- (void)removePair:(KMLPair *)pair
{
    NSUInteger index = [_pairs indexOfObject:pair];
    if (index != NSNotFound) {
        pair.parent = nil;
        [_pairs removeObject:pair];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"StyleMap";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLPair *pair in self.pairs) {
        [pair kml:kml indentationLevel:indentationLevel];
    }
}

@end
