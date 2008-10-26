//
//  DPUIElement.h
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

#import <Cocoa/Cocoa.h>
#include <ApplicationServices/ApplicationServices.h>

#ifdef DP_BUILDING_UITESTING_KIT
#import <UITestingKit/DPUtilities.h>
#else
#import "DPUtilities.h"
#endif


/*!
 * @abstract A class representing a UI element.
 * @discussion DPUIElement is analogous to AXUIElementRef.
 */
@interface DPUIElement : NSObject {
	AXUIElementRef _element;
}

/*!
 * @abstract Returns whether the accessibility API is enabled or not.
 * @discussion If the API is not enabled, the first call to a UIElement
 * will throw an exception.
 * Enabling the API is done via the Universal Access pref pane.
 */
+ (BOOL)accessibilityAPIEnabled;

/*!
 * @abstract Returns the system wide element to which all application
 * elements belong.
 */
+ (id)systemElement;

/*!
 * @abstract Returns the element of a given application.
 * @discussion An application element (an instance of DPUIElement)
 * represents the entire UI of a given application.
 */
+ (id)applicationElement:(pid_t)pid;

/*!
 * @abstract Returns the element belonging to <code>app</code> that is
 * positioned at <code>point</code>.
 *
 * @discussion If the system-wide element is passed as the application argument,
 * the position test is not restricted to a particular application;
 * the returned UIElement comes from whichever application is frontmost at
 * the specified location.
 *
 * @param point The position of the element in top-left relative screen coordinates.
 */
+ (id)elementAtPoint:(NSPoint)point ofApplication:(DPUIElement *)app;

/*!
 * @abstract Returns the available attributes of the receiver.
 */
- (NSArray *)attributeNames;

/*!
 * @abstract Returns the value of a given attribute.
 * @discussion Possible return types are: NSString, NSNumber, NSAttributedString,
 * NSValue, NSNull, NSURL, DPUIElement and <code>nil</code> if the receiver is invalid.
 *
 * The mapping of the original CFTypes to ObjC objects is as follows:
 * CFString -> NSString
 * CFNumber -> NSNumber
 * CFBoolean -> NSNumber with BOOL value
 * CFAttributedString -> NSAttributedString
 * AXValue -> NSValue
 * CFNull -> NSNull
 * CFURL -> NSURL
 * AXUIElement -> DPUIElement
 */
- (id)valueForAttribute:(NSString *)attr;

/*!
 * @abstract Returns the size of the array value of the given attribute.
 * @discussion If the attribute's value is not an array, or the receiver
 * is not valid, an exception will be raised.
 */
- (long)valueCountForAttribute:(NSString *)attr;

/*!
 * @abstract Returns whether a given attribute is settable or not.
 */
- (BOOL)attributeIsSettable:(NSString *)attr;

/*!
 * @abstract Sets the value of a given attribute.
 * @discussion If the attribute is not settable, or the receiver
 * is not valid, an exception will be thrown.
 *
 * Supported values are NSString, NSNumber, NSAttributedString,
 * NSValue, NSNull, NSURL, NSArray and DPUIElement.
 *
 * Note: When passing an NSNumber with <code>BOOL</code> value it'll be translated
 * to CFBooleanRef.
 */
- (void)setValue:(id)val forAttribute:(NSString *)attr;


/*!
 * @abstract Returns the actions the receiver understands.
 * @discussion Returns <code>nil</code> if the receiver is not valid.
 */
- (NSArray *)actionNames;

/*!
 * @abstract Returns a localized description of <code>action</code>
 * @discussion Returns <code>nil</code> if the receiver is not valid.
 */
- (NSString *)descriptionOfAction:(NSString *)action;

/*!
 * @abstract Requests the receiver to perform <code>action</code>.
 * @discussion Returns an NSError instance if an error occurs and
 * <code>nil</code> on success.
 */
- (NSError *)performAction:(NSString *)action;


/*!
 * @abstract Returns the process ID of the application that contains the receiver.
 */
- (pid_t)pid;

/*!
 * @abstract Returns whether the receiver is valid or not.
 */
- (BOOL)isValid;


/*!
 * @abstract Returns the underlying AXUIElementRef object powering the receiver.
 */
- (AXUIElementRef)axElement;

@end

@interface DPUIElement (Additions)

/*!
 * @abstract Returns an application element of a given application.
 * @discussion The provided bundle identifier must have a matching running
 * process, or an NSInternalInconsistencyException exception will be thrown.
 */
+ (id)applicationWithIdentifier:(NSString *)bundleID;

/*!
 * @abstract Returns the value of a given attribute.
 * @discussion This method works the same as <code>valueOfAttribute:</code>
 * except it doesn't thorw an exception if the receiver has no value for the
 * passed attribute. If no value is available, or if the receiver is invalid,
 * <code>nil</code> will be returned.
 */
- (id)valueForAttributeIfAvailable:(NSString *)attr;


/*!
 * @abstract Returns the parent element of the receiver in the visual element hierarchy.
 *
 * @discussion A push button's parent might be a window element or a group.
 * A sheet's parent will be a window element. A window's parent will be the
 * application element. A menu item's parent will be a menu element.
 */
- (DPUIElement *)parent;

/*!
 * @abstract Returns the sub elements of the receiver in the visual element hierarchy.
 *
 * @discussion A tab group's children is an array of tab radio button elements.
 * A window's children is an array of the first-order views elements within the window.
 * A menu's children is an array of the menu item elements.
 */
- (NSArray *)children;

/*!
 * @abstract Returns the selected sub elements of the receiver in the visual element hierarchy.
 *
 * @discussion This is a the subset of the element's children that are selected. This is
 * commonly used in lists so an assistive app can know which list item are selected.
 */
- (NSArray *)selectedChildren;

/*!
 * @abstract Returns the visible sub elements of the receiver in the visual element hierarchy.
 *
 * @discussion This is a the subset of the element's children that a sighted user can
 * see on the screen. In a list element, the result would be an array of child elements
 * that are currently scrolled into view.
 */
- (NSArray *)visibleChildren;

/*!
 * @abstract Returns the role identifying the basic type of an element.
 *
 * @result An NSString instance of one of the role strings defined in NSAccessibility.h,
 * or a new role string of your own invention. The string should not be localized, and it
 * does not need to be human-readable. Instead of inventing new role strings, see if a custom
 * element can be identified by an existing role string and a new subrole.
 */
- (NSString *)role;

/*!
 * @abstract Returns a role that more specifically identifies the type of an element beyond
 * the basic type provided by the <code>role</code> method.
 *
 * @discussion An example element that offers a subrole is a window's close box.
 * Its role value is NSButtonRole and its subrole is NSCloseButtonSubrole.
 * It is of role NSButtonRole because it offers no additional actions or attributes above
 * and beyond what other NSButtonRole elements provide; it was given a subrole in order to
 * allow an assistive app to communicate the close box's semantic difference to the user.
 */
- (NSString *)subrole;


/*!
 * @abstract Returns the names registered with the receiver
 * in the remote application.
 *
 * @discussion These names are registered with DPNameServer.
 * See DPNameServer.h for more information.
 */
- (NSArray *)names;

/*!
 * @abstract Returns a direct child element of the receiver with
 * the corresponding name.
 */
- (DPUIElement *)childNamed:(NSString *)name;

/*!
 * @abstract Returns a  child element of the receiver with
 * the corresponding name.
 *
 * @discussion Unlike @link childNamed:, this method scans
 * all children of every children, and therefor traverses the
 * entire element hierarchy.
 * Use this method when you need to find a child element you
 * don't know its location. If you do know the location of the
 * child you're looking, the use of @link childNamed: is much more efficient.
 */
- (DPUIElement *)anyChildNamed:(NSString *)name;

/*!
 * @abstract Returns the application element of the receiver.
 */
- (DPUIElement *)application;

@end


DP_EXTERN NSValue *DPNSValueFromAXValue(AXValueRef val);
DP_EXTERN AXValueRef DPAXValueFromNSValue(NSValue *val);


// Returns a string corresponding to the given AXError.
DP_EXTERN NSString * DPAXErrorName(AXError err);

// The name of the exception thrown upon a failure in one
// of DPUIElement's methods.
DP_EXTERN NSString * const DPAccessibilityException;
// The error domain for accessibility errors.
DP_EXTERN NSString * const DPAccessibilityErrorDomain;

// An assertation macro used to wrap AX functions.
// Upon a failure an exception is raised.
#define DPAXAssert(err) do { \
	if (err != kAXErrorSuccess) \
		[[NSException exceptionWithName:DPAccessibilityException\
								 reason:[NSString stringWithFormat:@"%@ in %@ of %@", \
											DPAXErrorName(err), DPGetMethodName(), self]\
							   userInfo:nil] raise];\
	} while (0)



DP_STATIC_INLINE BOOL _DPAXAssertIfValid(AXError err, NSString *methName, id self) {
	BOOL b = err == kAXErrorSuccess;
	
	if (!b && err != kAXErrorInvalidUIElement &&
		err != kAXErrorInvalidUIElementObserver && err != kAXErrorNoValue)
		
		[[NSException exceptionWithName:DPAccessibilityException
								 reason:[NSString stringWithFormat:@"%@ in %@ of %@",
									 DPAXErrorName(err), methName, self]
							   userInfo:nil] raise];
	
	return b;
}

// Upon success, returns YES.
// On failure, throws an exception if an error had occured.
// If failed due to the object being invalid, NO is returned.
#define DPAXAssertIfValid(err) _DPAXAssertIfValid(err, DPGetMethodName(), self)
