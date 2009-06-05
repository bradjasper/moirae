//
//  ClothoScreenWatcher.m
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoScreenWatcher.h"
#import <Foundation/NSZone.h>
#include <ApplicationServices/ApplicationServices.h>
#include <openssl/md5.h>

@implementation ClothoScreenWatcher

@synthesize shouldLogCPU;

- (NSString *)logName {
    return @"System_Snapshots_";
}

- (NSString *)logDirectory {
    return @"System_Snapshots";
}

- (id) init {
    if (!(self = [super init])) 
        return nil;
    [self setLogDate:[self todaysDate]];
	BOOL captureScreenShot = NO;
    if(captureScreenShot){
		[self captureScreen];
	}
	[self captureSystemSnapshot];
	[self captureMousePosition];
    
    shouldLogCPU = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(forceSystemSnapshot:)
                                                 name:@"DoSystemSnapshot" 
                                               object:nil];
    
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
	
	[self performSelector:@selector(captureMousePosition) withObject:nil afterDelay:114.0];
	
}

- (void)captureScreen_helper{
    
	CGImageRef screenShot = CGWindowListCreateImage(CGRectInfinite, kCGWindowListOptionAll, kCGNullWindowID, kCGWindowImageDefault);
	//[self writeCGImage:screenShot toFile:[path stringByAppendingPathExtension:@"png"]];
    [self logScreenShot:screenShot];

    CGImageRelease(screenShot);
}

- (void)captureScreen {
    
	[self captureScreen_helper];

	[self performSelector:@selector(captureScreen) withObject:nil afterDelay:60.0];
}

- (void)captureSystemSnapshot_help:(NSDate *)dateToLog{
  
//  NSMutableArray *list = (NSMutableArray *)CGWindowListCopyWindowInfo(kCGWindowListOptionAll |  
//                                                                      kCGWindowListExcludeDesktopElements, kCGNullWindowID);
  
  
    NSMutableArray *optAll = (NSMutableArray *)CGWindowListCopyWindowInfo(kCGWindowListOptionAll, kCGNullWindowID);
    NSMutableArray *onScreen = (NSMutableArray *)CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
    NSMutableArray *toLog = [[NSMutableArray alloc] init];
    
    optAll = [self compareAppFolderToProcess:optAll];
    NSDictionary *applicationPaths = [optAll lastObject];
    [optAll removeLastObject];
    onScreen = [self compareAppFolderToProcess:onScreen];
    [onScreen removeLastObject];
    onScreen = [self filterArrayWithOptions:onScreen options:[NSArray arrayWithObjects:
                                                              @"kCGWindowNumber", @"kCGWindowOwnerPID", nil]];
    
    [toLog addObject:[NSDictionary dictionaryWithObject:optAll forKey:@"OptionAll"]];
    [toLog addObject:[NSDictionary dictionaryWithObject:onScreen forKey:@"OptionOnScreenOnly"]];                 

    [toLog addObject:[NSDictionary dictionaryWithObject:[self retrieveDesktopSize] forKey:@"DesktopSize"]];
    
//    if (shouldLogCPU)
        [toLog addObject:[NSDictionary dictionaryWithObject:[self retrieveCPUusage] forKey:@"CPUUsage"]];
//    else {
//        [toLog addObject:[NSDictionary dictionaryWithObject:@"Process System Snapshot" forKey:@"CPUUsage"]];
//        shouldLogCPU = YES;
//    }
    
    [toLog addObject:applicationPaths];
    
    [self logSystemSnapshot:toLog forDate:dateToLog];
    
    [toLog release];
}

- (void)captureSystemSnapshot{
	
	[self captureSystemSnapshot_help:[NSDate date]];
	
	[self performSelector:@selector(captureSystemSnapshot) withObject:nil afterDelay:114.0];
    
}

- (void)forceSystemSnapshot:(NSNotification *)notif {
    shouldLogCPU = NO;
    [self captureSystemSnapshot_help:[[notif userInfo] objectForKey:@"TheDate"]];
}

- (NSString *)retrieveCPUusage {
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/top"];
    
    // "-l2" is the number of times top is run
//    NSArray *arguments = [NSArray arrayWithObjects:@"-FR", @"-l3", nil];
    NSArray *arguments = [NSArray arrayWithObjects:@"-ocpu", @"-FR", @"-l5", nil];
    [task setArguments:arguments];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    
    NSFileHandle *file = [pipe fileHandleForReading];
    
    //  run terminal command: "top -ocpu -FR -l5"
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *outputComponents = [NSArray arrayWithArray:[output componentsSeparatedByString:@"Processes:"]];
    [output release];
//    for (id topOutput in outputComponents) {
//        NSRange usageRange = [topOutput rangeOfString:@"CPU usage:"];
//        if (usageRange.length != 0) {
//            usageRange.length += 38;
//            
//            NSString *justUsage = [topOutput substringWithRange:usageRange];
//            NSRange percentage;
//            percentage.length = 6;
//            
//            percentage.location = 10;
//            NSString *user = [justUsage substringWithRange:percentage];
//            percentage.location = 23;
//            NSString *sys = [justUsage substringWithRange:percentage];
//            percentage.location = 35;
//            NSString *idle = [justUsage substringWithRange:percentage];
//            
//            [CPUsamples addObject:[NSDictionary dictionaryWithObjectsAndKeys:
//                                   user, @"user",
//                                   sys, @"sys",
//                                   idle, @"idle", nil]];
//        }
//    }
    return [outputComponents objectAtIndex:4];
}

// The screen containing the menu bar is always the first object (index 0) in the array returned 
// by [NSScreen screens]
- (NSDictionary *)retrieveDesktopSize {
    //  log each screen's size and the total size
    NSArray *allScreens = [NSArray arrayWithArray:[NSScreen screens]];
    NSEnumerator *screenEnum = [allScreens objectEnumerator];
    NSMutableDictionary *screensAndSizes = [[[NSMutableDictionary alloc] init] autorelease];
    CGFloat totalSum = 0;
    int i;
    for (i=0; i<[allScreens count]; i++) {
        id screen = [screenEnum nextObject];
        CGFloat height = CGRectGetHeight(NSRectToCGRect([screen frame]));
        CGFloat width = CGRectGetWidth(NSRectToCGRect([screen frame]));
        totalSum += height*width;
        
        NSString *screenWidth = [@"Width" stringByAppendingString:[NSString stringWithFormat:@"%d", (i+1)]];
        NSString *screenHeight = [@"Height" stringByAppendingString:[NSString stringWithFormat:@"%d", (i+1)]];
        
        [screensAndSizes setValue:[NSNumber numberWithFloat:width] forKey:screenWidth];
        [screensAndSizes setValue:[NSNumber numberWithFloat:height] forKey:screenHeight];
    }
    [screensAndSizes setValue:[NSNumber numberWithFloat:totalSum] forKey:@"TotalSize"];
    
    return screensAndSizes;
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

- (NSDictionary *)testing:(NSArray *)list {
    NSArray *optionAll = [NSArray arrayWithArray:[[list objectAtIndex:0] objectForKey:@"OptionAll"]];
    NSMutableArray *appList = [[NSMutableArray alloc] init];
    NSMutableDictionary *data = [[[NSMutableDictionary alloc] init] autorelease];
    
    for (id thing in optionAll) {
        NSString *appName = [thing objectForKey:@"kCGWindowOwnerName"];
        NSNumber *winNumb = [thing objectForKey:@"kCGWindowNumber"];
        
        if (![appList containsObject:appName]) {
            [appList addObject:appName];
            [data setObject:[NSMutableArray arrayWithObject:winNumb] forKey:appName];
        }
        else {
            NSMutableArray *theObj = [data objectForKey:appName];
            [theObj addObject:winNumb];
            [data setObject:theObj forKey:appName];
        }
    }
    
    [appList release];
    return data;
}

@end