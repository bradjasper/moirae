//
//  ClothoLogger.h
//  Moirae
//
//  Created by Joseph Subida on 2/9/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ClothoLogger : NSObject {
    FILE *log;
    NSString *logDate;
}

- (NSString *)logName;
- (NSString *)logDirectory;
- (NSString *)pathOfCreatedDirectory;
- (NSString *)todaysDate;

- (void)logRoll;
- (BOOL)logShouldRoll;
- (void)logWithNewDate:(NSString *)newLogDate;
- (void)logTask:(NSString *)theData;
- (void)logProcess:(NSString *)theData;

@property(nonatomic, copy) NSString *logDate;

@end
