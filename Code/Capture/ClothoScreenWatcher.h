//
//  ClothoScreenWatcher.h
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ClothoScreenWatcher : NSObject {
}

- (void)captureScreen;
- (void)captureScreen_help;
- (void)captureSystemSnapshot;
- (void)captureSystemSnapshot_help;
- (void)captureMousePosition;
- (void)writeCGImage:(CGImageRef)image toFile:(NSString *)path;

@end
