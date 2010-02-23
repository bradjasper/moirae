//
//  DPUIElement.m
//  UITestingKit
//
//  Created by Ofri Wolfus on 24/01/07.
//  Copyright 2007 Ofri Wolfus. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//  
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  3. Neither the name of Ofri Wolfus nor the names of his contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
//  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "DPUIElement.h"
#import "DPUtilities.h"


@interface DPUIElement (Private)

- (id)_initWithAXElement:(AXUIElementRef)element;
- (void)invalidate;

@end

@implementation DPUIElement

static CFMutableDictionaryRef _existingElements = NULL;

const void *_DPAXRetain(CFAllocatorRef allocator,
						const void *value)
{
	return CFRetain((CFTypeRef)value);
}

void _DPAXRelease(CFAllocatorRef allocator,
						const void *value)
{
	CFRelease((CFTypeRef)value);
}


+ (void)initialize {
	CFDictionaryKeyCallBacks keyCallbacks = {
		0,					// version
		_DPAXRetain,		// retain
		_DPAXRelease,		// release
		CFCopyDescription,	// copy description
		CFEqual,			// equal
		CFHash				// hash
	};
	
	_existingElements = CFDictionaryCreateMutable(kCFAllocatorDefault, 0,
												  &keyCallbacks, NULL);
}

+ (BOOL)accessibilityAPIEnabled {
	return AXAPIEnabled();
}

+ (id)systemElement {
	return [[[self alloc] _initWithAXElement:AXUIElementCreateSystemWide()] autorelease];
}

+ (id)applicationElement:(pid_t)pid {
	return [[[self alloc] _initWithAXElement:AXUIElementCreateApplication(pid)] autorelease];
}

+ (id)elementAtPoint:(NSPoint)point ofApplication:(DPUIElement *)app {
	AXUIElementRef element = NULL;
	DPUIElement *e = nil;
	
	DPAXAssert(AXUIElementCopyElementAtPosition([app axElement], point.x,
												point.y, &element));
	if (element) {
		e = [[[DPUIElement alloc] _initWithAXElement:element] autorelease];
		CFRelease(element);
	}
	
	return e;
}

- (id)_initWithAXElement:(AXUIElementRef)element {
	if ((self = [super init])) {
		NSAssert(element != NULL, @"Can't create an element for NULL AX element.");
		DPUIElement *e = (id)CFDictionaryGetValue(_existingElements, element);
		
		if (e) {
			_element = NULL;
			[self release];
			self = [e retain];
		} else {
			_element = CFRetain(element);
			CFDictionarySetValue(_existingElements, _element, self);
		}
	}
	
	return self;
}

- (void)dealloc {
	// We might just get allocated and not initialized.
	// In that case just free our memory.
	if (_element) {
		CFDictionaryRemoveValue(_existingElements, _element);
		CFRelease(_element);
	}
	
	[super dealloc];
}

- (pid_t)pid {
	pid_t pid;
	
	DPAXAssert(AXUIElementGetPid([self axElement], &pid));
	return pid;
}

- (BOOL)isValid {
	CFTypeRef val;
	AXError err = AXUIElementCopyAttributeValue([self axElement], kAXRoleAttribute, &val);
	if (val) CFRelease(val);
	
	return err != kAXErrorInvalidUIElement;
}

- (AXUIElementRef)axElement {
	return _element;
}

- (unsigned)hash {
	return CFHash([self axElement]);
}

- (BOOL)isEqual:(id)anObject {
	return CFEqual([self axElement], [anObject axElement]);
}

- (BOOL)isEqualTo:(id)obj {
	return [self isEqual:obj];
}

- (NSString *)description {
	NSString *desc = [(NSString *)CFCopyDescription([self axElement]) autorelease];
	
	if ([self isValid])
		desc = [desc stringByAppendingFormat:@": %@ (%@)", [self valueForAttribute:(NSString *)kAXRoleAttribute],
			[self valueForAttribute:(NSString *)kAXRoleDescriptionAttribute]];
	
	return desc;
}
 
// ==============================================
// ==============================================
#pragma mark -
#pragma mark Attributes

- (NSArray *)attributeNames {
	NSArray *attr = nil;
	
	DPAXAssertIfValid(AXUIElementCopyAttributeNames([self axElement], (CFArrayRef*)&attr));
	
	return [attr autorelease];
}

- (id)valueForAttribute:(NSString *)attr {
	id val = nil;
	CFTypeID retType;
		
	if (DPAXAssertIfValid(AXUIElementCopyAttributeValue([self axElement],
														(CFStringRef)attr,
														(CFTypeRef*)&val))) {
		
		retType = CFGetTypeID((CFTypeRef)val);
		
		// Transform any AXUIElementRef to a DPUIElement instance
		if (retType == AXUIElementGetTypeID()) {
			AXUIElementRef e = (AXUIElementRef)val;
			
			val = [[DPUIElement alloc] _initWithAXElement:e];
			// Must release the result of a copy operation
			CFRelease(e);
			
			// We might as well receive an array containing UIElements
			// which is not that useful for us.
		} else if (retType == CFArrayGetTypeID()) {
			unsigned i, count = [val count];
			NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:count];
			
			// Can't use an enumerator as it doesn't guarentee to be ordered
			// (although in practice it is).
			for (i = 0U; i < count; i++) {
				CFTypeRef t = CFArrayGetValueAtIndex((CFArrayRef)val, i);
				id obj = (id)t;
				
				// Replace AXUIElements with DPUIElements
				if (CFGetTypeID(t) == AXUIElementGetTypeID())
					obj = [[[DPUIElement alloc] _initWithAXElement:t] autorelease];
				
				[result addObject:obj];
			}
			
			[val release]; val = result;
		} else if (retType == AXValueGetTypeID()) {
			NSValue *v = [DPNSValueFromAXValue((AXValueRef)val) retain];;
			CFRelease(val); val = v;
		} else if (retType == CFNullGetTypeID()) {
			CFRelease(val);
			val = [[NSNull null] retain];
		} else if (retType == CFBooleanGetTypeID()) {
			NSNumber *n = [[NSNumber numberWithBool:CFBooleanGetValue((CFBooleanRef)val)] retain];
			CFRelease(val); val = n;
		}
	}
	
	return [val autorelease];	// Always autorelease as the value is being copied to us
}

- (long)valueCountForAttribute:(NSString *)attr {
	CFIndex c;
	
	DPAXAssert(AXUIElementGetAttributeValueCount([self axElement],
												 (CFStringRef)attr,
												 &c));
	return c;
}

- (BOOL)attributeIsSettable:(NSString *)attr {
	Boolean val = FALSE;
	
	DPAXAssertIfValid(AXUIElementIsAttributeSettable([self axElement],
													 (CFStringRef)attr,
													 &val));
	return (BOOL)val;
}

- (void)setValue:(id)val forAttribute:(NSString *)attr {
	CFTypeRef obj = NULL;
	
	// BOOL should be translated to CFBooleanRef
	// NOTE: NSNumber is a NSValue subclass so we must check for it first.
	// If we don't, we'll just mess everything up.
	if ([val isKindOfClass:[NSNumber class]]) {
		if (strcmp([val objCType], @encode(BOOL)) == 0)
			obj = [val boolValue] ? kCFBooleanTrue : kCFBooleanFalse;
	
		// If our value is an NSValue instance, we'll pack its
		// content in a AXValue.
	} else if ([val isKindOfClass:[NSValue class]]) {
		const char *type = [val objCType];
		
		// NSPoint
		if (strcmp(type, @encode(NSPoint)) == 0) {
			NSPoint v = [val pointValue];
			obj = AXValueCreate(kAXValueCGPointType, (const void *)&v);
			
		// NSSize
		} else if (strcmp(type, @encode(NSSize)) == 0) {
			NSSize v = [val sizeValue];
			obj = AXValueCreate(kAXValueCGSizeType, (const void *)&v);
			
		// NSRect
		} else if (strcmp(type, @encode(NSRect)) == 0) {
			NSRect v = [val rectValue];
			obj = AXValueCreate(kAXValueCGRectType, (const void *)&v);
			
		// NSRange
		} else if (strcmp(type, @encode(NSRange)) == 0) {
			NSRange v = [val rangeValue];
			obj = AXValueCreate(kAXValueCFRangeType, (const void *)&v);
		
		// If none of the above matches, we'll assume our value
		// contains a non-retained object (that is, some CFType).
		} else {
			obj = [val nonretainedObjectValue];
		}
		
		// NSNull -> CFNull
	} else if ([val isKindOfClass:[NSNull class]]) {
		obj = kCFNull;
		
		// If we got an array, we'll scan its content for DPUIElements
		// and replace each of them with their matching AXElements.
	} else if ([val isKindOfClass:[NSArray class]]) {
		unsigned i, count = [val count];
		NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:count];
		id o;
		
		for (i = 0U; i < count; i++) {
			o = [val objectAtIndex:i];
			
			if ([o isKindOfClass:[DPUIElement class]])
				o = (id)[o axElement];
			
			// Adding CFTypes to NSArray is the same as adding them to CFArray
			// TFB FTW! :)
			//[arr addObject:o];
			CFArrayAppendValue((CFMutableArrayRef)arr, o);
		}
		
		obj = arr;
	} else {
		obj = CFRetain((CFTypeRef)val);
	}
	
	DPAXAssert(AXUIElementSetAttributeValue([self axElement],
											(CFStringRef)attr, obj));
	
	// Clean up
	CFRelease(obj);
}

// ==============================================
// ==============================================
#pragma mark -
#pragma mark Actions

- (NSArray *)actionNames {
	NSArray *arr = nil;
	
	DPAXAssertIfValid(AXUIElementCopyActionNames([self axElement], (CFArrayRef*)&arr));
	
	return [arr autorelease];
}

- (NSString *)descriptionOfAction:(NSString *)action {
	NSString *str = nil;
	
	DPAXAssertIfValid(AXUIElementCopyActionDescription([self axElement],
													(CFStringRef)action,
													(CFStringRef*)&str));
	return [str autorelease];
}

- (NSError *)performAction:(NSString *)action {
	AXError err = AXUIElementPerformAction([self axElement], (CFStringRef)action);
	
	if (err != kAXErrorSuccess)
		return [NSError errorWithDomain:DPAccessibilityErrorDomain
								   code:err
							   userInfo:nil];
	
	return nil;
}



@end


@implementation DPUIElement (Additions)

+ (id)applicationWithIdentifier:(NSString *)bundleID {
	pid_t pid;
	
	DPAssert(DPGetPIDOfProcess(bundleID, &pid), @"No process found for %@", bundleID);
	return [self applicationElement:pid];
}

- (id)valueForAttributeIfAvailable:(NSString *)attr {
	return [self isValid] && [[self attributeNames] containsObject:attr] ?
			[self valueForAttribute:attr] : nil;
}

- (NSArray *)names {
	return [self valueForAttributeIfAvailable:@"DPNames"];
}

- (NSString *)role {
	return [self valueForAttribute:NSAccessibilityRoleAttribute];
}

- (NSString *)subrole {
	return [self valueForAttributeIfAvailable:NSAccessibilitySubroleAttribute];
}

- (DPUIElement *)childNamed:(NSString *)name {
	NSEnumerator *enumerator = [[self children] objectEnumerator];
	DPUIElement *element;
	
	while ((element = [enumerator nextObject])) {
		NSArray *names = [element names];
		if (names && [names containsObject:name])
			return element;
	}
	
	return nil;
}

- (DPUIElement *)anyChildNamed:(NSString *)name {
	NSEnumerator *enumerator = [[self children] objectEnumerator];
	DPUIElement *element;
	
	// This is really inefficient if you know where the child you're
	// looking for is located.
	while ((element = [enumerator nextObject])) {
		NSArray *names = [element names];
		DPUIElement *e = names && [names containsObject:name]
			? element : [element anyChildNamed:name];
		
		if (e)
			return e;
	}
	
	return nil;
}

- (DPUIElement *)application {
	return [DPUIElement applicationElement:[self pid]];
}

// ==============================================
// ==============================================
#pragma mark -
#pragma mark Relationships

- (DPUIElement *)parent {
	return [self valueForAttributeIfAvailable:(NSString *)kAXParentAttribute];
}

- (NSArray *)children {
	return [self valueForAttributeIfAvailable:(NSString *)kAXChildrenAttribute];
}

- (NSArray *)selectedChildren {
	return [self valueForAttributeIfAvailable:(NSString *)kAXSelectedChildrenAttribute];
}

- (NSArray *)visibleChildren {
	return [self valueForAttributeIfAvailable:(NSString *)kAXVisibleChildrenAttribute];
}

@end


NSValue *DPNSValueFromAXValue(AXValueRef val) {
	NSValue *result = nil;
	
	/*
	 * NOTE: All possible types of AXValue are CG types,
	 * but they are defined the same as their NS equivalent
	 * so we're safe. And besides, there's no real way to
	 * convert between the two.
	 */
	switch (AXValueGetType(val)) {
		// CGPoint
		case kAXValueCGPointType: {
			NSPoint x;
			AXValueGetValue(val, kAXValueCGPointType, &x);
			result = [NSValue valueWithPoint:x];
		}
			
		// CGSize
		case kAXValueCGSizeType: {
			NSSize x;
			AXValueGetValue(val, kAXValueCGSizeType, &x);
			result = [NSValue valueWithSize:x];
		}
			
		// CGRect
		case kAXValueCGRectType: {
			NSRect x;
			AXValueGetValue(val, kAXValueCGRectType, &x);
			result = [NSValue valueWithRect:x];
		}
			
		// CGRange
		case kAXValueCFRangeType: {
			NSRange x;
			AXValueGetValue(val, kAXValueCFRangeType, &x);
			result = [NSValue valueWithRange:x];
		}
	}
	
	return result;
}

AXValueRef DPAXValueFromNSValue(NSValue *val) {
	AXValueRef result = NULL;
	const char *type = [val objCType];
	
		// NSPoint
	if (strcmp(type, @encode(NSPoint)) == 0) {
		NSPoint v = [val pointValue];
		result = AXValueCreate(kAXValueCGPointType, (const void *)&v);
		
		// NSSize
	} else if (strcmp(type, @encode(NSSize)) == 0) {
		NSSize v = [val sizeValue];
		result = AXValueCreate(kAXValueCGSizeType, (const void *)&v);
		
		// NSRect
	} else if (strcmp(type, @encode(NSRect)) == 0) {
		NSRect v = [val rectValue];
		result = AXValueCreate(kAXValueCGRectType, (const void *)&v);
		
		// NSRange
	} else if (strcmp(type, @encode(NSRange)) == 0) {
		NSRange v = [val rangeValue];
		result = AXValueCreate(kAXValueCFRangeType, (const void *)&v);
		
		// Illegal type
	} else {
		result = AXValueCreate(kAXValueIllegalType, NULL);
	}
	
	return result;
}


NSString * const DPAccessibilityException = @"DPAccessibilityException";
NSString * const DPAccessibilityErrorDomain = @"DPAccessibilityErrorDomain";

NSString * DPAXErrorName(AXError err) {
	
	switch (err) {
		case kAXErrorFailure:
			return @"AXErrorFailure";
			
		case kAXErrorIllegalArgument:
			return @"AXErrorIllegalArgument";
			
		case kAXErrorInvalidUIElement:
			return @"AXErrorInvalidUIElement";
			
		case kAXErrorInvalidUIElementObserver:
			return @"AXErrorInvalidUIElementObserver";
			
		case kAXErrorCannotComplete:
			return @"AXErrorCannotComplete";
			
		case kAXErrorAttributeUnsupported:
			return @"AXErrorAttributeUnsupported";
			
		case kAXErrorActionUnsupported:
			return @"AXErrorActionUnsupported";
			
		case kAXErrorNotificationUnsupported:
			return @"AXErrorNotificationUnsupported";
			
		case kAXErrorNotImplemented:
			return @"AXErrorNotImplemented";
			
		case kAXErrorNotificationAlreadyRegistered:
			return @"AXErrorNotificationAlreadyRegistered";
			
		case kAXErrorNotificationNotRegistered:
			return @"AXErrorNotificationNotRegistered";
			
		case kAXErrorAPIDisabled:
			return @"AXErrorAPIDisabled";
			
		case kAXErrorNoValue:
			return @"AXErrorNoValue";
			
		case kAXErrorParameterizedAttributeUnsupported:
			return @"AXErrorParameterizedAttributeUnsupported";
			
		default:
			return nil;
	}
}
