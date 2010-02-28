//
//  DPNameServer.m
//  UITestingKit
//
//  Created by Ofri Wolfus on 27/01/07.
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

#import "DPNameServer.h"
#import <AppKit/AppKit.h>


@implementation DPNameServer

static inline void _DPUpdateNamesForObject(id obj) {
	[obj accessibilitySetOverrideValue:[(NSArray *)DPCopyNamesOfObject(obj) autorelease]
						  forAttribute:@"DPNames"];
}

+ (void)registerName:(NSString *)name withObject:(id)obj {
	DPRegisterNameWithObject((CFStringRef)name, obj);
	_DPUpdateNamesForObject(obj);
}

+ (void)unregisterName:(NSString *)name {
	id obj = [self objectNamed:name];
	DPUnregisterName((CFStringRef)name);
	_DPUpdateNamesForObject(obj);
}

+ (void)unregisterObject:(id)obj {
	DPUnregisterObject(obj);
	_DPUpdateNamesForObject(obj);
}

+ (NSArray *)namesOfObject:(id)obj {
	NSArray *a = (NSArray *)DPCopyNamesOfObject(obj);
	
	if ([a count])
		return [a autorelease];
	else {
		[a release];
		return nil;
	}
}

+ (id)objectNamed:(NSString *)name {
	return (id)DPGetObjectNamed((CFStringRef)name);
}

@end


#pragma mark -
#pragma mark CF Implementation
//======================================================//
//======================================================//
//============ CF NameServer Implementation ============//
//======================================================//
//======================================================//

// Our global namespace
static CFMutableDictionaryRef _namesTable = NULL;

// Set up _namesTable before main() is called
void __attribute__((constructor)) _DPSetUpNamesTable() {
	_namesTable = CFDictionaryCreateMutable(kCFAllocatorDefault, 0,
											&kCFTypeDictionaryKeyCallBacks, NULL);
}

void DPRegisterNameWithObject(CFStringRef name, void *obj) {
	CFDictionarySetValue(_namesTable, name, obj);
}

void DPUnregisterName(CFStringRef name) {
	CFDictionaryRemoveValue(_namesTable, name);
}

void DPUnregisterObject(void *obj) {
	CFArrayRef	names = DPCopyNamesOfObject(obj);
	CFIndex		i, count = CFArrayGetCount(names);
	
	for (i = 0U; i < count; i++) {
		const void *key = CFArrayGetValueAtIndex(names, i);
		
		if (key == obj)
			CFDictionaryRemoveValue(_namesTable, key);
	}
	
	CFRelease(names);
}

CFArrayRef DPCopyNamesOfObject(void *obj) {
	CFIndex i, count = CFDictionaryGetCount(_namesTable);
	CFStringRef *keys = calloc(count, sizeof(CFStringRef));
	void **objects = calloc(count, sizeof(void *));
	CFMutableArrayRef arr = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
	
	CFDictionaryGetKeysAndValues(_namesTable, (const void **)keys,
								 (const void **)objects);
	
	for (i = 0U; i < count; i++)
		if (objects[i] == obj)
			CFArrayAppendValue(arr, keys[i]);
	
	free(keys);
	free(objects);
	
	return arr;
}

const void *DPGetObjectNamed(CFStringRef name) {
	return CFDictionaryGetValue(_namesTable, name);
}


#ifdef DP_BUILDING_UITESTING_KIT

#pragma mark -
#pragma mark UITestingKit Additions
//======================================================//
//======================================================//
//=============== UITestingKit Additions ===============//
//======================================================//
//======================================================//

void DPNotifyTestingPreparedness(void) {
	// It's eaier to implement this in cocoa, but it requires carbon app to load
	// the objc runtime and the cocoa frameworks which is a bit of an overkill.
	// TODO: Implement this using CFBundle so it'll work for both cocoa and carbon.
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"DPApplicationFinishedLaunching"
																   object:[[[NSBundle mainBundle] executablePath] lastPathComponent]
																 userInfo:nil];
}

#endif
