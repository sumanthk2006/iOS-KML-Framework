//
//  KMLNetworkLinkControl.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLNetworkLinkControl.h"
#import "KMLElementSubclass.h"
#import "KMLUpdate.h"
#import "KMLAbstractView.h"

@implementation KMLNetworkLinkControl {
    NSString *_minRefreshPeriodValue;
    NSString *_maxSessionLengthValue;
    NSString *_expiresValue;
}

@synthesize minRefreshPeriod = _minRefreshPeriod;
@synthesize maxSessionLength = _maxSessionLength;
@synthesize cookie = _cookie;
@synthesize message = _message;
@synthesize linkName = _linkName;
@synthesize linkDescription = _linkDescription;
@synthesize linkSnippet = _linkSnippet;
@synthesize expires = _expires;
@synthesize update = _update;
@synthesize abstractView = _abstractView;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _minRefreshPeriodValue = [self textForSingleChildElementNamed:@"minRefreshPeriod" xmlElement:element];
        _maxSessionLengthValue = [self textForSingleChildElementNamed:@"maxSessionLength" xmlElement:element];
        _cookie = [self textForSingleChildElementNamed:@"cookie" xmlElement:element];
        _message = [self textForSingleChildElementNamed:@"message" xmlElement:element];
        _linkName = [self textForSingleChildElementNamed:@"linkName" xmlElement:element];
        _linkDescription = [self textForSingleChildElementNamed:@"linkDescription" xmlElement:element];
        _expiresValue = [self textForSingleChildElementNamed:@"expires" xmlElement:element];
        
        _update = (KMLUpdate *)[self childElementOfClass:[KMLUpdate class] xmlElement:element];
        _abstractView = (KMLAbstractView *)[self childElementOfClass:[KMLAbstractView class] xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (CGFloat)minRefreshPeriod
{
    @try {
        return [_minRefreshPeriodValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

- (void)setMinRefreshPeriod:(CGFloat)minRefreshPeriod
{
    _minRefreshPeriodValue = [NSString stringWithFormat:@"%f", minRefreshPeriod];
}

- (CGFloat)maxSessionLength
{
    @try {
        return [_maxSessionLengthValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return -1.f;
}

- (void)setMaxSessionLength:(CGFloat)maxSessionLength
{
    _maxSessionLengthValue = [NSString stringWithFormat:@"%f", maxSessionLength];
}

- (NSDate *)expires
{
    return [KMLType dateTime:_expiresValue];
}

- (void)setExpires:(NSDate *)expires
{
    _expiresValue = [KMLType valueForDateTime:expires];
}

- (void)setUpdate:(KMLUpdate *)update
{
    if (_update != update) {
        if (_update) {
            _update.parent = nil;
        }

        _update = update;
        if (_update) {
            _update.parent = self;
        }
    }
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


#pragma mark - tag

+ (NSString *)tagName
{
    return @"NetworkLinkControl";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_minRefreshPeriodValue defaultValue:@"0" tagName:@"minRefreshPeriod" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_maxSessionLengthValue defaultValue:@"-1" tagName:@"maxSessionLength" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_cookie tagName:@"cookie" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_message tagName:@"message" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_linkName tagName:@"linkName" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_linkDescription tagName:@"linkDescription" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_linkSnippet tagName:@"linkSnippet" attribute:@"maxLines=\"2\"" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_expiresValue tagName:@"expires" indentationLevel:indentationLevel];
    
    if (self.update) {
        [self.update kml:kml indentationLevel:indentationLevel];
    }
    if (self.abstractView) {
        [self.abstractView kml:kml indentationLevel:indentationLevel];
    }
}

@end
