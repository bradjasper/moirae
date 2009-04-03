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
}

- (void)captureScreen;
- (void)captureScreen_helper;
- (void)captureSystemSnapshot;
- (void)captureSystemSnapshot_help;
- (void)captureMousePosition;
- (void)writeCGImage:(CGImageRef)image toFile:(NSString *)path;

@end
