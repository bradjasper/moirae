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
- (id) init {
	BOOL captureScreenShot = NO;
	self = [super init];
	if (self != nil) {

		[[NSFileManager defaultManager] createDirectoryAtPath:[@"~/Library/Logs/Discipline/Log/System_Snapshots/" stringByStandardizingPath]
								  withIntermediateDirectories:YES attributes:nil error:nil];
		
		if(captureScreenShot){
			[[NSFileManager defaultManager] createDirectoryAtPath:[@"~/Library/Logs/Discipline/Screenshots/" stringByStandardizingPath]
									  withIntermediateDirectories:YES attributes:nil error:nil];
			[self captureScreen];
			
			
		}
		[self captureSystemSnapshot];
		[self captureMousePosition];
	}
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
	//Insert mouse collection code here
	
	//Insert call to ClothoLogger here to write to disk
}
- (void) captureMousePosition{
	[self captureMousePosition_helper];
	
	[self performSelector:@selector(captureMousePosition) withObject:nil afterDelay:60.0];
	
}

- (void)captureScreen_helper{
	NSString *path = @"~/Library/Logs/Discipline/Screenshots/%@";
	path = [NSString stringWithFormat:path, [NSDate date]];
	path = [path stringByStandardizingPath];
	CGImageRef screenShot = CGWindowListCreateImage(CGRectInfinite, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
	//Change to call to ClothoLogger here to write to disk
	[self writeCGImage:screenShot toFile:[path stringByAppendingPathExtension:@"png"]];
	CGImageRelease(screenShot);
}

- (void)captureScreen {

	[self captureScreen_helper];

	[self performSelector:@selector(captureScreen) withObject:nil afterDelay:60.0];
}

- (void)captureSystemSnapshot_help{
	NSString *path = @"~/Library/Logs/Discipline/Log/System_Snapshots/%@";
	path = [NSString stringWithFormat:path, [NSDate date]];
	path = [path stringByStandardizingPath];

	NSArray *list = (NSArray *)CGWindowListCopyWindowInfo(kCGWindowListOptionAll |  
														  kCGWindowListExcludeDesktopElements, kCGNullWindowID);
	//Change to call to ClothoLogger here to write to disk
	[list writeToFile:[path stringByAppendingPathExtension:@"plist"] 
		   atomically:NO];
	[list release];
	
}

- (void)captureSystemSnapshot{
	
	[self captureSystemSnapshot_help];
	
	[self performSelector:@selector(captureSystemSnapshot) withObject:nil afterDelay:60.0];
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