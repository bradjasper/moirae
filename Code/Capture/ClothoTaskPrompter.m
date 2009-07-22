//
//  ClothoTaskPrompter.m
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoTaskPrompter.h"


@implementation ClothoTaskPrompter

@synthesize taskIntervals, breakpointUsed, checkDate, lastDate;

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
        
        NSArray *courseBreaks = [NSArray arrayWithObjects:
                                 [NSNumber numberWithInt:380], // 0
                                 [NSNumber numberWithInt:570], [NSNumber numberWithInt:570], // 1, 2
                                 [NSNumber numberWithInt:760], [NSNumber numberWithInt:760], // 3, 4
                                 [NSNumber numberWithInt:950], nil]; // 5
        NSArray *mediumBreaks = [NSArray arrayWithObjects:
                                 [NSNumber numberWithInt:316], 
                                 [NSNumber numberWithInt:474], [NSNumber numberWithInt:474],
                                 [NSNumber numberWithInt:632], [NSNumber numberWithInt:632],
                                 [NSNumber numberWithInt:790], nil];

        taskIntervals = [[NSArray alloc] initWithObjects:courseBreaks, mediumBreaks, nil];
        breakpointUsed = @"0CC";    

        askTimer = [[NSTimer scheduledTimerWithTimeInterval:10
                                                     target:self
                                                   selector:@selector(askUser:) 
                                                   userInfo:nil
                                                    repeats:NO] retain];
        [askTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        [self setCheckDate:[askTimer fireDate]];
        NSRunLoop *mainRL = [NSRunLoop mainRunLoop];
        [mainRL addTimer:askTimer forMode:@"NSDefaultRunLoopMode"];
        
        
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
    
    [self setLastDate:checkDate];
    [self setCheckDate:[timer fireDate]];
    
    [[NSSound soundNamed:@"Whip"] play];
  
    if (!shieldWindow) {
        [self createShieldWindow];
    }
    [shieldWindow setAlphaValue:0.0];
    [shieldWindow orderFront:self];
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
//    NSDate *lastDate=[[checkDate retain] autorelease];
//    [self setCheckDate:	[NSDate date]];
    
    //  force a system snapshot
    NSDictionary *theDate = [NSDictionary dictionaryWithObject:[self checkDate] forKey:@"TheDate"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoSystemSnapshot" 
                                                        object:self 
                                                      userInfo:theDate];
    
    if (result) {
        NSString *string;
        if (isIdle)
            string = [NSString stringWithString:@"--idle--"];
        else
            string = [(NSComboBox *)[alertWindow initialFirstResponder] stringValue];
        [self willChangeValueForKey:@"activityNames"];
        [pastActivities removeObject:string];
        [pastActivities addObject:string];
        [self didChangeValueForKey:@"activityNames"];
    
    
        id activity = [NSMutableDictionary dictionary];
        
        [activity setValue:string forKey:@"name"];
        [activity setValue:checkDate forKey:@"date"];
        [activity setValue:([NSNumber numberWithFloat:[checkDate timeIntervalSinceDate:lastDate]]) 
                    forKey:@"duration"];
        [activity setValue:[NSNumber numberWithInt:result] forKey:@"positivity"];
        [activity setValue:breakpointUsed forKey:@"breakpoint"];

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
    
    interval = [[self randomInterval] doubleValue];

    askTimer = [[NSTimer scheduledTimerWithTimeInterval:10
                                                 target:self 
                                               selector:@selector(askUser:) 
                                               userInfo:nil 
                                                repeats:NO] retain];
    [askTimer setFireDate:[checkDate addTimeInterval:interval]];
    NSRunLoop *mainRL = [NSRunLoop mainRunLoop];
    [mainRL addTimer:askTimer forMode:@"NSDefaultRunLoopMode"];
//    NSLog(@"timer %f",interval);
}

- (NSNumber *)randomInterval {
    
    if (isShortInterval)
        return [NSNumber numberWithInt:40];
    
    NSString *breakPointToUse, *bPointSet;
    NSInteger bPoint;
    NSArray *breakpointsToUse;
    NSNumber *chosenBPoint;
    
    //  choose a breakpoint set (course or medium breakpoints):
    bPoint = (random() % 2);
    if (bPoint == 0)
        bPointSet = @"C";
    else
        bPointSet = @"M";
    breakpointsToUse = [taskIntervals objectAtIndex:bPoint];
    
    //  choose a new breakpoint: 
    bPoint = (random() % [breakpointsToUse count]);
    breakPointToUse = [[[NSNumber numberWithInt:bPoint] stringValue]
                       stringByAppendingFormat:@"%c", [breakpointUsed characterAtIndex:2]];
    
    //  check the old breakpoint:
    if ( ([breakpointUsed characterAtIndex:2] == 'C') && ([bPointSet isEqualToString:@"M"]) ) {
        // 203 + v
        // v = f(n-1)
        if ( (bPoint == 2) || (bPoint == 4) )
            chosenBPoint = [NSNumber numberWithInt:([[breakpointsToUse objectAtIndex:(bPoint-2)] intValue] + 203)];
        else if (bPoint == 0)
            chosenBPoint = [NSNumber numberWithInt:(158 + 203)];
        else
            chosenBPoint = [NSNumber numberWithInt:([[breakpointsToUse objectAtIndex:(bPoint-1)] intValue] + 203)];
        breakPointToUse = [breakPointToUse stringByAppendingString:@"M"];
    }
    else if ( ([breakpointUsed characterAtIndex:2] == 'M') && ([bPointSet isEqualToString:@"C"]) ) {
        // 385 + v
        // v = f(n-1)
        if ( (bPoint == 2) || (bPoint == 4) )
            chosenBPoint = [NSNumber numberWithInt:([[breakpointsToUse objectAtIndex:(bPoint-2)] intValue] + 385)];
        else if (bPoint == 0)
            chosenBPoint = [NSNumber numberWithInt:(190 + 385)];
        else
            chosenBPoint = [NSNumber numberWithInt:([[breakpointsToUse objectAtIndex:(bPoint-1)] intValue] + 385)];
        breakPointToUse = [breakPointToUse stringByAppendingString:@"M"];
    }
    else {
        chosenBPoint = [breakpointsToUse objectAtIndex:bPoint];
        breakPointToUse = [breakPointToUse stringByAppendingFormat:@"%c", [breakPointToUse characterAtIndex:1]];
    }
    [self setBreakpointUsed:breakPointToUse];
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
