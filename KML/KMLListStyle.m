//
//  KMLListStyle.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLListStyle.h"
#import "KMLElementSubclass.h"
#import "KMLItemIcon.h"

@implementation KMLListStyle {
    NSString *_listItemTypeValue;
}

@synthesize listItemType = _listItemType;
@synthesize bgColor = _bgColor;
@synthesize itemIcon = _itemIcon;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _listItemTypeValue = [self textForSingleChildElementNamed:@"listItemType" xmlElement:element];
        _bgColor = [self textForSingleChildElementNamed:@"bgColor" xmlElement:element];
        
        _itemIcon = (KMLItemIcon *)[self childElementOfClass:[KMLItemIcon class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (KMLListItemType)listItemType
{
    return [KMLType listItemType:_listItemTypeValue];
}

- (void)setListItemType:(KMLListItemType)listItemType
{
    _listItemTypeValue = [KMLType valueForListItemType:listItemType];
}

- (void)setItemIcon:(KMLItemIcon *)itemIcon
{
    if (_itemIcon != itemIcon) {
        if (_itemIcon) {
            _itemIcon.parent = nil;
        }
        
        _itemIcon = itemIcon;
        if (_itemIcon) {
            _itemIcon.parent = self;
        }
    }
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"ListStyle";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_listItemTypeValue defaultValue:@"check" tagName:@"listItemType" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_bgColor defaultValue:@"ffffffff" tagName:@"bgColor" indentationLevel:indentationLevel];
    if (self.itemIcon) {
        [self.itemIcon kml:kml indentationLevel:indentationLevel];
    }
}

@end
