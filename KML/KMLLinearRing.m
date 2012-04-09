//
//  KMLLinearRing.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLinearRing.h"
#import "KMLElementSubclass.h"
#import "KMLCoordinate.h"

@implementation KMLLinearRing {
    NSString *_extrudeValue;
    NSString *_tessellateValue;
    NSString *_altitudeModeValue;
    NSMutableArray *_coordinates;
}

@synthesize extrude = _extrude;
@synthesize tessellate = _tessellate;
@synthesize altitudeMode = _altitudeMode;
@synthesize coordinates;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _coordinates = [NSMutableArray array];
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

        NSString *coordinatesValue = [self textForSingleChildElementNamed:@"coordinates" xmlElement:element required:YES];
        if (coordinatesValue && ![coordinatesValue isEqualToString:@""]) {
            NSMutableArray *array = [NSMutableArray array];
            
            NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"[ ]?,[ ]?" options:0 error:nil];
            
            // separate by new line
            NSArray *lines = [coordinatesValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            for (NSString *line in lines) {
                
                // trim spaces around ','
                NSString *string = [regexp stringByReplacingMatchesInString:line options:0 range:NSMakeRange(0, line.length) withTemplate:@","];
                
                // separate by space
                NSArray *coordinatesValues = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                for (NSString *coordinatesValue in coordinatesValues) {
                    if (coordinatesValue.length > 0 && ![coordinatesValue isEqualToString:@" "]) {
                        KMLCoordinate *coordinate = [[KMLCoordinate alloc] initWithText:coordinatesValue];
                        [array addObject:coordinate];
                    }
                }
            }
            
            _coordinates = array;
        }
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

- (NSArray *)coordinates
{
    return [NSArray arrayWithArray:_coordinates];
}

- (void)addCoordinate:(KMLCoordinate *)coordinate
{
    if (coordinate) {
        NSUInteger index = [_coordinates indexOfObject:coordinate];
        if (index == NSNotFound) {
            coordinate.parent = self;
            [_coordinates addObject:coordinate];
        }
    }
}

- (void)addCoordinates:(NSArray *)array
{
    for (KMLCoordinate *coordinate in array) {
        [self addCoordinate:coordinate];
    }
}

- (void)removeCoordinate:(KMLCoordinate *)coordinate
{
    NSUInteger index = [_coordinates indexOfObject:coordinate];
    if (index != NSNotFound) {
        coordinate.parent = nil;
        [_coordinates removeObject:coordinate];
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"LinearRing";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_extrudeValue defaultValue:@"0" tagName:@"extrude" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_tessellateValue defaultValue:@"0" tagName:@"tessellate" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_altitudeModeValue defaultValue:@"clampToGround" tagName:@"altitudeMode" indentationLevel:indentationLevel];
 
    [kml appendFormat:@"%@<coordinates>", [self indentForIndentationLevel:indentationLevel]];
    for (KMLCoordinate *coordinate in self.coordinates) {
        [coordinate kml:kml indentationLevel:indentationLevel];
        [kml appendString:@" "];
    }
    [kml appendString:@"</coordinates>\r\n"];
}

@end
