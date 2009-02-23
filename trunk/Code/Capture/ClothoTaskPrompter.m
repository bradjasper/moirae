//
//  ClothoTaskPrompter.m
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoTaskPrompter.h"


@implementation ClothoTaskPrompter

//  Name of log file
- (NSString *)logName {
    return @"Task_";
}

- (NSString *)logDirectory {
    return @"Tasks";
}

//  Initialize the timer and prompter 
- (id)init {
    self = [super init];
    if (self != nil) {
        interval = 10;
        askTimer = [[NSTimer scheduledTimerWithTimeInterval:10 
                                                     target:self
                                                   selector:@selector(askUser:) 
                                                   userInfo:nil
                                                    repeats:NO] retain];
        [askTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
    return self;
}

//  Create the prompt window
- (void)createAlertWindow {
    [NSBundle loadNibNamed:@"ClothoTaskPrompt" owner:self];
}

//  Create the cool effect for when the prompt window comes up
- (void)createShieldWindow {
    shieldWindow = [[NSWindow alloc] initWithContentRect:[[NSScreen mainScreen] frame]
                                               styleMask:NSBorderlessWindowMask 
                                                 backing:NSBackingStoreBuffered
                                                   defer:NO];
    [shieldWindow setBackgroundColor:[NSColor colorWithDeviceWhite:0.0 alpha:0.5]];
    [shieldWindow setOpaque:NO];
    [shieldWindow setIgnoresMouseEvents:YES];
    [shieldWindow setLevel:NSNormalWindowLevel + 1];
}

//  Ask the user what they're doing so they can type it in and we can log it
- (void)askUser:(NSTimer *)timer {
    [[NSSound soundNamed:@"Whip"]play];
  
    if (!shieldWindow) {
        [self createShieldWindow];
    }
    [shieldWindow setAlphaValue:0.0];	
    [shieldWindow orderFront:nil];
    [[shieldWindow animator] setAlphaValue:1.0];
  
    if (!alertWindow) {	
        NSArray *names=nil;
        //[[[[self managedObjectContext]registeredObjects]valueForKey:@"name"]allObjects];
        //NSLog(@"names %@",names);
        //NSArray *array=[[NSSet setWithArray:names]allObjects];
        [pastActivities addObjectsFromArray:names];
        //NSLog(@"array %@",array);
        [self createAlertWindow];
        [alertWindow setHidesOnDeactivate:NO];
        [alertWindow setLevel:NSStatusWindowLevel];
    }
  
    [self performSelector:@selector(showAlert)
               withObject:nil
               afterDelay:0.333];
}

//  After all is said and done, hide everything that was created
- (void)hideWindows {
    [alertWindow close];	
    [[shieldWindow animator] setAlphaValue:0.0];
}

//  When time is up, reawaken the beast that was created a long, long time ago
//  and is called the alert window
- (void)showAlert {
    [alertWindow makeFirstResponder:[alertWindow initialFirstResponder]];
    [alertWindow setAlphaValue:0.0];	
    [alertWindow center];
    [alertWindow makeKeyAndOrderFront:self];
    [[alertWindow animator] setAlphaValue:1.0];
}


- (void) handleResult:(int)result {
    [self hideWindows];
  
    NSDate *lastDate=[[checkDate retain]autorelease];
    [self setCheckDate:	[NSDate date]];
  
    if (result) {
        NSString *string=[[alertWindow initialFirstResponder] stringValue];
        //NSLog(@"string %@",string);
        [self willChangeValueForKey:@"activityNames"];
        [pastActivities removeObject:string];
        [pastActivities addObject:string];
        [self didChangeValueForKey:@"activityNames"];
    
    
        id activity = [NSMutableDictionary dictionary];
        
        [activity setValue:string forKey:@"name"];
        [activity setValue:checkDate forKey:@"date"];
        [activity setValue:([NSNumber numberWithFloat:[checkDate timeIntervalSinceDate:lastDate]]) forKey:@"duration"];
        [activity setValue:[NSNumber numberWithInt:result] forKey:@"positivity"];
    
        NSString *message = [NSString stringWithFormat:@"%@\t%@\t%@\n",
                                 [activity valueForKey:@"date"],
                                 [activity valueForKey:@"name"],
                                 [activity valueForKey:@"duration"]];
    
        //fprintf(log, [message UTF8String]);
        //fflush(log);
        [self logTask:message];
    }
    [self resetTimer];
}

- (IBAction)    ok:(id)sender {[self handleResult:1];}
- (IBAction)cancel:(id)sender {[self handleResult:0];}

// Does what it says. Checks the date -_-
- (NSDate *)checkDate {
    return [[checkDate retain] autorelease];
}

//this is my test of me typing before dominatrix starts disciplin
- (void)setCheckDate:(NSDate *)value {
    if (checkDate != value) {
        [checkDate release];
        checkDate = [value retain];
    }
}

//  Returns the stuff done in the past
- (NSArray *)activityNames {
    return pastActivities;	
}

//  Retrieves your current festivities
- (id)currentActivity {
    return [[currentActivity retain] autorelease];
}

//  Puts your current festivity in memory
- (void)setCurrentActivity:(id)value {
  if (currentActivity != value) {
      [currentActivity release];
      currentActivity = [value retain];
  }
}

//  Resets the clock
- (void)resetTimer {
    if ([askTimer isValid])
        [askTimer invalidate];
    [askTimer release];
    askTimer = [[NSTimer scheduledTimerWithTimeInterval:60.0f * interval 
                                                 target:self 
                                               selector:@selector(askUser:) 
                                               userInfo:nil 
                                                repeats:NO] retain];	
  //NSLog(@"timer %@",timer);
}

//  If you forgot what you set the interval to, ask me
- (float)interval {
    return interval;
}

//  Wanna set the interval? Call me.
- (void)setInterval:(float)value {
    if (interval != value) {
        interval = value;
        [self resetTimer];
    }
}

@end
