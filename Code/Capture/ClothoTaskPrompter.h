//
//  ClothoTaskPrompter.h
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ClothoTaskPrompter : NSObject {
  NSTimer *askTimer;
  IBOutlet NSWindow *alertWindow;
  IBOutlet NSWindow *shieldWindow;
  IBOutlet NSArrayController *arrayController;
  NSDate *checkDate;
  id currentActivity;
  NSMutableArray *pastActivities;
  float interval;
  FILE *log;
}
- (void)resetTimer;
@end
