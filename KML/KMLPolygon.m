//
//  KMLPolygon.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLPolygon.h"
#import "KMLConst.h"
#import "KMLElementSubclass.h"
#import "KMLLinearRing.h"

@interface KMLPolygon ()
- (KMLElement *)childElementNamed:(NSString *)name innerClass:(Class)class xmlElement:(KMLXMLElement *)element;
- (void)childElementsNamed:(NSString *)name innerClass:(Class)class xmlElement:(KMLXMLElement *)element eachBlock:(void (^)(KMLElement *element))eachBlock;
@end



@implementation KMLPolygon {
    NSString *_extrudeValue;
    NSString *_tessellateValue;
    NSString *_altitudeModeValue;
    NSMutableArray *_innerBoundaryIsList;
}

@synthesize extrude = _extrude;
@synthesize tessellate = _tessellate;
@synthesize altitudeMode = _altitudeMode;
@synthesize outerBoundaryIs = _outerBoundaryIs;
@synthesize innerBoundaryIsList;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _innerBoundaryIsList = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _extrudeValue = [self textForSingleChildElementNamed:@"extrude" xmlElement:element];
        _tessellateValue = [self textForSingleChildElementNamed:@"tessellate" xmlElement:element];
        _altitudeModeValue = [self textForSingleChildElementNamed:@"altitudeMode" xmlElement:element];
        
        _outerBoundaryIs = (KMLLinearRing *)[self childElementNamed:@"outerBoundaryIs" innerClass:[KMLLinearRing class] xmlElement:element];
        
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsNamed:@"innerBoundaryIs"
                     innerClass:[KMLLinearRing class]
                     xmlElement:element
                      eachBlock:^(KMLElement *element) {
                          [array addObject:element]; 
                      }];
        _innerBoundaryIsList = array;
    }
    return self;
}


#pragma mark - Public methods

- (BOOL)extrude
{
    return [KMLType boolean:_extrudeValue];
}

- (void)setExtrude:(BOOL)extrude
{
    _extrudeValue = [KMLType valueForBoolean:extrude];
}

- (BOOL)tessellate
{
    return [KMLType boolean:_tessellateValue];
}

- (void)setTessellate:(BOOL)tessellate
{
    _tessellateValue = [KMLType valueForBoolean:tessellate];
}

- (KMLAltitudeMode)altitudeMode
{
    return [KMLType altitudeMode:_altitudeModeValue];
}

- (void)setAltitudeMode:(KMLAltitudeMode)altitudeMode
{
    _altitudeModeValue = [KMLType valueForAltitudeMode:altitudeMode];
}

- (void)setOuterBoundaryIs:(KMLLinearRing *)outerBoundaryIs
{
    if (_outerBoundaryIs != outerBoundaryIs) {
        if (_outerBoundaryIs) {
            _outerBoundaryIs.parent = nil;
        }

        _outerBoundaryIs = outerBoundaryIs;
        if (_outerBoundaryIs) {
            _outerBoundaryIs.parent = self;
        }
    }
}

- (NSArray *)innerBoundaryIsList
{
    return [NSArray arrayWithArray:_innerBoundaryIsList];
}

- (void)addInnerBoundaryIs:(KMLLinearRing *)object
{
    if (object) {
        NSUInteger index = [_innerBoundaryIsList indexOfObject:object];
        if (index == NSNotFound) {
            object.parent = self;
            [_innerBoundaryIsList addObject:object];
        }
    }
}

- (void)addInnerBoundaryIsList:(NSArray *)array
{
    for (KMLLinearRing *object in array) {
        [self addInnerBoundaryIs:object];
    }
}

- (void)removeInnerBoundaryIs:(KMLLinearRing *)object
{
    NSUInteger index = [_innerBoundaryIsList indexOfObject:object];
    if (index != NSNotFound) {
        object.parent = nil;
        [_innerBoundaryIsList removeObject:object];
    }
}



#pragma mark - Private methods

- (KMLElement *)childElementNamed:(NSString *)name innerClass:(Class)class xmlElement:(KMLXMLElement *)element
{
    KMLElement *firstElement;
    KMLXMLElement *el = [KMLXML childElementNamed:name parentElement:element];
    if (el) {
        firstElement = [self childElementOfClass:class xmlElement:el];
    }
    
    if (!firstElement) {
        NSString *description = [NSString stringWithFormat:@"%@ element require %@ element.", [[self class] tagName], [class tagName]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                            object:self
                                                          userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
    }
    
    return firstElement;
}

- (void)childElementsNamed:(NSString *)name innerClass:(Class)class xmlElement:(KMLXMLElement *)element eachBlock:(void (^)(KMLElement *element))eachBlock
{
    KMLXMLElement *el = [KMLXML childElementNamed:name parentElement:element];
    while (el != nil) {
        KMLXMLElement *innerEl = [KMLXML childElementNamed:[class tagName] parentElement:el];
        if (innerEl) {
            eachBlock([[class alloc] initWithXMLElement:innerEl parent:self]);
        }
        el = [KMLXML nextSiblingNamed:[class tagName] searchFromElement:el];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Polygon";
}



#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_extrudeValue defaultValue:@"0" tagName:@"extrude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_tessellateValue defaultValue:@"0" tagName:@"tessellate" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeModeValue defaultValue:@"clampToGround" tagName:@"altitudeMode" indentationLevel:indentationLevel];
    
    if (self.outerBoundaryIs) {
        [kml appendFormat:@"%@<outerBoundaryIs>\r\n", [self indentForIndentationLevel:indentationLevel]];
        [self.outerBoundaryIs kml:kml indentationLevel:indentationLevel + 1];
        [kml appendFormat:@"%@</outerBoundaryIs>\r\n", [self indentForIndentationLevel:indentationLevel]];
    }
    if (self.innerBoundaryIsList && self.innerBoundaryIsList.count > 0) {
        [kml appendFormat:@"%@<innerBoundaryIs>\r\n", [self indentForIndentationLevel:indentationLevel]];
        for (KMLLinearRing *linearRing in self.innerBoundaryIsList) {
            [linearRing kml:kml indentationLevel:indentationLevel + 1];
        }
        [kml appendFormat:@"%@</innerBoundaryIs>\r\n", [self indentForIndentationLevel:indentationLevel]];
    }
}

@end
