//
//  KMLSchema.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLSchema.h"
#import "KMLElementSubclass.h"
#import "KMLSimpleField.h"

@implementation KMLSchema {
    NSMutableArray *_simpleFields;
}

@synthesize objectID = _objectID;
@synthesize name = _name;
@synthesize simpleFields;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _simpleFields = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _objectID = [KMLXML valueOfAttributeNamed:@"id" forElement:element];
        _name = [KMLXML valueOfAttributeNamed:@"name" forElement:element];
        
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLSimpleField class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _simpleFields = array;
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)simpleFields
{
    return [NSArray arrayWithArray:_simpleFields];
}

- (void)addSimpleField:(KMLSimpleField *)simpleField
{
    if (simpleField) {
        NSUInteger index = [_simpleFields indexOfObject:simpleField];
        if (index == NSNotFound) {
            simpleField.parent = self;
            [_simpleFields addObject:simpleField];
        }
    }
}

- (void)addSimpleFields:(NSArray *)array
{
    for (KMLSimpleField *simpleFieled in array) {
        [self addSimpleField:simpleFieled];
    }
}

- (void)removeSimpleField:(KMLSimpleField *)simpleField
{
    NSUInteger index = [_simpleFields indexOfObject:simpleField];
    if (index != NSNotFound) {
        simpleField.parent = nil;
        [_simpleFields removeObject:simpleField];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Schema";
}


#pragma mark - KML

- (void)addOpenTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (self.objectID) {
        [attribute appendFormat:@" id=\"%@\"", self.objectID];
    }
    if (self.name) {
        [attribute appendFormat:@" name=\"%@\"", self.name];
    }
    
    [kml appendString:[NSString stringWithFormat:@"%@%<%@%@>\r\n"
                       , [self indentForIndentationLevel:indentationLevel]
                       , attribute
                       , [[self class] tagName]
                       ]
     ];
}

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];

    for (KMLSimpleField *simpleField in self.simpleFields) {
        [simpleField kml:kml indentationLevel:indentationLevel];
    }
}

@end
