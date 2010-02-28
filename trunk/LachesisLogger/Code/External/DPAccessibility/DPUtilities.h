//
//  DPUtilities.h
//  UITestingKit
//
//  Created by Ofri Wolfus on 30/01/07.
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

#ifndef DP_EXTERN
#define DP_EXTERN	extern
#endif

#if !defined(DP_STATIC_INLINE)
#if defined (__GNUC__) && (__GNUC__ == 4)
#define DP_STATIC_INLINE static __inline__ __attribute__((always_inline))
#else
#define DP_STATIC_INLINE static __inline__
#endif
#endif

#import <Foundation/Foundation.h>
#include <objc/objc-class.h>

#if OBJC_API_VERSION < 2
#define class_isMetaClass(cls) ((((Class)cls)->info & CLS_META) != 0)
#endif

#define class_isClass(cls)			class_isMetaClass(cls->isa)
#define object_isInstance(obj)		class_isClass(obj->isa)

#define DPGetMethodName() [NSString stringWithFormat:@"%@[%@ %@]", \
					 object_isInstance(self) ? @"-" : @"+", [self className], NSStringFromSelector(_cmd)]


@class NSAssertionHandler;

/* Asserts for Objective-C that accepts unlimited number of arguments */
#if !defined(NS_BLOCK_ASSERTIONS)

#if !defined(DPAssert)
/*
 * The usage of this macro is the same as with NSAssert, exept you don't need DPAssert1, DPAssert2, etc.
 * This macro accepts any number of arguments passed to the description.
 */
#define DPAssert(condition, desc...)\
do {\
	if (!(condition)) {\
		[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd\
															object:self\
															  file:[NSString stringWithUTF8String:__FILE__] \
														lineNumber:__LINE__\
													   description:desc];\
	}\
} while(0)
#endif

#if !defined(DPCAssert)
/*
 * The usage of this macro is the same as with NSAssert, exept you don't need DPAssert1, DPAssert2, etc.
 * This macro accepts any number of arguments passed to the description.
 */
#define DPCAssert(condition, desc...)\
do {\
	if (!(condition)) {\
		[[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__]\
																file:[NSString stringWithUTF8String:__FILE__] \
														  lineNumber:__LINE__\
														 description:desc];\
	}\
} while(0)
#endif

#endif	// !defined(NS_BLOCK_ASSERTIONS)


/*!
 * @abstract Sets up an autorelease pool that's automatically released
 * and recreated at each entry of the current runloop.
 * @discussion The autorelease pool is added to the current runloop in
 * <code>runLoopMode</code>. If <code>runLoopMode</code> is <code>nil</code>,
 * the pool is added to the current mode.
 * Each call to this function creates and sets up a new autorelease pool.
 */
DP_EXTERN void DPSetUpAutoreleasePool(NSString *runLoopMode);

/*!
 * @abstract Finds and returns the PID of a running process with a given
 * bundle identifier.
 * @discussion If a matching process is not found, <code>NO</code> is returned
 * and <code>pid</code> is not modified.
 */
DP_EXTERN BOOL DPGetPIDOfProcess(NSString *bundleIdentifier, pid_t *pid);
