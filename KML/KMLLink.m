//
//  KMLLink.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLLink.h"
#import "KMLElementSubclass.h"

@implementation KMLLink {
    NSString *_refreshModeValue;
    NSString *_refreshIntervalValue;
    NSString *_viewRefreshModeValue;
    NSString *_viewRefreshTimeValue;
    NSString *_viewBoundScaleValue;
}

@synthesize href = _href;
@synthesize refreshMode = _refreshMode;
@synthesize refreshInterval = _refreshInterval;
@synthesize viewRefreshMode = _viewRefreshMode;
@synthesize viewRefreshTime = _viewRefreshTime;
@synthesize viewBoundScale = _viewBoundScale;
@synthesize viewFormat = _viewFormat;
@synthesize httpQuery = _httpQuery;


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super initWithXMLElement:element parent:parent];
    if (self) {
        _href = [self textForSingleChildElementNamed:@"href" xmlElement:element];
        _refreshModeValue = [self textForSingleChildElementNamed:@"refreshMode" xmlElement:element];
        _refreshIntervalValue = [self textForSingleChildElementNamed:@"refreshInterval" xmlElement:element];
        _viewRefreshModeValue = [self textForSingleChildElementNamed:@"viewRefreshMode" xmlElement:element];
        _viewRefreshTimeValue = [self textForSingleChildElementNamed:@"viewRefreshTime" xmlElement:element];
        _viewBoundScaleValue = [self textForSingleChildElementNamed:@"viewBoundScale" xmlElement:element];
        _viewFormat = [self textForSingleChildElementNamed:@"viewFormat" xmlElement:element];
        _httpQuery = [self textForSingleChildElementNamed:@"httpQuery" xmlElement:element];
    }
    return self;
}


#pragma mark - Public methods

- (KMLRefreshMode)refreshMode
{
    return [KMLType refreshMode:_refreshModeValue];
}

- (void)setRefreshMode:(KMLRefreshMode)refreshMode
{
    _refreshModeValue = [KMLType valueForRefreshMode:refreshMode];
}

- (CGFloat)refreshInterval
{
    @try {
        return [_refreshIntervalValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 4.f;
}

- (void)setRefreshInterval:(CGFloat)refreshInterval
{
    _refreshIntervalValue = [NSString stringWithFormat:@"%f", refreshInterval];
}

- (KMLViewRefreshMode)viewRefreshMode
{
    return [KMLType viewRefreshMode:_viewRefreshModeValue];
}

- (void)setViewRefreshMode:(KMLViewRefreshMode)viewRefreshMode
{
    _viewRefreshModeValue = [KMLType valueForViewRefreshMode:viewRefreshMode];
}

- (CGFloat)viewRefreshTime
{
    @try {
        return [_viewRefreshTimeValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 4.f;
}

- (void)setViewRefreshTime:(CGFloat)viewRefreshTime
{
    _viewRefreshTimeValue = [NSString stringWithFormat:@"%f", viewRefreshTime];
}

- (CGFloat)viewBoundScale
{
    @try {
        return [_viewBoundScaleValue floatValue];
    }
    @catch (NSException *exception) {
    }
    
    return 1.f;
}

- (void)setViewBoundScale:(CGFloat)viewBoundScale
{
    _viewBoundScaleValue = [NSString stringWithFormat:@"%f", viewBoundScale];
}


#pragma mark - tag

+ (NSString *)tagName
{
    return @"Link";
}


#pragma mark - KML

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [super addChildTagToKml:kml indentationLevel:indentationLevel];
    
    [self kml:kml addPropertyForValue:_href tagName:@"href" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_refreshModeValue defaultValue:@"onChange" tagName:@"refreshMode" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_refreshIntervalValue defaultValue:@"4" tagName:@"refreshInterval" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_viewRefreshModeValue defaultValue:@"never" tagName:@"viewRefreshMode" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_viewRefreshTimeValue defaultValue:@"4" tagName:@"viewRefreshTime" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_viewBoundScaleValue defaultValue:@"1" tagName:@"viewBoundScale" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_viewFormat tagName:@"viewFormat" indentationLevel:indentationLevel];
    [self kml:kml addPropertyForValue:_httpQuery tagName:@"httpQuery" indentationLevel:indentationLevel];
    
}

@end
