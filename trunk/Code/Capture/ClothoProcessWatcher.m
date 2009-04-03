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
@end

@implementation ClothoProcessWatcher
@synthesize currentDate, currentApp, currentWindow, state, lastActivity, timer;

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
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMERDURATION
                                                      target:self
                                                    selector:@selector(timerFired:)
                                                    userInfo:nil
                                                     repeats:YES];
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
        [self recordContext];
        // [[NSNotificationCenter defaultCenter] postNotificationName:@"BTDNWindowFocused" object:[self frontWindowForAppElement:currentApp] userInfo:DXTitleForElement(currentApp)];
    }
}

#pragma mark Window Focus switch notification

- (void)handleWindowChange:(GTMAXUIElement *) element {
    [self setCurrentDate:[NSDate date]];
    [self setCurrentApp:[element processElement]];

    [self setCurrentWindow:element];  
    [self registerForTitleNotificationsForWindow: element];
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
    return value;
}

- (NSString *)currentWindowName{
  return nil; //[self frontWindowForAppElement:currentApp];
}

- (void)idled:(id)sender {
    [self setCurrentDate:[NSDate dateWithTimeIntervalSinceNow:-IDLEDURATION]];
    self.state = 1;
    [self recordContext];
}

- (void)unidled:(id)sender {
    [self setCurrentDate:[NSDate date]];
    self.state = 0;
    [self recordContext];  
}

- (void)timerFired:(id)sender {
    [self setCurrentWindow:[self frontWindowForApp:[self currentApp]]];
}

- (void)workspaceWake:(NSNotification *)notif { 
    //NSLog(@"record wake");
    [self setCurrentDate:[NSDate date]];
    self.state = 0;
    [self recordContext];
}

- (void)workspaceSleep:(NSNotification *)notif {
    //NSLog(@"record sleep");
    [self setCurrentDate:[NSDate date]];
    self.state = -1;
    [self recordContext];
}

- (void)recordContext{
    [self setCurrentDate:[NSDate date]];
    
    NSMutableDictionary *activity = [NSMutableDictionary dictionary];
    
    [activity setValue:[[self currentApp] title] forKey:@"application"];
    [activity setValue:[self currentDate] forKey:@"date"];
    [activity setValue:[[self currentWindow] title] forKey:@"window"];
    [activity setValue:[[self currentWindow] title] forKey:@"window"];
    [activity setValue:[NSNumber numberWithInt:state] forKey:@"state"];
  
    if (self.lastActivity) {
        float duration=[[self currentDate] timeIntervalSinceDate:[lastActivity valueForKey:@"date"]];
        [lastActivity setValue:[NSNumber numberWithFloat:duration] forKey:@"duration"];
    
        if (duration > 0.01) {
            NSString *message = [NSString stringWithFormat:@"%@\t%@\t%@\t%@\t%@\n",
                                 [lastActivity valueForKey:@"date"],
                                 [lastActivity valueForKey:@"application"],
                                 [lastActivity valueForKey:@"state"],
                                 [lastActivity valueForKey:@"duration"],
                                 [lastActivity valueForKey:@"window"]];
            
            [self logProcess:message];
        }
    }
    self.lastActivity = activity;
}

- (void)setCurrentWindow:(GTMAXUIElement *)newCurrentWindow {
    if (!currentWindow && !newCurrentWindow) 
        return;
    if (newCurrentWindow && ![currentWindow isEqual:newCurrentWindow]) {
        [currentWindow release];
        currentWindow = [newCurrentWindow retain];
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


@end
