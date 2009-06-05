//
//  ClothoProcessWatcher.h
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/4/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoLogger.h"
#import "ClothoScreenWatcher.h"

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
  NSInteger proID;  
  NSMutableDictionary *lastActivity;
  NSTimer *timer;
    NSString *openCloseName;
    NSMetadataQuery *metadataQuery;
}


@property(retain) NSTimer *timer;
@property(retain) NSDate *currentDate;
@property(retain) GTMAXUIElement *currentApp;
@property(retain) GTMAXUIElement *currentWindow;
@property(retain) NSMutableDictionary *lastActivity;

@property(assign) NSInteger state;
@property(assign) NSInteger proID;
@property(assign) NSString *openCloseName;

@end
