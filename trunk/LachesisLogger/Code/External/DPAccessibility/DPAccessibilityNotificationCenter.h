//
//  DPAccessibilityNotificationCenter.h
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

#import <Foundation/Foundation.h>


@class DPUIElement;


/*!
 * @abstract A notification center used to access accessibility notifications.
 */
@interface DPAccessibilityNotificationCenter : NSNotificationCenter {
	NSNotificationCenter *nc;
	CFMutableDictionaryRef _axObservers;
}


/*!
 * @abstract Adds an entry to the receiver’s dispatch table with an observer,
 * a notification selector, sender optional criteria: notification name.
 *
 * @discussion If <code>notificationSender</code> is <code>nil</code>, the
 * system-wide element is assumed to be the sender (or <code>DPTestSubject</code>
 * when running in UITestingKit).
 */
- (void)addObserver:(id)notificationObserver
		   selector:(SEL)notificationSelector
			   name:(NSString *)notificationName
			 object:(DPUIElement *)notificationSender;

- (void)removeObserver:(id)notificationObserver
				  name:(NSString *)notificationName
				object:(DPUIElement *)notificationSender;

/*!
 * @abstract Creates a notification with a given name and sender
 * and posts it to the receiver.
 *
 * @param notificationSender The actual UI object posting the notification,
 * and <b>not</b> a DPUIElement instance.
 *
 * @param userInfo This parameter is ignored as accessibility notifications
 * does not contain additional information.
 */
- (void)postNotificationName:(NSString *)notificationName
					  object:(id)notificationSender
					userInfo:(NSDictionary *)userInfo;

@end
