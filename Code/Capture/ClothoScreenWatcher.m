//
//  ClothoScreenWatcher.m
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoScreenWatcher.h"
#include <ApplicationServices/ApplicationServices.h>

@implementation ClothoScreenWatcher

- (NSString *)logName {
    return @"System_Snapshots_";
}

- (NSString *)logDirectory {
    return @"System_Snapshots";
}

- (id) init {
    [self setLogDate:[self todaysDate]];
	BOOL captureScreenShot = NO;
    if(captureScreenShot){
		[self captureScreen];
	}
	[self captureSystemSnapshot];
	[self captureMousePosition];
	return self;
}


- (void)catpureWindowRects {
	
}


- (void)captureKeyWindow {
	
	
} 



- (void) captureWindowWithID:(NSUInteger)windowID {
	CGImageRef windowImage = CGWindowListCreateImage(CGRectNull, kCGWindowListOptionIncludingWindow, windowID, kCGWindowImageDefault);
	CGImageRelease(windowImage);  
}

- (void) captureMousePosition_helper{
    NSPoint mouseCoordinates = [NSEvent mouseLocation];
    [self logMouse:mouseCoordinates];
}
- (void) captureMousePosition{
	[self captureMousePosition_helper];
	
	[self performSelector:@selector(captureMousePosition) withObject:nil afterDelay:60.0];
	
}

- (void)captureScreen_helper{
    
	CGImageRef screenShot = CGWindowListCreateImage(CGRectInfinite, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
	//[self writeCGImage:screenShot toFile:[path stringByAppendingPathExtension:@"png"]];
    [self logScreenShot:screenShot];
    CGImageRelease(screenShot);
}

- (void)captureScreen {
    
	[self captureScreen_helper];

	[self performSelector:@selector(captureScreen) withObject:nil afterDelay:60.0];
}

- (void)captureSystemSnapshot_help{
  
  NSMutableArray *list = (NSMutableArray *)CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly |  
                                                                      kCGWindowListExcludeDesktopElements, kCGNullWindowID);
  
  
  list = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
  [self compareAppFolderToProcess:list];
  
  [self logSystemSnapshot:list];
  
  [list release];
  
}

- (void)captureSystemSnapshot{
	
	[self captureSystemSnapshot_help];
	
	[self performSelector:@selector(captureSystemSnapshot) withObject:nil afterDelay:300.0];
}


- (void)writeCGImage:(CGImageRef)image toFile:(NSString *)path {
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 //                           [NSNumber numberWithFloat:0.0], 
							 //                           kCGImageDestinationLossyCompressionQuality,
							 nil];
	NSURL *url = [NSURL fileURLWithPath:path];
	CGImageDestinationRef destination = CGImageDestinationCreateWithURL((CFURLRef)url, kUTTypePNG, 
																		1, options);
	
	void CGImageDestinationAddImage(CGImageDestinationRef idst,
									CGImageRef image,
									CFDictionaryRef properties);
	CGImageDestinationAddImage(destination, image, 0);  
	bool status = CGImageDestinationFinalize(destination);
	
	CFRelease(destination);
	if (!status) NSLog(@"Couldn't write image file");
	
}

@end