//
//  DebrieferQuestionData.h
//  Debriefer
//
//  Created by Joseph Subida on 5/23/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DebrieferQuestionData : NSObject {
    NSMutableArray *taskList;
    NSMutableArray *appsList;
    NSString *dataDate;
    NSInteger daysAgo;
}

@property (nonatomic,retain) NSMutableArray *taskList;
@property (nonatomic,retain) NSMutableArray *appsList;
@property (nonatomic,assign) NSString *dataDate;
@property (nonatomic,assign) NSInteger daysAgo;

- (id)initWithFile:(NSString *)fileName sinceNow:(NSInteger)days withDate:(NSString *)date;
- (id)initWithQuestionData:(DebrieferQuestionData *)qData;

//  System Snapshot Functions
- (NSString *)createSSPathWithFileName:(NSString *)fileName andDate:(NSString *)theDate;
- (NSArray *)retrieveAndFormatTimes;
- (NSString *)formatAppendedDate:(NSString *)dateToFormat;
- (NSArray *)retrieveApps;
- (NSString *)retrieveSystemSnapshotForPath:(NSString *)path andTime:(NSString *)theTime;

//  Task List Functions
- (NSMutableArray *)combineTasksAndApps;
- (NSString *)createTaskPathWithFileName:(NSString *)fileName;
- (void)divideTasksAndApps:(NSMutableArray *)combinedAndShuffled;
- (NSArray *)retrieveTasksForFile:(NSString *)fileName;
- (void)shuffleTasks;

//  Helper Functions
- (NSArray *)arrayFromPlist:(NSString *)logFile;
- (NSArray *)createFileNamesForDate:(NSString *)theDate andTimes:(NSArray *)theTimes;
- (void)removeDataForTask:(NSString *)taskToRemove;
- (NSMutableArray *)retrieveItemsFor:(NSMutableArray *)theArr;

@end
