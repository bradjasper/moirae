//
//  DXApp.m
//  Discipline
//
//  Created by Nicholas Jitkoff on 6/3/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "DXApp.h"
#import "NSEvent+BLTRExtensions.h"
#import "NDProcess.h"

#import <ApplicationServices/ApplicationServices.h>


@implementation DXApp

- (void)sendEvent:(NSEvent *)theEvent {
    NSLog(@"theEvent %@", theEvent);
    if ([theEvent type]==NSProcessNotificationEvent){
        [self handleProcessEvent:theEvent];
    }	
    [super sendEvent:theEvent];
}

- (BOOL)handleProcessEvent:(NSEvent *)theEvent {
//  ProcessSerialNumber psn;
//  psn.highLongOfPSN=[theEvent data1];
//  psn.lowLongOfPSN=[theEvent data2];
//  int pid=0;
//  GetProcessPID(&psn,&pid);
//  NDProcess *process=[NDProcess processWithProcessSerialNumber:psn];
//  
//  
//  switch ([theEvent subtype]){
//    case NSFrontProcessSwitched:
//    case NSProccessFocusedSubType:
//      [[NSNotificationCenter defaultCenter] postNotificationName:@"BTDNAppSwitched" object:process userInfo:[NSDate date] ];
//      break;
//    default:
//      ;
//  }
//  
//  
//  if (currentApp){
//    CFRelease(currentApp);
//  }
//  currentApp=AXUIElementCreateApplication (pid);
//  
//  [self registerForSwitchNotificationsForApp:currentApp];
//  [[NSNotificationCenter defaultCenter] postNotificationName:@"BTDNWindowFocused" object:[self frontWindowForAppElement:currentApp] userInfo:DXTitleForElement(currentApp)];
  return YES;
}

// THERE WAS A SEMICOLON HERE. IT MIGHT HAVE PREVENTED THE CODE FROM WORKING

@end
