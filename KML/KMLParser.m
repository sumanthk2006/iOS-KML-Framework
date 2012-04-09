//
//  KMLParser.m
//  KML Framework
//
//  Created by NextBusinessSystem on 12/04/06.
//  Copyright (c) 2012 NextBusinessSystem Co., Ltd. All rights reserved.
//

#import "KMLParser.h"
#import "KMLConst.h"
#import "KMLElementSubclass.h"
#import "KMLRoot.h"
#import "KMLAbstractContainer.h"
#import "KMLPlacemark.h"

@implementation KMLParser


#pragma mark - Instance

+ (KMLRoot *)parseKMLAtURL:(NSURL *)url
{
    KMLXML *xml = [[KMLXML alloc] initWithURL:url];
    if (xml.rootXMLElement) {
        return [[KMLRoot alloc] initWithXMLElement:xml.rootXMLElement parent:nil];
    }

    return nil;
}

+ (KMLRoot *)parseKMLAtPath:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    return [KMLParser parseKMLAtURL:url];
}

+ (KMLRoot *)parseKMLWithString:(NSString*)string
{
    KMLXML *xml = [[KMLXML alloc] initWithXMLString:string];
    if (xml.rootXMLElement) {
        return [[KMLRoot alloc] initWithXMLElement:xml.rootXMLElement parent:nil];
    }
    
    return nil;
}

+ (KMLRoot *)parseKMLWithData:(NSData*)data
{
    KMLXML *xml = [[KMLXML alloc] initWithXMLData:data];
    if (xml.rootXMLElement) {
        return [[KMLRoot alloc] initWithXMLElement:xml.rootXMLElement parent:nil];
    }
    
    return nil;
}

@end
