//
//  DisciplineController.m
//  Discipline
//
//  Created by alcor on 9/21/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "DisciplineController.h"
#import "ClothoProcessWatcher.h"
#import "ClothoScreenWatcher.h"
#import "DisciplineTaskPrompter.h"
#import "QSAccessibility.h"

#define DOC_PATH [@"~/Library/Application Support/Discipline/" stringByStandardizingPath]

@implementation DisciplineController

- (void)applicationDidFinishLaunching:(NSApplication *)theApplication{
  QSEnableAccessibility();
  
  NSString *directory = [@"~/Library/Logs/Discipline" stringByStandardizingPath];
  
  [[NSFileManager defaultManager] createDirectoryAtPath:directory
                            withIntermediateDirectories:YES
                                             attributes:nil
                                                  error:nil];
  [[ClothoProcessWatcher alloc] init];
  [[ClothoScreenWatcher alloc] init];
  [[ClothoTaskPrompter alloc] init];
  
  
  NSImage *image = [NSImage imageNamed:@"Discipline"];
  image = [image copy];
  [image setSize:NSMakeSize(16, 16)];
  NSStatusItem *item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
  [item setImage:image];
  [item retain];
}

@end
