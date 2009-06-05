//
//  DebrieferLogger.h
//  Debriefer
//
//  Created by Joseph Subida on 5/23/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DebrieferLogger : NSObject {
    NSMutableDictionary *dataToLog;
}

@property (nonatomic, retain) NSMutableDictionary *dataToLog;

- (void)logApp:(NSString *)appID;
- (void)logData:(NSString *)datum forKey:(NSString *)theKey;
- (void)resetApps;
- (void)writeToFile;

@end
