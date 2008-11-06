//
//  ClothoProcessWatcher.h
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/4/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoLogger.h"
@class NDProcess;
@class GTMAXUIElement;

@interface ClothoProcessWatcher : ClothoLogger {
  AXObserverRef focusObserver;
  AXObserverRef windowObserver;
  
  NSDate *currentDate;
  GTMAXUIElement *currentApp;
  GTMAXUIElement *currentWindow;
  NDProcess *lastProcess;
  NSInteger state;
  NSMutableDictionary *lastActivity;
  NSTimer *timer;
}

@property(retain) NSTimer *timer;
@property(retain) NSDate *currentDate;
@property(retain) GTMAXUIElement *currentApp;
@property(retain) GTMAXUIElement *currentWindow;
@property(retain) NSMutableDictionary *lastActivity;

@property(assign) NSInteger state;

@end
