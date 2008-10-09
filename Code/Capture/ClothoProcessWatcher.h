//
//  ClothoProcessWatcher.h
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/4/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class NDProcess;
@class DPUIElement;
@interface ClothoProcessWatcher : NSObject {
  AXObserverRef focusObserver;
  AXObserverRef windowObserver;

  
  NSDate *currentDate;
  DPUIElement *currentApp;
  DPUIElement *currentWindow;
  NDProcess *lastProcess;
  NSInteger state;
  NSMutableDictionary *lastActivity;
  NSTimer *timer;
  FILE *log;
}

@property(retain) NSTimer *timer;
@property(retain) NSDate *currentDate;
@property(retain) DPUIElement *currentApp;
@property(retain) DPUIElement *currentWindow;
@property(retain) NSMutableDictionary *lastActivity;

@property(assign) NSInteger state;

@end
