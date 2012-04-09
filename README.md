iOS KML Framework
============================

This is a iOS framework for parsing/generating KML files.
This Framework parses the KML from a URL or Strings and create Objective-C Instances of KML structure. 


How to build?
---------------------------------

1. Install the [iOS Universal Framework](https://github.com/kstenerud/iOS-Universal-Framework).

2. Open up the KML project (KML.xcodeproj) in Xcode 4.

3. Click Product > Build in the menu bar.


How to use framework in my project?
---------------------------------

Drag the framework file into the project's Frameworks group, and import the header file.

	#import <KML/KML.h>


To parsing the KML file, simply call the parse method :

	KMLRoot *root = [KMLParser parseKMLWithString:kml];


You can generate the KML :

    KMLRoot *root = [KMLRoot new];
    
    KMLDocument *doc = [KMLDocument new];
    root.feature = doc;
    
    KMLPlacemark *placemark = [KMLPlacemark new];
    placemark.name = @"Simple placemark";
    placemark.descriptionValue = @"Attached to the ground.";
    [doc addFeature:placemark];

    KMLPoint *point = [KMLPoint new];
    placemark.geometry = point;
    
    KMLCoordinate *coordinate = [KMLCoordinate new];
    coordinate.latitude = 37.422f;
    coordinate.longitude = -122.082f;
    point.coordinate = coordinate;


Acknowledgment
---------------------------------

[TBXML](http://tbxml.co.uk/TBXML/TBXML_Free.html) Copyright (c) 2009 Tom Bradley