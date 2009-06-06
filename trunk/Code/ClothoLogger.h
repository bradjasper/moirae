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
    NSString *logPath;
    
    NSMutableArray *theBuffer;
}

- (id)initPlist;
- (id)initWithNameAndDirectory:(NSString *)nameOfLog 
                     directory:(NSString *)nameOfDirectory 
                       forDate:(NSDate *)dateToUse;

- (NSString *)logName;
- (NSString *)logDirectory;
- (NSString *)pathOfCreatedDirectory;
- (NSString *)todaysDate;

- (BOOL)logShouldRoll;
- (void)logWithNewDate:(NSString *)newLogDate;
//- (void)logTask:(NSString *)theData; //log
- (void)logTask:(NSMutableDictionary *)theData; //plist
- (void)logProcess:(NSString *)theData;
- (void)logMouse:(NSPoint)coordinates;
- (void)logScreenShot:(CGImageRef)screenShot;
- (void)logSystemSnapshot:(NSMutableArray *)list forDate:(NSDate *)dateToLog;

//- (NSString *)formatDateToAppend:(NSString *)dateToAppend;
- (void)moveFilesToFolderForDate:(NSString *)theDate;

- (NSMutableArray *)compareAppFolderToProcess:(NSMutableArray *)processList;
- (NSMutableArray *)filterArrayWithOptions:(NSMutableArray *)processList options:(NSArray *)optionList;
- (NSArray *)scanAppFolder;
- (NSArray *)optionNotOnScreen:(NSMutableArray *)runningApps;

@property(nonatomic, copy) NSString *logDate;
@property(nonatomic, copy) NSString *logPath;
@property(nonatomic, retain) NSMutableArray *theBuffer;

@end
