//
//  KMLAbstractFeature.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLAbstractFeature.h"
#import "KMLElementSubclass.h"
#import "KMLAbstractView.h"
#import "KMLAbstractTimePrimitive.h"
#import "KMLAbstractStyleSelector.h"
#import "KMLRegion.h"
#import "KMLMetadata.h"
#import "KMLExtendedData.h"
#import "KMLNetworkLink.h"
#import "KMLPlacemark.h"
#import "KMLAbstractOverlay.h"
#import "KMLAbstractContainer.h"
#import "KMLStyle.h"
#import "KMLDocument.h"
#import "KMLData.h"

@implementation KMLAbstractFeature {
    NSString *_visibilityValue;
    NSString *_openValue;
    NSMutableArray *_styleSelectors;
}

@synthesize name = _name;
@synthesize visibility = _visibility;
@synthesize open = _open;
@synthesize atomAuthor = _atomAuthor;
@synthesize atomLink = _atomLink;
@synthesize address = _address;
@synthesize xalAddressDetails = _xalAddressDetails;
@synthesize phoneNumber = _phoneNumber;
@synthesize snippet = _snippet;
@synthesize descriptionValue = _descriptionValue;
@synthesize abstractView = _abstractView;
@synthesize timePrimitive = _timePrimitive;
@synthesize styleUrl = _styleUrl;
@synthesize styleSelectors;
@synthesize region = _region;
@synthesize metadata = _metadata;
@synthesize extendedData = _extendedData;


#pragma mark - Instance

- (id)init
{
    self = [super init];
    if (self) {
        _styleSelectors = [NSMutableArray array];
    }
    return self;
}

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _name = [self textForSingleChildElementNamed:@"name" xmlElement:element];
        _visibilityValue = [self textForSingleChildElementNamed:@"visibility" xmlElement:element];
        _openValue = [self textForSingleChildElementNamed:@"open" xmlElement:element];
        _address = [self textForSingleChildElementNamed:@"address" xmlElement:element];
        _phoneNumber = [self textForSingleChildElementNamed:@"phoneNumber" xmlElement:element];
        _snippet = [self textForSingleChildElementNamed:@"Snippet" xmlElement:element];
        _descriptionValue = [self textForSingleChildElementNamed:@"description" xmlElement:element];
        _styleUrl = [self textForSingleChildElementNamed:@"styleUrl" xmlElement:element];
        
        _abstractView = (KMLAbstractView *)[self childElementOfClass:[KMLAbstractView class] xmlElement:element];
        _timePrimitive = (KMLAbstractTimePrimitive *)[self childElementOfClass:[KMLAbstractTimePrimitive class] xmlElement:element];
        
        NSMutableArray *array = [NSMutableArray array];
        [self childElementsOfClass:[KMLAbstractStyleSelector class]
                       xmlElement:element
                          eachBlock:^(KMLElement *element) {
                              [array addObject:element];
                          }];
        _styleSelectors = array;
        
        _region = (KMLRegion *)[self childElementOfClass:[KMLRegion class] xmlElement:element];
        _metadata = (KMLMetadata *)[self childElementOfClass:[KMLMetadata class] xmlElement:element];
        _extendedData = (KMLExtendedData *)[self childElementOfClass:[KMLExtendedData class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (BOOL)visibility
{
    return [KMLType boolean:_visibilityValue];
}

- (void)setVisibility:(BOOL)visibility
{
    _visibilityValue = [KMLType valueForBoolean:visibility];
}

- (BOOL)open
{
    return [KMLType boolean:_openValue];
}

- (void)setOpen:(BOOL)open
{
    _openValue = [KMLType valueForBoolean:open];
}

- (void)setAbstractView:(KMLAbstractView *)abstractView
{
    if (_abstractView != abstractView) {
        if (_abstractView) {
            _abstractView.parent = nil;
        }

        _abstractView = abstractView;
        if (_abstractView) {
            _abstractView.parent = self;
        }
    }
}

- (void)setTimePrimitive:(KMLAbstractTimePrimitive *)timePrimitive
{
    if (_timePrimitive != timePrimitive) {
        if (_timePrimitive) {
            _timePrimitive.parent = nil;
        }

        _timePrimitive = timePrimitive;
        if (_timePrimitive) {
            _timePrimitive.parent = self;
        }
    }
}

- (NSArray *)styleSelectors
{
    return [NSArray arrayWithArray:_styleSelectors];
}

- (void)addStyleSelector:(KMLAbstractStyleSelector *)styleSelector
{
    if (styleSelector) {
        NSUInteger index = [_styleSelectors indexOfObject:styleSelector];
        if (index == NSNotFound) {
            styleSelector.parent = self;
            [_styleSelectors addObject:styleSelector];
        }
    }
}

- (void)addStyleSelectors:(NSArray *)array
{
    for (KMLAbstractStyleSelector *styleSelector in array) {
        [self addStyleSelector:styleSelector];
    }
}

- (void)removeStyleSelector:(KMLAbstractStyleSelector *)styleSelector
{
    NSUInteger index = [_styleSelectors indexOfObject:styleSelector];
    if (index != NSNotFound) {
        styleSelector.parent = nil;
        [_styleSelectors removeObject:styleSelector];
    }
}

- (void)setRegion:(KMLRegion *)region
{
    if (_region != region) {
        if (_region) {
            _region.parent = nil;
        }

        _region = region;
        if (_region) {
            _region.parent = self;
        }
    }
}

- (void)setMetadata:(KMLMetadata *)metadata
{
    if (_metadata != metadata) {
        if (_metadata) {
            _metadata.parent = nil;
        }

        _metadata = metadata;
        if (_metadata) {
            _metadata.parent = self;
        }
    }
}

- (void)setExtendedData:(KMLExtendedData *)extendedData
{
    if (_extendedData != extendedData) {
        if (_extendedData) {
            _extendedData.parent = nil;
        }

        _extendedData = extendedData;
        if (_extendedData) {
            _extendedData.parent = self;
        }
    }
}

- (KMLStyle *)style
{
    KMLStyle *style;
    
    NSRange range = [self.styleUrl rangeOfString:@"#"];
    if (range.length == 1 && range.location == 0) {
        NSString *styleID = [self.styleUrl substringFromIndex:1];
        
        KMLElement *element = self.parent;
        while (element) {
            if ([element isKindOfClass:[KMLDocument class]]) {
                KMLDocument *document = (KMLDocument *)element;
                for (KMLAbstractStyleSelector *styleSelector in document.styleSelectors) {
                    if ([styleSelector isKindOfClass:[KMLStyle class]]) {
                        KMLStyle *sharedStyle = (KMLStyle *)styleSelector;
                        if ([styleID isEqualToString:sharedStyle.objectID]) {
                            if (!style) {
                                style = [KMLStyle new];
                                style.parent = self;
                            }
                            
                            if (sharedStyle.iconStyle) {
                                style.iconStyle = sharedStyle.iconStyle;
                            }
                            if (sharedStyle.labelStyle) {
                                style.labelStyle = sharedStyle.labelStyle;
                            }
                            if (sharedStyle.lineStyle) {
                                style.lineStyle = sharedStyle.lineStyle;
                            }
                            if (sharedStyle.polyStyle) {
                                style.polyStyle = sharedStyle.polyStyle;
                            }
                            if (sharedStyle.balloonStyle) {
                                style.balloonStyle = sharedStyle.balloonStyle;
                            }
                            if (sharedStyle.listStyle) {
                                style.listStyle = sharedStyle.listStyle;
                            }
                            break;
                        }
                    }
                }
            }
            
            element = element.parent;
        }
    }

    for (KMLAbstractStyleSelector *styleSelector in self.styleSelectors) {
        if ([styleSelector isKindOfClass:[KMLStyle class]]) {
            KMLStyle *childStyle = (KMLStyle *)styleSelector;

            if (!style) {
                style = [KMLStyle new];
                style.parent = self;
            }

            if (childStyle.iconStyle) {
                style.iconStyle = childStyle.iconStyle;
            }
            if (childStyle.labelStyle) {
                style.labelStyle = childStyle.labelStyle;
            }
            if (childStyle.lineStyle) {
                style.lineStyle = childStyle.lineStyle;
            }
            if (childStyle.polyStyle) {
                style.polyStyle = childStyle.polyStyle;
            }
            if (childStyle.balloonStyle) {
                style.balloonStyle = childStyle.balloonStyle;
            }
            if (childStyle.listStyle) {
                style.listStyle = childStyle.listStyle;
            }
        }
    }

    return style;
}

- (NSString *)extendedDataValueForName:(NSString *)name
{
    if (self.extendedData && self.extendedData.dataList) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSArray *array = [self.extendedData.dataList filteredArrayUsingPredicate:predicate];
        if (array.count > 0) {
            KMLData *data = (KMLData *)[array objectAtIndex:0];
            return data.value;
        }
    }

    return nil;
}

- (void)addExtendedDataWithName:(NSString *)name value:(NSString *)value
{
    if (!self.extendedData) {
        KMLExtendedData *extendedData = [KMLExtendedData new];
        self.extendedData = extendedData;
    }
    
    KMLData *data = [KMLData new];
    data.name = name;
    data.value = value;
    [self.extendedData addData:data];
}



#pragma mark - tag

+ (NSString *)tagName
{
    return @"AbstractFeature";
}

+ (NSArray *)implementClasses
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[KMLNetworkLink class]];
    [array addObject:[KMLPlacemark class]];
    [array addObjectsFromArray:[KMLAbstractOverlay implementClasses]];
    [array addObjectsFromArray:[KMLAbstractContainer implementClasses]];
    return [NSArray arrayWithArray:array];
}


#pragma makr - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_name tagName:@"name" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_visibilityValue defaultValue:@"1" tagName:@"visibility" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_openValue defaultValue:@"0" tagName:@"open" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_address tagName:@"address" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_phoneNumber tagName:@"phoneNumber" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_snippet tagName:@"Snippet" attribute:@"maxLines=\"2\"" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_descriptionValue tagName:@"description" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_styleUrl tagName:@"styleUrl" indentationLevel:indentationLevel];
    
    if (self.abstractView) {
        [self.abstractView kml:kml indentationLevel:indentationLevel];
    }
    for (KMLAbstractStyleSelector *styleSelector in self.styleSelectors) {
        [styleSelector kml:kml indentationLevel:indentationLevel];
    }
    if (self.region) {
        [self.region kml:kml indentationLevel:indentationLevel];
    }
    if (self.metadata) {
        [self.metadata kml:kml indentationLevel:indentationLevel];
    }
    if (self.extendedData) {
        [self.extendedData kml:kml indentationLevel:indentationLevel];
    }
}

@end
