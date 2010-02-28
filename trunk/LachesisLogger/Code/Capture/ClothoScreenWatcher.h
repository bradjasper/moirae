//
//  ClothoScreenWatcher.h
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClothoLogger.h"


@interface ClothoScreenWatcher : ClothoLogger {
    BOOL shouldLogCPU;
    NSDate *lastDate;
}

@property(assign) BOOL shouldLogCPU;
@property(retain) NSDate *lastDate;

- (void)captureScreen;
- (void)captureScreen_helper;
- (void)captureSystemSnapshot;
- (void)captureSystemSnapshot_help:(NSDate *)dateToLog;
- (void)captureMousePosition;
- (void)forceSystemSnapshot:(NSNotification *)notif;
- (NSString *)retrieveCPUusage;
- (NSDictionary *)retrieveDesktopSize;
- (void)writeCGImage:(CGImageRef)image toFile:(NSString *)path;

- (NSDictionary *)testing:(NSArray *)list;
@end
