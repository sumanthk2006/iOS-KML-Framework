// ================================================================================================
//  KMLXML.h
//  Fast processing of XML files
//
// ================================================================================================
//  Created by Tom Bradley on 21/10/2009.
//  Version 1.4
//  
//  Copyright (c) 2009 Tom Bradley
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
// ================================================================================================


#define MAX_ELEMENTS 100
#define MAX_ATTRIBUTES 100

#define KMLXML_ATTRIBUTE_NAME_START 0
#define KMLXML_ATTRIBUTE_NAME_END 1
#define KMLXML_ATTRIBUTE_VALUE_START 2
#define KMLXML_ATTRIBUTE_VALUE_END 3
#define KMLXML_ATTRIBUTE_CDATA_END 4

typedef struct _KMLXMLAttribute {
	char * name;
	char * value;
	struct _KMLXMLAttribute * next;
} KMLXMLAttribute;

typedef struct KMLXMLElement {
	char * name;
	char * text;
	
	KMLXMLAttribute * firstAttribute;
	
	struct KMLXMLElement * parentElement;
	
	struct KMLXMLElement * firstChild;
	struct KMLXMLElement * currentChild;
	
	struct KMLXMLElement * nextSibling;
	struct KMLXMLElement * previousSibling;
	
} KMLXMLElement;

typedef struct _KMLXMLElementBuffer {
	KMLXMLElement * elements;
	struct _KMLXMLElementBuffer * next;
	struct _KMLXMLElementBuffer * previous;
} KMLXMLElementBuffer;

typedef struct _KMLXMLAttributeBuffer {
	KMLXMLAttribute * attributes;
	struct _KMLXMLAttributeBuffer * next;
	struct _KMLXMLAttributeBuffer * previous;
} KMLXMLAttributeBuffer;


@interface KMLXML : NSObject {
	
@private
	KMLXMLElement * rootXMLElement;
	
	KMLXMLElementBuffer * currentElementBuffer;
	KMLXMLAttributeBuffer * currentAttributeBuffer;
	
	long currentElement;
	long currentAttribute;
	
	char * bytes;
	long bytesLength;
}

@property (nonatomic, readonly) KMLXMLElement * rootXMLElement;

+ (id)tbxmlWithURL:(NSURL*)aURL;
+ (id)tbxmlWithXMLString:(NSString*)aXMLString;
+ (id)tbxmlWithXMLData:(NSData*)aData;

- (id)initWithURL:(NSURL*)aURL;
- (id)initWithXMLString:(NSString*)aXMLString;
- (id)initWithXMLData:(NSData*)aData;

@end

@interface KMLXML (StaticFunctions)

+ (NSString*) elementName:(KMLXMLElement*)aXMLElement;
+ (NSString*) textForElement:(KMLXMLElement*)aXMLElement;
+ (NSString*) valueOfAttributeNamed:(NSString *)aName forElement:(KMLXMLElement*)aXMLElement;

+ (NSString*) attributeName:(KMLXMLAttribute*)aXMLAttribute;
+ (NSString*) attributeValue:(KMLXMLAttribute*)aXMLAttribute;

+ (KMLXMLElement*) nextSiblingNamed:(NSString*)aName searchFromElement:(KMLXMLElement*)aXMLElement;
+ (KMLXMLElement*) childElementNamed:(NSString*)aName parentElement:(KMLXMLElement*)aParentXMLElement;

@end
