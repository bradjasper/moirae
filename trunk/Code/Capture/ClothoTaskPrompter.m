//
//  ClothoTaskPrompter.m
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoTaskPrompter.h"


@implementation ClothoTaskPrompter

@synthesize taskIntervals, breakpointUsed;

//  Name of log file
- (NSString *)logName {
    return @"Task_";
}

- (NSString *)logDirectory {
    return @"Tasks";
}

//  Initialize the timer and prompter 
- (id)init {
    self = [super initPlist];
    if (self != nil) {
        isShortInterval = NO;
        interval = 10;
        askTimer = [[NSTimer scheduledTimerWithTimeInterval:10
                                                     target:self
                                                   selector:@selector(askUser:) 
                                                   userInfo:nil
                                                    repeats:NO] retain];
        [askTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        NSArray *courseBreaks;
        NSArray *mediumBreaks;
        if (isShortInterval) {
            courseBreaks = [NSArray arrayWithObjects:
                              [NSNumber numberWithInt:40],  nil];
            mediumBreaks = [NSArray arrayWithObjects:
                            [NSNumber numberWithInt:40], nil];
        }
        else {
            courseBreaks = [NSArray arrayWithObjects:
                                     [NSNumber numberWithInt:380], 
                                     [NSNumber numberWithInt:570], [NSNumber numberWithInt:570],
                                     [NSNumber numberWithInt:760], [NSNumber numberWithInt:760],
                                     [NSNumber numberWithInt:950], nil];
             mediumBreaks = [NSArray arrayWithObjects:
                                     [NSNumber numberWithInt:316], 
                                     [NSNumber numberWithInt:474], [NSNumber numberWithInt:474],
                                     [NSNumber numberWithInt:632], [NSNumber numberWithInt:632],
                                     [NSNumber numberWithInt:790], nil];
        }   
        taskIntervals = [[NSArray alloc] initWithObjects:courseBreaks, mediumBreaks, nil];
        breakpointUsed = @"first run";
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
//    [[shieldWindow animator] setAlphaValue:0.0];
    [shieldWindow setAlphaValue:0.0];
}

//  When time is up, reawaken the beast that was created a long, long time ago
//  and is called the alert window
- (void)showAlert {
    [alertWindow makeFirstResponder:[alertWindow initialFirstResponder]];
    [alertWindow setAlphaValue:0.0];	
    [alertWindow center];
    [alertWindow makeKeyAndOrderFront:self];
    [[alertWindow animator] setAlphaValue:1.0];
    isIdle = NO; // active until proven idle
    idleTimer = [[NSTimer scheduledTimerWithTimeInterval:60
                                                  target:self 
                                                selector:@selector(checkIdle) 
                                                userInfo:nil 
                                                 repeats:NO] retain];
}

- (void)checkIdle {
    isIdle = YES;
    [self handleResult:1];
}

- (void)handleResult:(int)result {
    [idleTimer invalidate];
    [idleTimer release];
    
    [self hideWindows];
    NSDate *lastDate=[[checkDate retain] autorelease];
    [self setCheckDate:	[NSDate date]];
    ClothoScreenWatcher *watcher = [[ClothoScreenWatcher alloc] init];
    [watcher captureSystemSnapshot_help:checkDate];
    [watcher release];
    
    if (result) {
        NSString *string;
        if (isIdle)
            string = [NSString stringWithString:@"--idle--"];
        else
            string = [[alertWindow initialFirstResponder] stringValue];
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
        [activity setValue:breakpointUsed forKey:@"breakpoint"];
    /*
        NSString *message = [NSString stringWithFormat:@"%@\t%@\t%@\n",
                                 [activity valueForKey:@"date"],
                                 [activity valueForKey:@"name"],
                                 [activity valueForKey:@"duration"]];
    
        [self logTask:message]; */
        [self logTask:activity];
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
    
    interval = [[self randomInterval] floatValue];
    askTimer = [[NSTimer scheduledTimerWithTimeInterval:interval
                                                 target:self 
                                               selector:@selector(askUser:) 
                                               userInfo:nil 
                                                repeats:NO] retain];	
    NSLog(@"timer %f",interval);
}

- (NSNumber *)randomInterval {
    
    NSString *bPointToLog;    
    NSNumber *chosenBPoint = [[[NSNumber alloc] init] autorelease];
    
    //  choose a breakpoint set (course or medium breakpoints):
    NSInteger bPoint = (random() % 2);
    if (bPoint == 0)
        bPointToLog = @"C";
    else
        bPointToLog = @"M";
    NSArray *breakpointsToUse = [taskIntervals objectAtIndex:bPoint];
    
    //  choose a breakpoint: 
    bPoint = (random() % [breakpointsToUse count]);
    bPointToLog = [bPointToLog stringByAppendingString:
    [[NSNumber numberWithInt:bPoint] stringValue]];
    chosenBPoint = [breakpointsToUse objectAtIndex:bPoint];
    
    [self setBreakpointUsed:bPointToLog];
    return chosenBPoint;
    
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
