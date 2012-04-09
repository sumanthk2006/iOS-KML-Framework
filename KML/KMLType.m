//
//  KMLType.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLType.h"

@implementation KMLType

+ (KMLAltitudeMode)altitudeMode:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"clampToGround"]) {
            return KMLAltitudeModeClampToGround;
        }
        if ([value isEqualToString:@"relativeToGround"]) {
            return KMLAltitudeModeRelativeToGround;
        }
    }
    
    return KMLAltitudeModeAbsolute;
}

+ (NSString *)valueForAltitudeMode:(KMLAltitudeMode)altitudeMode
{
    switch (altitudeMode) {
        case KMLAltitudeModeClampToGround:
            return @"clampToGround";
        case KMLAltitudeModeRelativeToGround:
            return @"relativeToGround";
        default:
            return @"absolute";
    }
}

+ (KMLColorMode)colorMode:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"random"]) {
            return KMLColorModeRandom;
        }
    }
    
    return KMLColorModeNormal;
}

+ (NSString *)valueForColorMode:(KMLColorMode)colorMode
{
    switch (colorMode) {
        case KMLColorModeRandom:
            return @"random";
        default:
            return @"normal";
    }
}

+ (KMLDisplayMode)displayMode:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"hide"]) {
            return KMLDisplayModeHide;
        }
    }
    
    return KMLDisplayModeDefault;
}

+ (NSString *)valueForDisplayMode:(KMLDisplayMode)displayMode
{
    switch (displayMode) {
        case KMLDisplayModeHide:
            return @"hide";
        default:
            return @"default";
    }
}

+ (KMLRefreshMode)refreshMode:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"onInterval"]) {
            return KMLRefreshModeOnInterval;
        }
        if ([value isEqualToString:@"onExpire"]) {
            return KMLRefreshModeOnExpire;
        }
    }
    
    return KMLRefreshModeOnChange;
}

+ (NSString *)valueForRefreshMode:(KMLRefreshMode)refreshMode
{
    switch (refreshMode) {
        case KMLRefreshModeOnInterval:
            return @"onInterval";
        case KMLRefreshModeOnExpire:
            return @"onExpire";
        default:
            return @"onChange";
    }
}

+ (KMLShape)shape:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"cylinder"]) {
            return KMLShapeCylinder;
        }
        if ([value isEqualToString:@"sphere"]) {
            return KMLShapeSphere;
        }
    }
    
    return KMLShapeRectangle;
}

+ (NSString *)valueForShape:(KMLShape)shape
{
    switch (shape) {
        case KMLShapeCylinder:
            return @"cylinder";
        case KMLShapeSphere:
            return @"sphere";
        default:
            return @"rectangle";
    }
}

+ (KMLStyleState)styleState:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"highlight"]) {
            return KMLStyleStateHighlight;
        }
    }
    
    return KMLStyleStateNormal;
}

+ (NSString *)valueForStyleState:(KMLStyleState)styleState
{
    switch (styleState) {
        case KMLStyleStateHighlight:
            return @"highlight";
        default:
            return @"normal";
    }
}

+ (KMLUnits)units:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"pixels"]) {
            return KMLUnitsPixels;
        }
        if ([value isEqualToString:@"insetPixels"]) {
            return KMLUnitsInsetPixels;
        }
    }
    
    return KMLUnitsFraction;
}

+ (NSString *)valueForUnits:(KMLUnits)units
{
    switch (units) {
        case KMLUnitsPixels:
            return @"pixels";
        case KMLUnitsInsetPixels:
            return @"insetPixels";
        default:
            return @"fraction";
    }
}

+ (KMLViewRefreshMode)viewRefreshMode:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"onRequest"]) {
            return KMLViewRefreshModeOnRequest;
        }
        if ([value isEqualToString:@"onStop"]) {
            return KMLViewRefreshModeOnStop;
        }
        if ([value isEqualToString:@"onRegion"]) {
            return KMLViewRefreshModeOnRegion;
        }
    }
    
    return KMLViewRefreshModeNever;
}

+ (NSString *)valueForViewRefreshMode:(KMLViewRefreshMode)viewRefreshMode
{
    switch (viewRefreshMode) {
        case KMLViewRefreshModeOnRequest:
            return @"onRequest";
        case KMLViewRefreshModeOnStop:
            return @"onStop";
        case KMLViewRefreshModeOnRegion:
            return @"onRegion";
        default:
            return @"never";
    }
}

+ (KMLListItemType)listItemType:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"radioFolder"]) {
            return KMLListItemTypeRadioFolder;
        }
        if ([value isEqualToString:@"checkOffOnly"]) {
            return KMLListItemTypeCheckOffOnly;
        }
        if ([value isEqualToString:@"checkHideChildren"]) {
            return KMLListItemTypeCheckHideChildren;
        }
    }
    
    return KMLListItemTypeCheck;
}

+ (NSString *)valueForListItemType:(KMLListItemType)listItemType
{
    switch (listItemType) {
        case KMLListItemTypeRadioFolder:
            return @"radioFolder";
        case KMLListItemTypeCheckOffOnly:
            return @"checkOffOnly";
        case KMLListItemTypeCheckHideChildren:
            return @"checkHideChildren";
        default:
            return @"check";
    }
}

+ (KMLItemIconMode)itemIconMode:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"closed"]) {
            return KMLItemIconModeClosed;
        }
        if ([value isEqualToString:@"error"]) {
            return KMLItemIconModeError;
        }
        if ([value isEqualToString:@"fetching0"]) {
            return KMLItemIconModeFetching0;
        }
        if ([value isEqualToString:@"fetching1"]) {
            return KMLItemIconModeFetching1;
        }
        if ([value isEqualToString:@"fetching2"]) {
            return KMLItemIconModeFetching2;
        }
    }

    return KMLItemIconModeOpen;
}

+ (NSString *)valueForItemIconMode:(KMLItemIconMode)itemIconMode
{
    switch (itemIconMode) {
        case KMLItemIconModeClosed:
            return @"closed";
        case KMLItemIconModeError:
            return @"error";
        case KMLItemIconModeFetching0:
            return @"fetching0";
        case KMLItemIconModeFetching1:
            return @"fetching1";
        case KMLItemIconModeFetching2:
            return @"fetching2";
        default:
            return @"open";
    }
}

+ (KMLGridOrigin)gridOrigin:(NSString *)value
{
    if (value) {
        if ([value isEqualToString:@"lowerLeft"]) {
            return KMLGridOriginLowerLeft;
        }
    }
    
    return KMLGridOriginUpperLeft;
}

+ (NSString *)valueForGridOrigin:(KMLGridOrigin)gridOrigin
{
    switch (gridOrigin) {
        case KMLGridOriginLowerLeft:
            return @"lowerLeft";
        default:
            return @"upperLeft";
    }
}

+ (NSDate *)dateTime:(NSString *)value
{
    NSDate *date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

    // dateTime（YYYY-MM-DDThh:mm:ssZ）
    formatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";
    date = [formatter dateFromString:value];
    if (date) {
        return date;
    }
    
    // dateTime（YYYY-MM-DDThh:mm:sszzzzzz）
    if (value.length >= 22) {
        formatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'sszzzz";
        NSString *v = [value stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange(22, 1)];
        date = [formatter dateFromString:v];
        if (date) {
            return date;
        }
    }

    // date
    formatter.dateFormat = @"yyyy'-'MM'-'dd'";
    date = [formatter dateFromString:value];
    if (date) {
        return date;
    }

    // gYearMonth
    formatter.dateFormat = @"yyyy'-'MM'";
    date = [formatter dateFromString:value];
    if (date) {
        return date;
    }

    // gYear
    formatter.dateFormat = @"yyyy'";
    date = [formatter dateFromString:value];
    if (date) {
        return date;
    }

    return nil;
}

+ (NSString *)valueForDateTime:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

    // dateTime（YYYY-MM-DDThh:mm:ssZ）
    formatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";
    
    return [formatter stringFromDate:date];
}

+ (BOOL)boolean:(NSString *)value
{
    return [self boolean:value defaultValue:NO];
}

+ (BOOL)boolean:(NSString *)value defaultValue:(BOOL)defaultValue
{
    if (value) {
        if ([value isEqualToString:@"1"]) {
            return YES;
        }
    }
    
    return defaultValue;
}

+ (NSString *)valueForBoolean:(BOOL)boolean
{
    if (boolean) {
        return @"1";
    }
    
    return @"0";
}

+ (CGFloat)angle90:(NSString *)value
{
    @try {
        CGFloat f = [value floatValue];
        if (-90.f <= f && f <= 90.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

+ (NSString *)valueForAngle90:(CGFloat)angle90
{
    if (-90.f <= angle90 && angle90 <= 90.f) {
        return [NSString stringWithFormat:@"%f", angle90];
    }
    
    return @"0";
}

+ (CGFloat)anglepos90:(NSString *)value
{
    @try {
        CGFloat f = [value floatValue];
        if (0.f <= f && f <= 90.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

+ (NSString *)valueForAnglepos90:(CGFloat)anglepos90
{
    if (0.f <= anglepos90 && anglepos90 <= 90.f) {
        return [NSString stringWithFormat:@"%f", anglepos90];
    }
    
    return @"0";
}

+ (CGFloat)angle180:(NSString *)value
{
    @try {
        CGFloat f = [value floatValue];
        if (-180.f <= f && f <= 180.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

+ (NSString *)valueForAngle180:(CGFloat)angle180
{
    if (-180.f <= angle180 && angle180 <= 180.f) {
        return [NSString stringWithFormat:@"%f", angle180];
    }
    
    return @"0";
}

+ (CGFloat)anglepos180:(NSString *)value
{
    @try {
        CGFloat f = [value floatValue];
        if (0.f <= f && f <= 180.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

+ (NSString *)valueForAnglepos180:(CGFloat)anglepos180
{
    if (0.f <= anglepos180 && anglepos180 <= 180.f) {
        return [NSString stringWithFormat:@"%f", anglepos180];
    }
    
    return @"0";
}

+ (CGFloat)angle360:(NSString *)value
{
    @try {
        CGFloat f = [value floatValue];
        if (-360.f <= f && f <= 360.f) {
            return f;
        }
    }
    @catch (NSException *exception) {
    }
    
    return 0.f;
}

+ (NSString *)valueForAngle360:(CGFloat)angle360
{
    if (-360.f <= angle360 && angle360 <= 360.f) {
        return [NSString stringWithFormat:@"%f", angle360];
    }
    
    return @"0";
}

@end
