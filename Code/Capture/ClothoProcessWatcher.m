//
//  ClothoProcessWatcher.m
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/4/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "GTMAXUIElement.h"
#import "ClothoProcessWatcher.h"
#import "Carbon/Carbon.h"
#import "NDProcess.h"
#import "stdio.h"

#define IDLEDURATION 5.0f
#define TIMERDURATION 5.0f

@interface GTMAXUIElement (Title)
- (NSString *) title;
@end

@implementation GTMAXUIElement (Title)
- (NSString *) title {
    return [self stringValueForAttribute:(NSString *)kAXTitleAttribute];
}
@end

@interface ClothoProcessWatcher ()
- (void)registerForAppChangeNotifications;
- (void)handleProcessEvent:(EventRef)theEvent;
- (BOOL)registerForSwitchNotificationsForApp:(GTMAXUIElement *)app;
- (GTMAXUIElement *)frontWindowForApp:(GTMAXUIElement *)app;
- (BOOL)registerForTitleNotificationsForWindow:(GTMAXUIElement *)element;
- (void)handleWindowChange:(GTMAXUIElement *) element;
- (void)recordContext;
- (NSString *)retrieveInfoForWindow:(id)window;
- (NSString *)checkForWindowNameInWindow:(id)window;
- (void)registerForWindowNotifications:(NSArray *)windowNotifications;
- (void)updateTheBuffer:(NSNotification *)notif;
- (void)checkMinMax;
@end

@implementation ClothoProcessWatcher
@synthesize currentDate, currentApp, currentWindow, state, lastActivity, timer, 
            proID, openCloseName;

- (NSString *)logName {
  return @"Process_";
}

- (NSString *)logDirectory {
    return @"Processes";
}

- (id) init {
    self = [super init];
    if (self != nil) {
        [self registerForAppChangeNotifications];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceSleep:) 
                                                                   name:NSWorkspaceWillSleepNotification 
                                                                 object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceWake:) 
                                                                   name:NSWorkspaceDidWakeNotification 
                                                                 object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceDoesFileOp:) 
                                                                   name:NSWorkspaceDidPerformFileOperationNotification 
                                                                 object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceCloseApp:) 
                                                                   name:NSWorkspaceDidTerminateApplicationNotification
                                                                 object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceSessionActive:) 
                                                                   name:NSWorkspaceSessionDidBecomeActiveNotification
                                                                 object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceSessionResign:) 
                                                                   name:NSWorkspaceSessionDidResignActiveNotification
                                                                 object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceOpenApp:) 
                                                                   name:NSWorkspaceWillLaunchApplicationNotification
                                                                 object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self 
                                                               selector:@selector(workspaceShutDown:) 
                                                                   name:NSWorkspaceWillPowerOffNotification
                                                                 object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(updateTheBuffer:) 
                                                     name:@"OnScreenUpdate" 
                                                   object:nil];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMERDURATION
                                                      target:self
                                                    selector:@selector(timerFired:)
                                                    userInfo:nil
                                                     repeats:YES];
//        [[NSDistributedNotificationCenter defaultCenter] addObserver:self 
//                                                            selector:@selector(receivedNotification:) 
//                                                                name:nil
//                                                              object:nil];
//        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//        NSArray *notificationList = [NSArray arrayWithObjects:
//                                     NSWindowDidBecomeKeyNotification,
//                                     NSWindowDidBecomeMainNotification,
//                                     NSWindowDidChangeScreenNotification,
//                                     NSWindowDidExposeNotification,
//                                     NSWindowWillCloseNotification, 
//                                     NSWindowWillMiniaturizeNotification, nil];
//        [self registerForWindowNotifications:notificationList];
  }
  return self;
}

OSStatus appChanged(EventHandlerCallRef nextHandler, EventRef theEvent, ClothoProcessWatcher *self) {
    [self handleProcessEvent:theEvent];
    return noErr; //CallNextEventHandler(nextHandler, theEvent);
}

- (void)registerForAppChangeNotifications {
    EventTypeSpec eventType;
    eventType.eventClass = kEventClassApplication;
    eventType.eventKind = kEventAppFrontSwitched;
    EventHandlerUPP handlerFunction = NewEventHandlerUPP(appChanged);
    OSStatus err = InstallApplicationEventHandler(handlerFunction, 1, &eventType, self, NULL);
    if (err) NSLog(@"gmod registration err %d",err);
}

- (void)handleProcessEvent:(EventRef)theEvent {
    ProcessSerialNumber psn;
    GetEventParameter(theEvent, kEventParamProcessID, typeProcessSerialNumber, NULL, sizeof(ProcessSerialNumber), NULL, &psn );
  
    NDProcess *process=[NDProcess processWithProcessSerialNumber:psn];
    //NSLog(@"proc %@", process);
  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BTDNAppSwitched" object:process userInfo:[NSDate date] ];
  
    pid_t pid=0;
    GetProcessPID(&psn,&pid);
    if (pid) {
        self.currentDate = [NSDate date];
        self.currentApp = [GTMAXUIElement elementWithProcessIdentifier:pid];
        GTMAXUIElement *window = [self frontWindowForApp:self.currentApp];
        [self registerForSwitchNotificationsForApp:currentApp];
    
        if (window) [self handleWindowChange:window];
        else self.proID = 3;
        [self recordContext];
        // [[NSNotificationCenter defaultCenter] postNotificationName:@"BTDNWindowFocused" object:[self frontWindowForAppElement:currentApp] userInfo:DXTitleForElement(currentApp)];
    }
}

#pragma mark Window Focus switch notification

- (void)handleWindowChange:(GTMAXUIElement *) element{
  [self setCurrentDate:[NSDate date]];
  if (![element isKindOfClass:[GTMAXUIElement class]])
    element = nil;
  [self setCurrentApp:[element processElement]];
  [self setCurrentWindow:element];  
  [self registerForTitleNotificationsForWindow: element];
  self.proID = 1;
}

void focusObserverCallbackFunction(AXObserverRef focusObserver, AXUIElementRef element, CFStringRef notification, void *self) {
    [(id)self handleWindowChange: [[[GTMAXUIElement alloc] initWithElement:element] autorelease]];
}

- (BOOL)registerForSwitchNotificationsForApp:(GTMAXUIElement *) appElement{
    AXUIElementRef element = [appElement element];
    if (focusObserver){
        CFRunLoopRemoveSource(CFRunLoopGetCurrent(),
                              AXObserverGetRunLoopSource(focusObserver), 
                              kCFRunLoopDefaultMode);		
        CFRelease(focusObserver);
    }
    pid_t pid;
    AXUIElementGetPid(element, &pid);
    AXError err = AXObserverCreate(pid, focusObserverCallbackFunction, &focusObserver);
    CFRunLoopAddSource(CFRunLoopGetCurrent(),
                       AXObserverGetRunLoopSource(focusObserver), 
                       kCFRunLoopDefaultMode);
    err = AXObserverAddNotification(focusObserver, element, kAXMainWindowChangedNotification, self);
    return err;
}

- (void)handleTitleChange:(GTMAXUIElement *) element{
  //NSLog(@"title %@", [element valueForAttribute:(NSString *)kAXTitleAttribute]);
}


void windowObserverCallbackFunction(AXObserverRef windowObserver, AXUIElementRef element, CFStringRef notification, void *self) {
    [(ClothoProcessWatcher *)self handleTitleChange: [[[GTMAXUIElement alloc] initWithElement:element] autorelease]];
}

- (BOOL)registerForTitleNotificationsForWindow:(GTMAXUIElement *) element{
    if (windowObserver){
        CFRunLoopRemoveSource(CFRunLoopGetCurrent(),
                              AXObserverGetRunLoopSource(windowObserver), 
                              kCFRunLoopDefaultMode);		
        CFRelease(windowObserver);
        windowObserver = NULL;
    }
  
    AXError err = AXObserverCreate([element processIdentifier], windowObserverCallbackFunction, &windowObserver);
    if (err) return err;
    CFRunLoopAddSource(CFRunLoopGetCurrent(),
                       AXObserverGetRunLoopSource(windowObserver), 
                       kCFRunLoopDefaultMode);
    err = AXObserverAddNotification(windowObserver, [element element], kAXValueChangedNotification, self);
    return err;
}

- (GTMAXUIElement *)frontWindowForApp:(GTMAXUIElement *)app{
  GTMAXUIElement *value = nil;
  @try {
    value = [app accessibilityAttributeValue:(NSString *)kAXFocusedWindowAttribute];
  }
  @catch (NSException * e) {
    NSLog(@"Exception raised: %@", e);
  }
  if ([value isKindOfClass:[NSNull class]]) value = nil;
  return value;
}

- (NSString *)currentWindowName{
  return nil; //[self frontWindowForAppElement:currentApp];
}

- (void)idled:(id)sender {
    NSLog(@"Weeeeeeeeeee");
    [self setCurrentDate:[NSDate dateWithTimeIntervalSinceNow:-IDLEDURATION]];
    self.state = 1;
    self.proID = -1;
    [self recordContext];
}

- (void)unidled:(id)sender {
    [self setCurrentDate:[NSDate date]];
    self.state = 0;
    self.proID = -1;
    [self recordContext];  
}

- (void)timerFired:(id)sender {
    [self setCurrentWindow:[self frontWindowForApp:[self currentApp]]];
}

- (void)workspaceWake:(NSNotification *)notif { 
    //NSLog(@"record wake");
    [self setCurrentDate:[NSDate date]];
    self.state = 0;
    self.proID = -1;
    [self recordContext];
}

- (void)workspaceSleep:(NSNotification *)notif {
    //NSLog(@"record sleep");
    [self setCurrentDate:[NSDate date]];
    self.state = -1;
    self.proID = -1;
    [self recordContext];
}

- (void)workspaceDoesFileOp:(NSNotification *)notif {
    [self setCurrentDate:[NSDate date]];
    self.proID = 4;
    [self recordContext];
}

- (void)workspaceCloseApp:(NSNotification *)notif {
    [self setCurrentDate:[NSDate date]];
    self.openCloseName = [[notif userInfo] objectForKey:@"NSApplicationName"];
    self.proID = 5;
    [self recordContext];
}

- (void)workspaceSessionActive:(NSNotification *)notif {
    [self setCurrentDate:[NSDate date]];
    self.proID = 6;
    [self recordContext];
}

- (void)workspaceSessionResign:(NSNotification *)notif {
    [self setCurrentDate:[NSDate date]];
    self.proID = 7;
    [self recordContext];
}

- (void)workspaceOpenApp:(NSNotification *)notif {
    [self setCurrentDate:[NSDate date]];
    self.openCloseName = [[notif userInfo] objectForKey:@"NSApplicationName"];
    self.proID = 8;
    [self recordContext];
}

- (void)workspaceShutDown:(NSNotification *)notif {
    [self setCurrentDate:[NSDate date]];
    self.proID = 9;
    [self recordContext];
}

- (void)recordContext{
    
    [self setCurrentDate:[NSDate date]];
//    [self checkMinMax];
    
    NSMutableDictionary *activity = [NSMutableDictionary dictionary];
    
//    [activity setValue:[[self currentApp] title] forKey:@"application"];
//    [activity setValue:[self currentDate] forKey:@"date"];
//    [activity setValue:[[self currentWindow] title] forKey:@"window"];
//    [activity setValue:[[self currentWindow] title] forKey:@"window"];
//    [activity setValue:[NSNumber numberWithInt:state] forKey:@"state"];
  
    if ( ([self proID] == 5) || ([self proID] == 8) ) {
        [activity setValue:[self openCloseName] forKey:@"application"];
    }
    else {
        [activity setValue:[[self currentApp] title] forKey:@"application"];
    }
    [activity setValue:[self currentDate] forKey:@"date"];
    id window = [self currentWindow];
    if ([window isKindOfClass:[GTMAXUIElement class]]) {
        if ([self proID] == 3) {
            [activity setValue:@"---see next logged process for this window name-" forKey:@"window"];
        }
        else if ( ([[activity valueForKey:@"application"] isEqualToString:@"Finder"])
            && ([[window title] isEqualToString:@""]) )
            [activity setValue:@"No name for Finder window" forKey:@"window"];
        else
            [activity setValue:[self retrieveInfoForWindow:window] forKey:@"window"];
    }
    else
        NSLog(@"Is not of class");
    [activity setValue:[NSNumber numberWithInt:state] forKey:@"state"];
    [activity setValue:[NSNumber numberWithInt:proID] forKey:@"id"];
  
  if (self.lastActivity){
    float duration=[[self currentDate] timeIntervalSinceDate:[lastActivity valueForKey:@"date"]];
    [lastActivity setValue:[NSNumber numberWithFloat:duration] forKey:@"duration"];

        //  if "application" is (null), then assume (null) should be the application
        //  that is logged right above where this one will be logged
        if (duration > 0.01) {
            NSString *message = [NSString stringWithFormat:@"%@\t%@\t%@\t%@\t%@\t%@\n",
                                 [lastActivity valueForKey:@"date"],
                                 [lastActivity valueForKey:@"application"],
                                 [lastActivity valueForKey:@"state"],
                                 [lastActivity valueForKey:@"id"],
                                 [lastActivity valueForKey:@"duration"],
                                 [lastActivity valueForKey:@"window"]];
            
            [self logProcess:message];
        }
    }
    self.lastActivity = activity;
}

- (NSString *)retrieveInfoForWindow:(id)window {
//    NSLog(@"Window title: %@", [window title]);
    //  if previous system snapshot has the current window, log it's 
    //      1. window owner pid
    //      2. window number
    NSString *stringToLog = [self checkForWindowNameInWindow:window];
    if ([stringToLog length] > 0)
        return stringToLog;
    
    //  else take a system snapshot and repeat the thing above
    else {
        //  force system snapshot!
        NSDictionary *theDate = [NSDictionary dictionaryWithObject:[self currentDate] 
                                                            forKey:@"TheDate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DoSystemSnapshot" 
                                                            object:nil 
                                                          userInfo:theDate];
        stringToLog = [self checkForWindowNameInWindow:window];
        if ([stringToLog length] > 0)
            return stringToLog;
        else
            return @"--window name does not exist--";
    }
}

//  returns the window owner pid and window number in the form of "_, _"
- (NSString *)checkForWindowNameInWindow:(id)window {
    
    NSString *theString = @"";
    
    for (id element in [self theBuffer]) {
        if ([[element objectForKey:@"kCGWindowName"] isEqualToString:[window title]]) {
            theString = [NSString stringWithFormat:@"%@, %@, %@",
                         [element objectForKey:@"kCGWindowOwnerPID"],
                         [element objectForKey:@"kCGWindowNumber"],
                         [window title]];
            break;
        }
    }
    
    return theString;
    
}

- (void)setCurrentWindow:(GTMAXUIElement *)newCurrentWindow {
    if (!currentWindow && !newCurrentWindow) 
        return;
    if (newCurrentWindow && ![currentWindow isEqual:newCurrentWindow]) {
        [currentWindow release];
        currentWindow = [newCurrentWindow retain];
        self.proID = 2;
        [self recordContext];
    }
}


//
//
//
//
//- (void)close{
//  //NSLog(@"close");
//  [[NSNotificationCenter defaultCenter] removeObserver:self];
//  [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
//  [NSObject cancelPreviousIdlePerformRequestsWithTarget:self selector:@selector(idled:) object:nil];
//  
//  
//  [timer invalidate];
//  [checkTimer invalidate];
//  
//  [super close];
//}
//
//- (void)dealloc
//{
//  
//  [alertWindow release];
//  //[logTable release];
//  //[arrayController release];
//  [checkDate release];
//  [currentActivity release];
//  [pastActivities release];
//  [timer release];
//  [appDate release];
//  [currentApp release];
//  [currentWindow release];
//  [currentDate release];
//  [checkTimer release];
//  [lastAppEntry release];
//  
//  alertWindow = nil;
//  //logTable = nil;
//  //arrayController = nil;
//  checkDate = nil;
//  currentActivity = nil;
//  pastActivities = nil;
//  timer = nil;
//  appDate = nil;
//  currentApp = nil;
//  currentWindow = nil;
//  currentDate = nil;
//  checkTimer = nil;
//  lastAppEntry = nil;
//  [super dealloc];
//}
//
//
//
//- (NSString *)windowNibName 
//{
//  return @"MyDocument";
//}
//
//- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
//{
//  [super windowControllerDidLoadNib:windowController];
//  [self setCheckDate:[NSDate date]];
//  //timer=[[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(askUser:) userInfo:nil repeats:NO]retain];
//  
//  if ([self fileName]){
//    [[windowController window]orderFront:self];
//    NSAlert *alert=[NSAlert alertWithMessageText:@"Enable Recording?"
//                                   defaultButton:@"Start Recording"
//                                 alternateButton:@"Disable Recording"
//                                     otherButton:nil
//                       informativeTextWithFormat:@""];
//    
//    [alert beginSheetModalForWindow:[logTable window]
//                      modalDelegate:self
//                     didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
//                        contextInfo:nil];
//  }else{
//    [self setWatchSwitches:YES];
//    [self setWatchWindows:YES];
//  }
//}
//- (IBAction)ok:(id)sender{[NSApp stopModalWithCode:1];}
//- (IBAction)cancel:(id)sender{[NSApp stopModalWithCode:0];}
//
//- (IBAction)export:(id)sender{
//  
//  NSSavePanel *sp;
//  int runResult;
//  /* create or get the shared instance of NSSavePanel */
//  sp = [NSSavePanel savePanel];
//  /* set up new attributes */
//  [sp setRequiredFileType:@"txt"];
//  /* display the NSSavePanel */
//  runResult = [sp runModalForDirectory:NSHomeDirectory() file:@""];
//  /* if successful, save file under designated name */
//  if (runResult == NSOKButton) {
//    NSEnumerator *objEnu=[[[self managedObjectContext]registeredObjects]objectEnumerator];
//    NSMutableArray *entries=[NSMutableArray array];
//    id object;
//    [entries addObject:@"Application\tDate\tTime\tDuration\tInfo"];
//    while(object=[objEnu nextObject]){
//      [entries addObject:[NSString stringWithFormat:@"%@\t%@\t%@\t%@\t%@\t%d",[object valueForKey:@"application"],
//                          [[object valueForKey:@"date"]descriptionWithCalendarFormat:@"%Y/%m/%d" timeZone:nil locale:nil],
//                          [[object valueForKey:@"date"]descriptionWithCalendarFormat:@"%H:%M:%S" timeZone:nil locale:nil],
//                          [object valueForKey:@"duration"],
//                          [object valueForKey:@"window"] ,
//                          [[object valueForKey:@"state"]intValue]
//                          
//                          ]];
//      
//      
//    }
//    if (![[entries componentsJoinedByString:@"\r"] writeToFile:[sp filename] atomically:YES])
//      NSBeep();
//  }
//}
//
//
//- (IBAction)exportActivity:(id)sender{
//  
//  NSSavePanel *sp;
//  int runResult;
//  /* create or get the shared instance of NSSavePanel */
//  sp = [NSSavePanel savePanel];
//  /* set up new attributes */
//  [sp setRequiredFileType:@"txt"];
//  /* display the NSSavePanel */
//  runResult = [sp runModalForDirectory:NSHomeDirectory() file:@""];
//  /* if successful, save file under designated name */
//  if (runResult == NSOKButton) {
//    NSEnumerator *objEnu=[[[self managedObjectContext]registeredObjects]objectEnumerator];
//    NSMutableArray *entries=[NSMutableArray array];
//    id object;
//    [entries addObject:@"Name\tDate\tTime\tDuration"];
//    while(object=[objEnu nextObject]){
//      [entries addObject:[NSString stringWithFormat:@"%@\t%@\t%@\t%@",[object valueForKey:@"name"],
//                          [[object valueForKey:@"date"]descriptionWithCalendarFormat:@"%Y/%m/%d" timeZone:nil locale:nil],
//                          [[object valueForKey:@"date"]descriptionWithCalendarFormat:@"%H:%M:%S" timeZone:nil locale:nil],
//                          [object valueForKey:@"duration"]]];
//      if (![[entries componentsJoinedByString:@"\r"] writeToFile:[sp filename] atomically:YES])
//        NSBeep();
//      
//    }
//  }
//}
//

- (void)receivedNotification:(NSNotification *)notification {
    NSLog(@"NSWindow: %@", [notification name]);
}

- (void)registerForWindowNotifications:(NSArray *)windowNotifications {
//    NSNotificationCenter *center = [NSWindow defaultCenter];
//    for (id winNotif in windowNotifications) {
//        [center addObserver:self selector:@selector(receivedNotification:) name:winNotif object:nil];
}

- (void)updateTheBuffer:(NSNotification *)notif {
    NSArray *updateInfo = [[notif userInfo] objectForKey:@"OnScreenUpdate"];
    [theBuffer release];
    theBuffer = [[NSMutableArray alloc] initWithArray:updateInfo];
}

- (void)checkMinMax {
//    NSArray *appsRunning = [[NSWorkspace sharedWorkspace] launchedApplications];
//    for (id app in appsRunning) {
//        NSLog(@"%@", [app objectForKey:@"NSApplicationName"]);
//    }
//    NSString *bundleIdentifier = 
//    [[appsRunning objectAtIndex:4] objectForKey:@"NSApplicationBundleIdentifier"];
//    NSBundle *aBundle = [NSBundle bundleWithIdentifier:bundleIdentifier];
//    NSBundle *aBundle = [NSBundle bundleWithIdentifier:@"com.apple.Xcode"];
    
}

@end
