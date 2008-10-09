//
//  DPAccessibilityNotificationCenter.m
//  UITestingKit
//
//  Created by Ofri Wolfus on 29/01/07.
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

#import "DPAccessibilityNotificationCenter.h"
#import "DPUIElement-Private.h"

#ifdef DP_BUILDING_UITESTING_KIT
#import "DPTestCase.h"	// For DPTestSubject
#endif


@interface DPAccessibilityNotificationCenter (private)
- (void)_processAXNotification:(NSNotification *)notif;
@end

@implementation DPAccessibilityNotificationCenter

static DPAccessibilityNotificationCenter *_defaultCenter = nil;

+ (id)defaultCenter {
	if (!_defaultCenter)
		_defaultCenter = [[self alloc] init];
	
	return _defaultCenter;
}

void _DPPIDRelease(CFAllocatorRef allocator, const void *pid) {
	free((void *)pid);
}

Boolean _DPPIDEqual(const void *pid1, const void *pid2) {
	return *((pid_t *)pid1) == *((pid_t *)pid2);
}

CFHashCode _DPPIDHash(const void *pid) {
	return *((pid_t *)pid);
}

- (id)init {
	if (!_defaultCenter && (self = [super init])) {
		CFDictionaryKeyCallBacks keyCall = {
			0,				// version
			NULL,			// retain
			_DPPIDRelease,	// release
			NULL,			// copyDescriptions
			_DPPIDEqual,	// equal
			_DPPIDHash		// hash
		};
		
		// We hold a real notification center that'll handle the actual deivering of
		// notifications.
		// For some reason calling super's implementation doesn't work so this is the
		// simplest option for now.
		nc = [[NSNotificationCenter allocWithZone:[self zone]] init];
		
		// This dictionary holds pointers to pid_t as keys where
		// each pid has a matching AXObserver.
		// Each observer listens to _ALL_ notifications from the remote app
		// and redirects them to the right (local) observers.
		_axObservers = CFDictionaryCreateMutable(kCFAllocatorDefault, 0,
												 &keyCall, &kCFTypeDictionaryValueCallBacks);
		
		_defaultCenter = [self retain];
	} else {
		[self release];
	}
	
	return [_defaultCenter retain];
}

void _DPAXObserverCallback(AXObserverRef observer, AXUIElementRef element,
						   CFStringRef notification, void *refcon)
{
	NSString		*name = (NSString *)notification;
	DPUIElement		*e = [[[DPUIElement alloc] _initWithAXElement:element] autorelease];
	NSNotification	*notif = [NSNotification notificationWithName:name
														   object:e];
	
	[(DPAccessibilityNotificationCenter *)refcon _processAXNotification:notif];
}

- (void)_processAXNotification:(NSNotification *)notif {
	[nc postNotification:notif];
}

- (void)addObserver:(id)observer
		   selector:(SEL)sel
			   name:(NSString *)name
			 object:(DPUIElement *)sender
{
	pid_t pid;
	AXObserverRef axObs;
	AXError err;
	
	// UITestingKit addition
#ifdef DP_BUILDING_UITESTING_KIT
	// If no sender is provided, we'll use our test subject
	// as the sender.
	if (!sender)
		sender = DPTestSubject;
#endif
	
	// If no sender was provided, assume system wide element
	if (!sender)
		sender = [DPUIElement systemElement];
	
	pid = [sender pid];
	axObs = (AXObserverRef)CFDictionaryGetValue(_axObservers, &pid);
	
	if (!axObs) {
		pid_t *p = malloc(sizeof(pid_t));
		NSRunLoop *rl = [NSRunLoop currentRunLoop];
		
		// Save this AXObserver
		*p = pid;
		DPAXAssert(AXObserverCreate(pid, _DPAXObserverCallback, &axObs));
		CFDictionaryAddValue(_axObservers, (const void *)p, axObs);
		CFRelease(axObs);
		
		// And add it to the current run loop
		CFRunLoopAddSource([rl getCFRunLoop],
						   AXObserverGetRunLoopSource(axObs),
						   // Use the current mode (if found) or the default one
						   (CFStringRef)([rl currentMode] ?: NSDefaultRunLoopMode));
	}
	
	// Listen to AX notifications
	err = AXObserverAddNotification(axObs, [sender axElement],
									(CFStringRef)name, self);
	
	// Ignore already registered notifications as we use only
	// one AXObserver per notification and not per observer.
	if (err != kAXErrorNotificationAlreadyRegistered)
		DPAXAssert(err);
	
	// Let NSNotificationCenter manage the observers
	[nc addObserver:observer
			  selector:sel
				  name:name
				object:sender];
}

- (void)postNotificationName:(NSString *)name
					  object:(id)sender
					userInfo:(NSDictionary *)info
{
	// NOTE: The sender must be the actual UI object and NOT
	// a DPUIElement instance!
	NSAccessibilityPostNotification(sender, name);
}

- (void)postNotification:(NSNotification *)notif {
	// NOTE: The sender must be the actual UI object and NOT
	// a DPUIElement instance!
	NSAccessibilityPostNotification([notif object], [notif name]);
}

- (void)removeObserver:(id)observer name:(NSString *)name object:(DPUIElement *)sender {
	// NOTE: We still listen to notifications with the passed name
	// but just don't pass them to this observer.
	// Is there any point in actually stopping listening when no
	// observers are registered?
	[nc removeObserver:observer
					 name:name
				   object:sender];
}

@end
