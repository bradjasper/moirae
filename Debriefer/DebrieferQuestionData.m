//
//  DebrieferQuestionData.m
//  Debriefer
//
//  Created by Joseph Subida on 5/23/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import "DebrieferQuestionData.h"


@implementation DebrieferQuestionData

@synthesize taskList, appsList, dataDate, daysAgo;


//  *************************************************************************************************
- (id)initWithFile:(NSString *)fileName sinceNow:(NSInteger)days withDate:(NSString *)date {
    dataDate = date;
    daysAgo = days;
    taskList = [[NSMutableArray alloc] initWithArray:[self retrieveTasksForFile:(NSString *)fileName]];
    appsList = [[NSMutableArray alloc] initWithArray:[self retrieveApps]];
    return self;
}

//  *************************************************************************************************
- (id)initWithQuestionData:(DebrieferQuestionData *)qData {
    dataDate = [qData dataDate];
    daysAgo = [qData daysAgo];
    if ([[qData taskList] count] == 0) {
        taskList = [[NSMutableArray alloc] init];
        appsList = [[NSMutableArray alloc] init];
    }
    else {
        taskList = [[NSMutableArray alloc] initWithArray:[qData taskList]];
        appsList = [[NSMutableArray alloc] initWithArray:[qData appsList]];
    }
    return self;
}

//  *************************************************************************************************
- (void)dealloc {
    [taskList release];
    [appsList release];
    [super dealloc];
}


#pragma mark -
#pragma mark System Snapshot Functions
#pragma mark -

//  *************************************************************************************************
- (NSString *)createSSPathWithFileName:(NSString *)fileName andDate:(NSString *)theDate {
    NSString *path = [[@"~/Library/Logs/Discipline/Log/System_Snapshots/System_Snapshots_"
                       stringByAppendingString:theDate] stringByExpandingTildeInPath];
    return path; 
}

//  *************************************************************************************************
- (NSString *)formatAppendedDate:(NSString *)dateToFormat {
    NSDate *typeDate = [NSDate dateWithNaturalLanguageString:dateToFormat];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [formatter stringFromDate:typeDate];
    [formatter release];
    return formattedDate;
}

//  *************************************************************************************************
- (NSArray *)retrieveAndFormatTimes {
    NSMutableArray *returnee = [[[NSMutableArray alloc] init] autorelease];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss Z"];
    int i;
    
    for (i=0; i<[[self taskList] count]; i++) {
        NSString *taskDateVal = [[[self taskList] objectAtIndex:i] objectForKey:@"date"];
        NSDate *dateAndTime = [NSDate dateWithString:taskDateVal];
        NSString *theTime = [formatter stringFromDate:dateAndTime];
        [returnee addObject:theTime];
    }
    
    [formatter release];
    return returnee;
}

//  *************************************************************************************************
//  - parse each system snapshot that contain dateToBeDebriefed
//  - fill an NSArray with NSDictionaries that have three keys:
//      1. timeOfSnapshot
//      2. arrayOfApps
//      3. dictionary of appname-appID
//      4. dictionary of appName-appPath
//  *************************************************************************************************
- (NSArray *)retrieveApps {
    NSMutableArray *sysSnap = [[[NSMutableArray alloc] init] autorelease];
    NSString *formattedDate = [self formatAppendedDate:[self dataDate]];
    NSArray *formattedTimes = [self retrieveAndFormatTimes];
    NSString *fileName = [@"System_Snapshots_" stringByAppendingString:formattedDate];    
    NSString *path = [self createSSPathWithFileName:fileName andDate:formattedDate];
    int i;
    
    //  for each file name (i.e. - each time), create NSDictionary as stated above
    for (i=0; i<[formattedTimes count]; i++) {
        fileName = [self retrieveSystemSnapshotForPath:path andTime:[formattedTimes objectAtIndex:i]];
        if ([fileName length] == 0)
            continue;
        fileName = [[self createSSPathWithFileName:fileName 
                                           andDate:formattedDate] stringByAppendingPathComponent:fileName];
        NSArray *systemSnapshot = [self arrayFromPlist:fileName];
        
        NSDictionary *applicationPaths;
        if ([systemSnapshot count] == 5) {
            applicationPaths = [[systemSnapshot objectAtIndex:4] objectForKey:@"ApplicationPaths"];
        }
        else {
            applicationPaths = [NSDictionary dictionary];
        }
        
        NSMutableArray *appsArray = [[NSMutableArray alloc] init];
        NSMutableArray *appIDsArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *appID = [[NSMutableDictionary alloc] init];
        
        //  add the name of the app to the array, but don't add duplicates
        systemSnapshot = [[systemSnapshot objectAtIndex:0] objectForKey:@"OptionAll"];
        for (NSDictionary *aDict in systemSnapshot) {
            NSString *appToBeAdded = [aDict objectForKey:@"kCGWindowOwnerName"];
            NSNumber *appPID = [aDict objectForKey:@"kCGWindowOwnerPID"];
            if (![appsArray containsObject:appToBeAdded]) {
                [appsArray addObject:appToBeAdded];
                [appID setObject:appPID forKey:appToBeAdded];
            }
        }
        
        //  create the dictionary and add it to the array of sysSnapApps
        NSDictionary *timeAndApps = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [formattedTimes objectAtIndex:i], @"time",
                                     appsArray, @"apps",
                                     appID, @"appsIDs", 
                                     applicationPaths, @"appPaths", nil];
        [sysSnap addObject:timeAndApps];
        [appsArray release];
        [appIDsArr release];
        [appID release];
    }
    
    return sysSnap; 
}

//  *************************************************************************************************
- (NSString *)retrieveSystemSnapshotForPath:(NSString *)path 
                                    andTime:(NSString *)theTime {
    NSArray *folderContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path
                                                                                  error:nil];
                               
    NSString *fileName = [NSString string];
    for (id file in folderContents) {
        if ([file rangeOfString:theTime].length) {
            fileName = file;
            break;
        }
    }
    return fileName;        
}

#pragma mark -
#pragma mark Task List Functions
#pragma mark -

//  *************************************************************************************************
- (NSMutableArray *)combineTasksAndApps {
    
    NSMutableArray *tasksAndApps = [[[NSMutableArray alloc] init] autorelease];
    int i;
    
    for (i=0; i<[[self taskList] count]; i++) {
        NSDictionary *combinedDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [[self taskList] objectAtIndex:i], @"task",
                                      [[self appsList] objectAtIndex:i], @"apps", nil];
        [tasksAndApps addObject:combinedDict];
    }
    return tasksAndApps;
    
}

//  *************************************************************************************************
- (NSString *)createTaskPathWithFileName:(NSString *)fileName {
    NSString *path = [@"~/Library/Logs/Discipline/Tasks" stringByAppendingPathComponent:fileName];
    path = [path stringByExpandingTildeInPath];
    return path;
}

//  *************************************************************************************************
- (void)divideTasksAndApps:(NSMutableArray *)combinedAndShuffled {
    
    NSMutableArray *randomTasks = [[NSMutableArray alloc] init];
    NSMutableArray *randomApps = [[NSMutableArray alloc] init];
    int i;
    
    for (i=0; i<[combinedAndShuffled count]; i++) {
        [randomTasks addObject:[[combinedAndShuffled objectAtIndex:i] objectForKey:@"task"]];
        [randomApps addObject:[[combinedAndShuffled objectAtIndex:i] objectForKey:@"apps"]];
    }
    
    [self setTaskList:[self retrieveItemsFor:randomTasks]];
    [self setAppsList:[self retrieveItemsFor:randomApps]];
    
    [randomTasks release];
    [randomApps release];
    
}

//  *************************************************************************************************
// - parse the task log for the given file name
// - returns: NSArray of NSDictionaries of all the tasks for chosen day with the following keys:
//      1. date - which includes the date and time
//      2. task - which is the actual task at date
//  *************************************************************************************************
- (NSArray *)retrieveTasksForFile:(NSString *)fileName {
    NSArray *tasks = 
    [self arrayFromPlist:[self createTaskPathWithFileName:fileName]];
    if (tasks == nil)
        return [NSArray array];
    NSMutableArray *tasksAndDates = [NSMutableArray arrayWithCapacity:[tasks count]];
    
    //  put tasks into tasksAndDates, excluding all "--idle--"s
    for (id item in tasks) {
        NSString *theTask = [item objectForKey:@"name"];
        NSDate *theDate = [item objectForKey:@"date"];
        if (![theTask isEqualToString:@"--idle--"]) {
            NSDictionary *taskToAdd = [NSDictionary dictionaryWithObjectsAndKeys:
                                       theTask, @"task", [theDate description], @"date", nil];
            [tasksAndDates addObject:taskToAdd];
        }
    }
    return tasksAndDates;    
}

//  *************************************************************************************************
- (void)shuffleTasks {
    
    if ([[self taskList] count] == 0)
        return;
    
    NSMutableArray *combinedTasks = [self combineTasksAndApps];     //  combine tasks and apps
    NSMutableArray *shuffledTasks = [[NSMutableArray alloc] init];   //  create array for shuffled tasks
    NSInteger taskCount = [combinedTasks count];
    
    while (taskCount > 1) {
        NSInteger randomNumber = (random() % taskCount);     //  picks a random number from 1 to taskCount
        [shuffledTasks addObject:[combinedTasks objectAtIndex:randomNumber]];
        [combinedTasks removeObjectAtIndex:randomNumber];
        taskCount = [combinedTasks count];
    }
    [shuffledTasks addObject:[combinedTasks objectAtIndex:0]];
    
    [self divideTasksAndApps:shuffledTasks];    //  put tasks and apps back into their proper i-vars
    
    [shuffledTasks release];
    
}

#pragma mark -
#pragma mark Helper Functions
#pragma mark -

//  *************************************************************************************************
//  creates array from plist file for Tasks. Input must be the PATH of the file!!!
//  *************************************************************************************************
- (NSArray *)arrayFromPlist:(NSString *)logFile {
    
    //  check if file exists
    if (![NSFileHandle fileHandleForReadingAtPath:logFile]) {
        NSLog(@"File not found");
        return nil;
    }        
    
    //  read in existing task file
    NSString *errorDesc = nil; 
    NSPropertyListFormat format; 
    NSData *plistXML = [[NSFileManager defaultManager] 
                        contentsAtPath:logFile]; 
    NSArray *returning = (NSArray *)[NSPropertyListSerialization 
                                     propertyListFromData:plistXML 
                                     mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                     format:&format errorDescription:&errorDesc]; 
    if (!returning) { 
        NSLog(errorDesc); 
        [errorDesc release]; 
    }
    return returning;
}

//  *************************************************************************************************
- (NSArray *)createFileNamesForDate:(NSString *)theDate andTimes:(NSArray *)theTimes {
    NSMutableArray *theOneToReturn = [[[NSMutableArray alloc] init] autorelease];
    NSString *fileNamePrefix = [@"System_Snapshot_" stringByAppendingString:theDate];
    int i;
    
    for (i=0; i<[theTimes count]; i++) {
        NSString *fileName = [[fileNamePrefix stringByAppendingString:@" "] 
                              stringByAppendingString:[theTimes objectAtIndex:i]];
        [theOneToReturn addObject:fileName];
    }
    return theOneToReturn;
}

//  *************************************************************************************************
- (void)removeDataForTask:(NSString *)taskToRemove {
    if ( ([taskList count] != 0) && ([appsList count] != 0) ) {
        [[self taskList] removeObjectAtIndex:0];
        [[self appsList] removeObjectAtIndex:0];   
    }
}

//  *************************************************************************************************
//  We only want a certain number of tasks to be debriefed on. Since theArr is already shuffled, we
//  can just return the first X number of items in it, where X is the number of tasks we want. We do
//  this by removing the elements in the indicies greater than X
//  *************************************************************************************************
- (NSMutableArray *)retrieveItemsFor:(NSMutableArray *)theArr {

    NSInteger numberOfStuff = [theArr count];
    NSRange arrayRange;
    
    if ([self daysAgo] == 0) {
        arrayRange.location = 20;
    }
    else {
        arrayRange.location = 8;        
    }
     
    if (arrayRange.location < numberOfStuff) {
        arrayRange.length = numberOfStuff - arrayRange.location;
        NSIndexSet *indicies = [NSIndexSet indexSetWithIndexesInRange:arrayRange];
        [theArr removeObjectsAtIndexes:indicies];
    }
    
    return theArr;
}

@end
