//
//  DPNameServer.h
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


#ifndef DP_EXTERN
#define DP_EXTERN	extern
#endif


#ifdef __OBJC__
#import <Foundation/Foundation.h>


/*!
 * @abstract DPNameServer is a class wrapper around the object naming mechanism
 * introduced in this header.
 * @discussion Using DPNameServer you can assign names to objects.
 * Since all names are stored in one global namespace, names should be in the
 * form of a Java-style package name, although that's completely up to you.
 */
@interface DPNameServer : NSObject {

}

//==========================================================
// NOTE: Objects are NOT retained, while names are copied.
//==========================================================

/*!
 * @abstract Registers <code>name</code> with <code>obj</code>.
 *
 * @discussion A single object may have more than one registered name,
 * but each name belongs to exactly one object.
 * Registering an object for a name that is already registered removes
 * the previous object and registers the new one.
 *
 * Since all names are stored in one global namespace, names should be in the
 * form of a Java-style package name e.g. "com.dpompa.GlobalNameServer".
 *
 * <code>obj</code> is not retained and therefor must properly unregister
 * itself before it deallocates.
 *
 * This method automatically invokes
 * <code>-[NSObject accessibilitySetOverrideValue:forAttribute:]</code>
 * on the receiver in order to make the object accessible to other applications.
 */
+ (void)registerName:(NSString *)name withObject:(id)obj;

/*!
 * @abstract Unregisters <code>name</code> from the global namespace.
 *
 * @discussion This method does nothing of <code>name</code> is not
 * a registered name.
 */
+ (void)unregisterName:(NSString *)name;

/*!
 * @abstract Unregisters all names associated with a given object.
 *
 * @discussion This method does nothing if <code>obj</code> has no
 * registered names.
 * Each registered object <b>MUST</b> unregister itself before it
 * deallocates as objects are not retained.
 */
+ (void)unregisterObject:(id)obj;

/*!
 * @abstract Returns an autoreleased array of all names registered
 * for a given object or <code>nil</code> if no names are registered
 * for the object.
 */
+ (NSArray *)namesOfObject:(id)obj;

/*!
 * @abstract Returns the object associated with <code>name</code>
 * or <code>nil</code> if no object is found.
 */
+ (id)objectNamed:(NSString *)name;

@end
#endif

/*
 * Registers a name with an object. The object can be any pointer type
 * as objects are not retained/released.
 * The passed name is copied.
 */
DP_EXTERN void DPRegisterNameWithObject(CFStringRef name, void *obj);
DP_EXTERN void DPUnregisterName(CFStringRef name);
DP_EXTERN void DPUnregisterObject(void *obj);

/*
 * Returns an array of all names registered for a given object.
 * Ownership of the returned array follows the create rule.
 * Unlike +[DPNameServer namesOfObject:], this function always
 * returns an array even if it's empty.
 */
DP_EXTERN CFArrayRef DPCopyNamesOfObject(void *obj);

/*
 * Returns the object registered with the passed name.
 * Returns NULL if the name is not registered.
 */
DP_EXTERN const void *DPGetObjectNamed(CFStringRef name);

#ifdef DP_BUILDING_UITESTING_KIT

// ========================================== //
// ========= UITestingKit Additions ========= //
// ========================================== //

/*!
 * @abstract Notifies UITestingKit that the tested application is ready
 * for testing.
 *
 * @discussion TestsRunner waits for this notification before it starts starting.
 * This can be called from anywhere you'd like but must be after your app has finished
 * initializing in is completely ready for the user.
 *
 * Additionaly, you can set the DPLAUNCH_TIMEOUT environment variable to make sure
 * testing begins after a given number of seconds. TestsRunner checks the value of this
 * variable, and if available, will use it as a timeout for waiting to test subject.
 * It's always a good idea to set this environment variable as
 * DPNotifyTestingPreparedness() uses distributed notifications under the hood,
 * and therefor notifications may sometimes get accidentally dropped.
 */
DP_EXTERN void DPNotifyTestingPreparedness(void);

#endif
