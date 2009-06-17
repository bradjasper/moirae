//
//  ClothoTaskPrompter.h
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClothoLogger.h"
#import "ClothoScreenWatcher.h"

@interface ClothoTaskPrompter : ClothoLogger {
    NSTimer *askTimer;
    NSTimer *idleTimer;
    BOOL isIdle;
    BOOL isShortInterval;
    IBOutlet NSWindow *alertWindow;
    IBOutlet NSWindow *shieldWindow;
    IBOutlet NSArrayController *arrayController;
    NSDate *checkDate;
    id currentActivity;
    NSMutableArray *pastActivities;
    float interval;
    NSArray *taskIntervals;
    NSString *breakpointUsed;
}

@property(retain) NSArray *taskIntervals;
@property(copy) NSString *breakpointUsed;
@property(retain) NSDate *checkDate;

- (NSNumber *)randomInterval;
- (void)resetTimer;
- (void)checkIdle;
- (void)handleResult:(int)result;
- (void)createShieldWindow;
@end
