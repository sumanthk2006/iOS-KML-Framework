//
//  KMLAbstractObject.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractObject.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractFeature.h"
#import "KMLAbstractGeometry.h"
#import "KMLAbstractStyleSelector.h"
#import "KMLAbstractSubStyle.h"
#import "KMLAbstractTimePrimitive.h"
#import "KMLAbstractView.h"
#import "KMLAlias.h"
#import "KMLIcon.h"
#import "KMLItemIcon.h"
#import "KMLLatLonAltBox.h"
#import "KMLLatLonBox.h"
#import "KMLLink.h"
#import "KMLLocation.h"
#import "KMLLod.h"
#import "KMLOrientation.h"
#import "KMLPair.h"
#import "KMLRegion.h"
#import "KMLResourceMap.h"
#import "KMLScale.h"
#import "KMLSchemaData.h"

@implementation KMLAbstractObject

@synthesize objectID = _objectID;
@synthesize targetID = _targetID;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _objectID = [KMLXML valueOfAttributeNamed:@"id" forElement:element];
        _targetID = [KMLXML valueOfAttributeNamed:@"targetID" forElement:element];
    }
    return self;
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractObject";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:[KMLAbstractFeature implementClasses]];
    [array addObjectsFromArray:[KMLAbstractGeometry implementClasses]];
    [array addObjectsFromArray:[KMLAbstractStyleSelector implementClasses]];
    [array addObjectsFromArray:[KMLAbstractSubStyle implementClasses]];
    [array addObjectsFromArray:[KMLAbstractTimePrimitive implementClasses]];
    [array addObjectsFromArray:[KMLAbstractView implementClasses]];
    [array addObject:[KMLAlias class]];
    [array addObject:[KMLIcon class]];
    [array addObject:[KMLItemIcon class]];
    [array addObject:[KMLLatLonAltBox class]];
    [array addObject:[KMLLatLonBox class]];
    [array addObject:[KMLLink class]];
    [array addObject:[KMLLocation class]];
    [array addObject:[KMLLod class]];
    [array addObject:[KMLOrientation class]];
    [array addObject:[KMLPair class]];
    [array addObject:[KMLRegion class]];
    [array addObject:[KMLResourceMap class]];
    [array addObject:[KMLScale class]];
    [array addObject:[KMLSchemaData class]];
    return [NSArray arrayWithArray:array];
}


#pragma mark - KML

- (void)addOpenTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (self.objectID) {
        [attribute appendFormat:@" id=\"%@\"", self.objectID];
    }
    if (self.targetID) {
        [attribute appendFormat:@" targetID=\"%@\"", self.targetID];
    }

    [kml appendString:[NSString stringWithFormat:@"%@%<%@%@>\r\n"
                       , [self indentForIndentationLevel:indentationLevel]
                       , [[self class] tagName]
                       , attribute
                       ]
     ];
}

@end
