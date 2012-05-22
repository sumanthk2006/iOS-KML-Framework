//
//  KMLElement.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLElement.h"
#import "KMLConst.h"
#import "KMLElementSubclass.h"

@implementation KMLElement

@synthesize parent = _parent;


#pragma mark - Tag

+ (NSString *)tagName
{
    return nil;
}

+ (NSArray *)implementClasses
{
    return nil;
}


#pragma mark - Instance

- (id)initWithXMLElement:(KMLXMLElement *)element parent:(KMLElement *)parent
{
    self = [super init];
    if (self) {
        self.parent = parent;
    }
    return self;
}

- (void)dealloc
{
    _parent = nil;
}


#pragma mark - Elements

- (NSString *)textForSingleChildElementNamed:(NSString *)name xmlElement:(KMLXMLElement *)element
{
    return [self textForSingleChildElementNamed:name xmlElement:element required:NO];
}

- (NSString *)textForSingleChildElementNamed:(NSString *)name xmlElement:(KMLXMLElement *)element required:(BOOL)required
{
    KMLXMLElement *el = [KMLXML childElementNamed:name parentElement:element];
    if (el) {
        return [KMLXML textForElement:el];
    } else {
        if (required) {
            NSString *description = [NSString stringWithFormat:@"%@ element require %@ element.", [[self class] tagName], name];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
        }
    }
    
    return nil;
}

- (KMLElement *)childElementOfClass:(Class)class xmlElement:(KMLXMLElement *)element
{
    return [self childElementOfClass:class xmlElement:element required:NO];
}

- (KMLElement *)childElementOfClass:(Class)class xmlElement:(KMLXMLElement *)element required:(BOOL)required
{
    KMLElement *firstElement;
    if ([[class tagName] hasPrefix:@"Abstract"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (Class impl in [class implementClasses]) {
            KMLElement *el = [self childElementOfClass:impl xmlElement:element];
            if (el) {
                [array addObject:el];
            }
        }

        if (array.count > 0) {
            firstElement = [array objectAtIndex:0];
        }
        
        if (array.count > 1) {
            NSString *description = [NSString stringWithFormat:@"%@ element has more than two %@ elements.", [[self class] tagName], [class tagName]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
        }

    } else {
        KMLXMLElement *el = [KMLXML childElementNamed:[class tagName] parentElement:element];
        if (el) {
            firstElement = [[class alloc] initWithXMLElement:el parent:self];

            KMLXMLElement *secondElement = [KMLXML nextSiblingNamed:[class tagName] searchFromElement:el];
            if (secondElement) {
                NSString *description = [NSString stringWithFormat:@"%@ element has more than two %@ elements.", [[self class] tagName], [class tagName]];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                                    object:self
                                                                  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
            }
        }
    }

    if (required) {
        if (!firstElement) {
            NSString *description = [NSString stringWithFormat:@"%@ element require %@ element.", [[self class] tagName], [class tagName]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
        }
    }

    return firstElement;
}

- (KMLElement *)childElementNamed:(NSString *)name class:(Class)class xmlElement:(KMLXMLElement *)element
{
    return [self childElementNamed:name class:class xmlElement:element required:NO];
}

- (KMLElement *)childElementNamed:(NSString *)name class:(Class)class xmlElement:(KMLXMLElement *)element required:(BOOL)required
{
    KMLElement *firstElement;
    KMLXMLElement *el = [KMLXML childElementNamed:name parentElement:element];
    if (el) {
        firstElement = [[class alloc] initWithXMLElement:el parent:self];
        
        KMLXMLElement *secondElement = [KMLXML nextSiblingNamed:name searchFromElement:el];
        if (secondElement) {
            NSString *description = [NSString stringWithFormat:@"%@ element has more than two %@ elements.", [[self class] tagName], [class tagName]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
        }
    }
    
    if (required) {
        if (!firstElement) {
            NSString *description = [NSString stringWithFormat:@"%@ element require %@ element.", [[self class] tagName], [class tagName]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kKMLInvalidKMLFormatNotification
                                                                object:self
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, kKMLDescriptionKey, nil]];
        }
    }
    
    return firstElement;
}

- (void)childElementsOfClass:(Class)class xmlElement:(KMLXMLElement *)element eachBlock:(void (^)(KMLElement *element))eachBlock
{
    if ([[class tagName] hasPrefix:@"Abstract"]) {
        for (Class impl in [class implementClasses]) {
            [self childElementsOfClass:impl xmlElement:element eachBlock:eachBlock];
        }
    } else {
        KMLXMLElement *el = [KMLXML childElementNamed:[class tagName] parentElement:element];
        while (el != nil) {
            eachBlock([[class alloc] initWithXMLElement:el parent:self]);
            el = [KMLXML nextSiblingNamed:[class tagName] searchFromElement:el];
        }
    }
}


#pragma mark - KML

- (NSString *)kml {
    NSMutableString *kml = [NSMutableString stringWithString:@""];
    [self kml:kml indentationLevel:0];
    return kml;
}

- (void)kml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [self addOpenTagToKml:kml indentationLevel:indentationLevel];
    [self addChildTagToKml:kml indentationLevel:indentationLevel + 1];
    [self addCloseTagToKml:kml indentationLevel:indentationLevel];
}

- (void)addOpenTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [kml appendString:[NSString stringWithFormat:@"%@%<%@>\r\n"
                       , [self indentForIndentationLevel:indentationLevel]
                       , [[self class] tagName]
                       ]
     ];
}

- (void)addChildTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    // Override to subclasses
}

- (void)addCloseTagToKml:(NSMutableString *)kml indentationLevel:(NSInteger)indentationLevel
{
    [kml appendString:[NSString stringWithFormat:@"%@%</%@>\r\n"
                       , [self indentForIndentationLevel:indentationLevel]
                       , [[self class] tagName]
                       ]
     ];
}

- (void)kml:(NSMutableString *)kml addPropertyForValue:(NSString *)value tagName:(NSString *)tagName indentationLevel:(NSInteger)indentationLevel
{
    [self kml:kml addPropertyForValue:value defaultValue:nil tagName:tagName attribute:nil indentationLevel:indentationLevel];
}

- (void)kml:(NSMutableString *)kml addPropertyForValue:(NSString *)value tagName:(NSString *)tagName attribute:(NSString *)attribute indentationLevel:(NSInteger)indentationLevel
{
    [self kml:kml addPropertyForValue:value defaultValue:nil tagName:tagName attribute:attribute indentationLevel:indentationLevel];
}

- (void)kml:(NSMutableString *)kml addPropertyForValue:(NSString *)value defaultValue:(NSString *)defaultValue tagName:(NSString *)tagName indentationLevel:(NSInteger)indentationLevel
{
    [self kml:kml addPropertyForValue:value defaultValue:defaultValue tagName:tagName attribute:nil indentationLevel:indentationLevel];
}

- (void)kml:(NSMutableString *)kml addPropertyForValue:(NSString *)value defaultValue:(NSString *)defaultValue tagName:(NSString *)tagName attribute:(NSString *)attribute indentationLevel:(NSInteger)indentationLevel;
{
    if (!value || [value isEqualToString:@""]) {
        return;
    }

    if (defaultValue && [value isEqualToString:defaultValue]) {
        return;
    }
        
    BOOL outputCDMA = NO;
    NSRange match = [value rangeOfString:@"[^a-zA-Z0-9.,+-/*!='\"()\\[\\]{}!$%@?_;: #\t\r\n]" options:NSRegularExpressionSearch];
    if (match.location != NSNotFound) {
        outputCDMA = YES;
    }

    if (outputCDMA) {
        [kml appendString:[NSString stringWithFormat:@"%@<%@%@><![CDATA[%@]]></%@>\r\n"
                           , [self indentForIndentationLevel:indentationLevel]
                           , tagName
                           , attribute ? [@" " stringByAppendingString:attribute]: @""
                           , [value stringByReplacingOccurrencesOfString:@"]]>" withString:@"]]&gt;"]
                           , tagName]
         ];
    } else {
        [kml appendString:[NSString stringWithFormat:@"%@<%@%@>%@</%@>\r\n"
                           , [self indentForIndentationLevel:indentationLevel]
                           , tagName
                           , attribute ? [@" " stringByAppendingString:attribute]: @""
                           , value
                           , tagName]
         ];
    }
}

- (NSString *)indentForIndentationLevel:(NSInteger)indentationLevel
{
    NSMutableString *result = [NSMutableString string];
    
    for (int i = 0; i < indentationLevel; ++i) {
        [result appendString:@"\t"];
    }
    
    return result;
}

@end
