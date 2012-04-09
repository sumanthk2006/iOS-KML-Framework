//
//  KMLNetworkLink.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLNetworkLink.h"
#import "KMLElementSubclass.h"
#import "KMLLink.h"

@implementation KMLNetworkLink {
    NSString *_refreshVisibilityValue;
    NSString *_flyToViewValue;
}

@synthesize refreshVisibility = _refreshVisibility;
@synthesize flyToView = _flyToView;
@synthesize link = _link;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _refreshVisibilityValue = [self textForSingleChildElementNamed:@"refreshVisibility" xmlElement:element];
        _flyToViewValue = [self textForSingleChildElementNamed:@"flyToView" xmlElement:element];
        
        _link = (KMLLink *)[self childElementOfClass:[KMLLink class] xmlElement:element required:YES];
    }
    return self;
}


#pragma mark - Public methods

- (BOOL)refreshVisibility
{
    return [KMLType boolean:_refreshVisibilityValue];
}

- (void)setRefreshVisibility:(BOOL)refreshVisibility
{
    _refreshVisibilityValue = [KMLType valueForBoolean:refreshVisibility];
}

- (BOOL)flyToView
{
    return [KMLType boolean:_flyToViewValue];
}

- (void)setFlyToView:(BOOL)flyToView
{
    _flyToViewValue = [KMLType valueForBoolean:flyToView];
}

- (void)setLink:(KMLLink *)link
{
    if (_link != link) {
        if (_link) {
            _link.parent = nil;
        }

        _link = link;
        if (_link) {
            _link.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"NetworkLink";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_refreshVisibilityValue defaultValue:@"0" tagName:@"refreshVisibility" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_flyToViewValue defaultValue:@"0" tagName:@"flyToView" indentationLevel:indentationLevel];
    
    if (self.link) {
        [self.link kml:kml indentationLevel:indentationLevel];
    }
}

@end
