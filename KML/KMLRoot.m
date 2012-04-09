//
//  KMLRoot.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLRoot.h"
#import "KMLElementSubclass.h"
#import "KMLNetworkLinkControl.h"
#import "KMLAbstractFeature.h"
#import "KMLAbstractContainer.h"
#import "KMLPlacemark.h"
#import "KMLStyle.h"

@interface KMLRoot ()
- (NSArray *)searchPlacemarksForContainer:(KMLAbstractContainer *)container;
@end


@implementation KMLRoot

@synthesize schema = _schema;
@synthesize hint = _hint;
@synthesize networkLinkControl = _networkLinkControl;
@synthesize feature = _feature;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _hint = [KMLXML valueOfAttributeNamed:@"hint" forElement:element];
        _networkLinkControl = (KMLNetworkLinkControl *)[self childElementOfClass:[KMLNetworkLinkControl class] xmlElement:element];
        _feature = (KMLAbstractFeature *)[self childElementOfClass:[KMLAbstractFeature class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (NSString *)schema
{
    return @"http://www.opengis.net/kml/2.2";
}

- (void)setNetworkLinkControl:(KMLNetworkLinkControl *)networkLinkControl
{
    if (_networkLinkControl != networkLinkControl) {
        if (_networkLinkControl) {
            _networkLinkControl.parent = nil;
        }

        _networkLinkControl = networkLinkControl;
        if (_networkLinkControl) {
            _networkLinkControl.parent = self;
        }
    }
}

- (void)setFeature:(KMLAbstractFeature *)feature
{
    if (_feature != feature) {
        if (_feature) {
            _feature.parent = nil;
        }

        _feature = feature;
        if (_feature) {
            _feature.parent = self;
        }
    }
}

- (NSArray *)placemarks
{
    NSMutableArray *array = [NSMutableArray array];
    if ([self.feature isKindOfClass:[KMLPlacemark class]]) {
        [array addObject:self.feature];
    }
    else if ([self.feature isKindOfClass:[KMLAbstractContainer class]]) {
        [array addObjectsFromArray:[self searchPlacemarksForContainer:(KMLAbstractContainer *)self.feature]];
    }
    
    return [NSArray arrayWithArray:array];
}


#pragma mark - Private methods

- (NSArray *)searchPlacemarksForContainer:(KMLAbstractContainer *)container
{
    NSMutableArray *array = [NSMutableArray array];
    for (KMLAbstractFeature *feature in container.features) {
        if ([feature isKindOfClass:[KMLAbstractContainer class]]) {
            [array addObjectsFromArray:[self searchPlacemarksForContainer:(KMLAbstractContainer *)feature]];
        }
        else if ([feature isKindOfClass:[KMLPlacemark class]]) {
            KMLPlacemark *placemark = (KMLPlacemark *)feature;
            [array addObject:placemark];
        }
    }
    
    return [NSArray arrayWithArray:array];
}


#pragma mark - Tag

+ (NSString *)tagName
{
    return @"kml";
}


#pragma mark - KML

- (void)addOpenTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *attribute = [NSMutableString stringWithString:@""];
    if (self.schema) {
        [attribute appendFormat:@" xmlns=\"%@\"", self.schema];
    }
    if (self.hint) {
        [attribute appendFormat:@" hint=\"%@\"", self.hint];
    }
    
    [kml appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"];
    [kml appendString:[NSString stringWithFormat:@"%@%<%@%@>\r\n"
                       , [self indentForIndentationLevel:indentationLevel]
                       , [[self class] tagName]
                       , attribute
                       ]
     ];
}

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];

    if (self.networkLinkControl) {
        [self.networkLinkControl kml:kml indentationLevel:indentationLevel];
    }
    if (self.feature) {
        [self.feature kml:kml indentationLevel:indentationLevel];
    }
}

@end
