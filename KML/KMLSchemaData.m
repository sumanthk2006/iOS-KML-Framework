//
//  KMLSchemaData.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLSchemaData.h"
#import "KMLElementSubclass.h"
#import "KMLSimpleData.h"

@implementation KMLSchemaData {
    NSMutableArray *_simpleDataList;
}

@synthesize schemaUrl = _schemaUrl;
@synthesize simpleDataList;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _simpleDataList = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _schemaUrl = [KMLXML valueOfAttributeNamed:@"schemaUrl" forElement:element];

        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLSimpleData class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _simpleDataList = array;
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)simpleDataList
{
    return [NSArray arrayWithArray:_simpleDataList];
}

- (void)addSimpleData:(KMLSimpleData *)simpleData
{
    if (simpleData) {
        NSUInteger index = [_simpleDataList indexOfObject:simpleData];
        if (index == NSNotFound) {
            simpleData.parent = self;
            [_simpleDataList addObject:simpleData];
        }
    }
}

- (void)addSimpleDataList:(NSArray *)array
{
    for (KMLSimpleData *simpleData in array) {
        [self addSimpleData:simpleData];
    }
}

- (void)removeSimpleData:(KMLSimpleData *)simpleData
{
    NSUInteger index = [_simpleDataList indexOfObject:simpleData];
    if (index != NSNotFound) {
        simpleData.parent = nil;
        [_simpleDataList removeObject:simpleData];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"SchemaData";
}


#pragma mark - KML

- (void)addOpenTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (self.schemaUrl) {
        [attribute appendFormat:@" schemaUrl=\"%@\"", self.schemaUrl];
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
    
    [self kml:kml addPropertyForValue:_schemaUrl tagName:@"schemaUrl" indentationLevel:indentationLevel];
    
    for (KMLSimpleData *simpleData in self.simpleDataList) {
        [simpleData kml:kml indentationLevel:indentationLevel];
    }
}

@end
