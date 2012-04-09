//
//  KMLTests.m
//  KMLTests
//
//  Created by 俊紀 渡辺 on 12/04/06.
//  Copyright (c) 2012年 _MyCompanyName_. All rights reserved.
//

#import "KMLTests.h"
#import "KML.h"

@implementation KMLTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testKML
{
    NSString *path = [[NSBundle bundleForClass:[KMLParser class]] pathForResource:@"KML_Samples" ofType:@"kml"];
    
    KMLRoot *root = [KMLParser parseKMLAtPath:path];
    
    // kml
    STAssertNotNil(root, nil);

    // kml > document
    STAssertTrue([root.feature isKindOfClass:[KMLDocument class]], nil);
    KMLDocument *document = (KMLDocument *)root.feature;
    STAssertEqualObjects(document.name, @"KML Samples", nil);
    STAssertEqualObjects(document.descriptionValue, @"Unleash your creativity with the help of these examples!", nil);
    
    // kml > All placemarks
    STAssertEquals(root.placemarks.count, 20U, nil);
    
    KMLPlacemark *placemark;
    KMLCoordinate *coordinate;

    // placemark
    placemark = [root.placemarks objectAtIndex:0];
    STAssertEqualObjects(placemark.name, @"Simple placemark", nil);
    STAssertEqualObjects(placemark.descriptionValue, @"Attached to the ground. Intelligently places itself at the\n          height of the underlying terrain.", nil);
    STAssertTrue([placemark.geometry isKindOfClass:[KMLPoint class]], nil);
    STAssertEquals(((KMLPoint *)placemark.geometry).coordinate.latitude, 37.42228990140251f, nil);
    STAssertEquals(((KMLPoint *)placemark.geometry).coordinate.longitude, -122.0822035425683f, nil);

    placemark = [root.placemarks objectAtIndex:2];
    STAssertEqualObjects(placemark.name, @"Extruded placemark", nil);
    STAssertEqualObjects(placemark.descriptionValue, @"Tethered to the ground by a customizable\n          &quot;tail&quot;", nil);
    STAssertTrue([placemark.geometry isKindOfClass:[KMLPoint class]], nil);
    STAssertEquals(((KMLPoint *)placemark.geometry).coordinate.latitude, 37.42156927867553f, nil);
    STAssertEquals(((KMLPoint *)placemark.geometry).coordinate.longitude, -122.0857667006183f, nil);

    // line
    placemark = [root.placemarks objectAtIndex:10];
    STAssertEqualObjects(placemark.name, @"Relative Extruded", nil);
    STAssertEqualObjects(placemark.descriptionValue, @"Opaque blue walls with red outline, height tracks terrain", nil);
    STAssertTrue([placemark.geometry isKindOfClass:[KMLLineString class]], nil);
    KMLLineString *linestring = (KMLLineString *)placemark.geometry;
    STAssertEquals(linestring.coordinates.count, 11U,nil);
    coordinate = [linestring.coordinates objectAtIndex:0];
    STAssertEquals(coordinate.latitude, 36.09445214722695f, nil);
    STAssertEquals(coordinate.longitude, -112.2656634181359f, nil);
    coordinate = [linestring.coordinates objectAtIndex:4];
    STAssertEquals(coordinate.latitude, 36.09679275951239f, nil);
    STAssertEquals(coordinate.longitude, -112.2635746835406f, nil);
    coordinate = [linestring.coordinates objectAtIndex:10];
    STAssertEquals(coordinate.latitude, 36.10149062823369f, nil);
    STAssertEquals(coordinate.longitude, -112.2626894973474f, nil);

    // polygon
    placemark = [root.placemarks objectAtIndex:19];
    STAssertEqualObjects(placemark.name, @"Relative Extruded", nil);
    STAssertTrue([placemark.geometry isKindOfClass:[KMLPolygon class]], nil);
    KMLPolygon *polygon = (KMLPolygon *)placemark.geometry;
    STAssertNotNil(polygon.outerBoundaryIs, nil);
    STAssertEquals(polygon.outerBoundaryIs.coordinates.count, 9U,nil);
    coordinate = [polygon.outerBoundaryIs.coordinates objectAtIndex:0];
    STAssertEquals(coordinate.latitude, 36.1514008468736f, nil);
    STAssertEquals(coordinate.longitude, -112.3348783983763f, nil);
    coordinate = [polygon.outerBoundaryIs.coordinates objectAtIndex:4];
    STAssertEquals(coordinate.latitude, 36.1489624162954f, nil);
    STAssertEquals(coordinate.longitude, -112.3358353861232f, nil);
    coordinate = [polygon.outerBoundaryIs.coordinates objectAtIndex:8];
    STAssertEquals(coordinate.latitude, 36.1514008468736f, nil);
    STAssertEquals(coordinate.longitude, -112.3348783983763f, nil);
}

@end
