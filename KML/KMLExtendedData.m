//
//  NAKMMLExtendedData.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLExtendedData.h"
#import "KMLElementSubclass.h"
#import "KMLData.h"
#import "KMLSchemaData.h"

@implementation KMLExtendedData {
    NSMutableArray *_dataList;
    NSMutableArray *_schemaDataList;
}

@synthesize dataList;
@synthesize schemaDataList;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _dataList = [NSMutableArray array];
        _schemaDataList = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLData class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array addObject:element];
                        }];
        _dataList = array;

        NSMutableArray *array1 = [NSMutableArray array];
        [self childElementsOfClass:[KMLSchemaData class]
                       xmlElement:element
                        eachBlock:^(KMLElement *element) {
                            [array1 addObject:element];
                        }];
        _schemaDataList = array1;
    }
    return self;
}


#pragma mark - Public methods

- (NSArray *)dataList
{
    return [NSArray arrayWithArray:_dataList];
}

- (void)addData:(KMLData *)data
{
    if (data) {
        NSUInteger index = [_dataList indexOfObject:data];
        if (index == NSNotFound) {
            data.parent = self;
            [_dataList addObject:data];
        }
    }
}

- (void)addDataList:(NSArray *)array
{
    for (KMLData *data in array) {
        [self addData:data];
    }
}

- (void)removeData:(KMLData *)data
{
    NSUInteger index = [_dataList indexOfObject:data];
    if (index != NSNotFound) {
        data.parent = nil;
        [_dataList removeObject:data];
    }
}

- (NSArray *)schemaDataList
{
    return [NSArray arrayWithArray:_schemaDataList];
}

- (void)addSchemaData:(KMLSchemaData *)schemaData
{
    if (schemaData) {
        NSUInteger index = [_schemaDataList indexOfObject:schemaData];
        if (index == NSNotFound) {
            schemaData.parent = self;
            [_schemaDataList addObject:schemaData];
        }
    }
}

- (void)addSchemaDataList:(NSArray *)array
{
    for (KMLSchemaData *schemaData in array) {
        [self addSchemaData:schemaData];
    }
}

- (void)removeSchemaData:(KMLSchemaData *)schemaData
{
    NSUInteger index = [_schemaDataList indexOfObject:schemaData];
    if (index != NSNotFound) {
        schemaData.parent = nil;
        [_schemaDataList removeObject:schemaData];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"ExtendedData";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    for (KMLData *data in self.dataList) {
        [data kml:kml indentationLevel:indentationLevel];
    }
    for (KMLSchemaData *schemaData in self.schemaDataList) {
        [schemaData kml:kml indentationLevel:indentationLevel];
    }
}

@end
