//
//  ClothoLogger.m
//  Moirae
//
//  Created by Joseph Subida on 2/9/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import "ClothoLogger.h"

@implementation ClothoLogger

@synthesize logDate, logPath;

- (id)init {
    if (!(self = [super init]))
        return nil;
    
    // Create directory path
    [self setLogPath:[self pathOfCreatedDirectory]];
    
    // Create current log file
    [self setLogDate:[self todaysDate]];
    NSString *path = [logPath stringByAppendingPathComponent:[[self logName]
                                       stringByAppendingString:[logDate
                                       stringByAppendingString:@".log"]]];
    log = fopen([path fileSystemRepresentation], "a");
    return self;
}

- (id)initPlist {
    if (!(self = [super init]))
        return nil;
    
    // Create directory path
    [self setLogPath:[self pathOfCreatedDirectory]];

    // Set the date
    [self setLogDate:[self todaysDate]];

    return self;        
}

- (id)initWithNameAndDirectory:(NSString *)nameOfLog directory:(NSString *)directoryOfLog {
    NSString *directory = [@"~/Library/Logs/Discipline/Log/" stringByStandardizingPath];
    directory = [directory stringByAppendingPathComponent:directoryOfLog];
    NSString *path;
    
    [[NSFileManager defaultManager] 
     createDirectoryAtPath:[directory stringByStandardizingPath]
     withIntermediateDirectories:YES attributes:nil error:nil];
    
    if ([nameOfLog isEqualToString:@"Mouse_"]) {
        [self setLogDate:[self todaysDate]];
        path = [directory stringByAppendingPathComponent:
                [[nameOfLog stringByAppendingString:logDate] stringByAppendingString:@".log"]];
        log = fopen([path fileSystemRepresentation], "a");
        return self;
    }
    else {
        path = [directory stringByAppendingPathComponent:
                [nameOfLog stringByAppendingString:[[NSDate date] description]]];
        return path;
    }
}

- (void) dealloc {
    fclose(log);
    [super dealloc];
}

#pragma mark -
#pragma mark Properties

  // (NSString *)logName
  //      - returns name of log file
- (NSString *)logName {
    return @"log.log";
}

  // (NSString *)logDirectory
  //      - returns name of directory of log files
- (NSString *)logDirectory {
    return @"Logs";
}

#pragma mark -
#pragma mark Logging functions

/*
  // (void)logTask===========================.LOG
  //      - writes theData to the Task log file
- (void)logTask:(NSString *)theData {
    if ([self logShouldRoll])
        NSLog(@"New log created today");
    fprintf(log, [theData UTF8String]);
    fflush(log);
}
*/

// (void)logTask=============================.PLIST
//      - writes theData to the Task log file
- (void)logTask:(NSMutableDictionary *)theData {
    if ([self logShouldRoll])
        NSLog(@"New log created today");
    NSMutableArray *combinedDictionaries = [NSMutableArray arrayWithCapacity:1];
    NSString *dictPath = [[logPath stringByAppendingPathComponent:
                           [[self logName] stringByAppendingString:logDate]]
                             stringByAppendingPathExtension:@"plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictPath]) {
        //  Read in property list
        NSString *errorDesc = nil; 
        NSPropertyListFormat format; 
        NSData *plistXML = [[NSFileManager defaultManager] 
                            contentsAtPath:dictPath]; 
        NSArray *oldDicts = (NSArray *)[NSPropertyListSerialization 
                                        propertyListFromData:plistXML 
                                        mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                        format:&format errorDescription:&errorDesc]; 
        if (!oldDicts) { 
            NSLog(errorDesc); 
            [errorDesc release]; 
        } 
        
        [combinedDictionaries addObjectsFromArray:oldDicts];
        [combinedDictionaries addObject:theData];
    }
    else
        [combinedDictionaries addObject:theData];
    [combinedDictionaries writeToFile:dictPath atomically:NO];
}

  // (void)logProcess
  //      - writes theData to the Process log file
- (void)logProcess:(NSString *)theData {
    if ([self logShouldRoll])
        NSLog(@"New log created today");
    fprintf(log, [theData UTF8String]);
    fflush(log);
}


- (void)logMouse:(NSPoint)coordinates {
    if ([self logShouldRoll])
        NSLog(@"New log created today");
    NSString *logged = [NSString stringWithFormat:@"%@\t%f\t%f\n",
                        [[NSDate date] description],
                        coordinates.x,
                        coordinates.y];
    
    [self initWithNameAndDirectory:@"Mouse_" directory:@"Mouse"];
    fprintf(log, [logged UTF8String]);
    fflush(log);
}

- (void)logScreenShot:(CGImageRef)screenShot {
    NSString *path = [self initWithNameAndDirectory:@"ScreenShots_" directory:@"ScreenShots"];
    [self writeCGImage:screenShot toFile:[path stringByAppendingPathExtension:@"png"]];
}

- (void)logSystemSnapshot:(NSMutableArray *)list {
    NSString *path = [self initWithNameAndDirectory:@"System_Snapshot_" directory:@"System_Snapshots"];
    [list writeToFile:[path stringByAppendingPathExtension:@"plist"] atomically:NO];
}


#pragma mark -
#pragma mark Helper Functions

//  if application listed in process list is also in Applications or 
//  /Developer/Applications folder, keep it in the process list
- (NSMutableArray *)compareAppFolderToProcess:(NSMutableArray *)processList {
    NSArray *userAppList = [NSArray arrayWithArray:[self scanAppFolder]];
    NSMutableArray *markedForDeletion = [NSMutableArray array];
    NSString *nameFromProcess;
    
    for(id dictEntry in processList) {
        nameFromProcess = [dictEntry objectForKey:@"kCGWindowOwnerName"];
        if( (![userAppList containsObject:nameFromProcess]) ) {
            [markedForDeletion addObject:dictEntry];
        }   
    }
    
    for(id target in markedForDeletion) {
        [processList removeObject:target];
    }
    
    return processList;
}

// (BOOL)logShouldRoll
//      - determines if new log file needs to be created 
- (BOOL)logShouldRoll {
    NSString *today = [[NSDate date] description];
    
    NSRange theRange;
    theRange.location = 0;
    theRange.length = 10;
    unichar *theDay = malloc((theRange.length)*(sizeof(unichar)));
    
    [today getCharacters:theDay range:theRange];
    today = [NSString stringWithCharacters:theDay length:sizeof(theDay)+6];
    
    free(theDay);
    if ([logDate isEqualToString:today])
        return FALSE;
    else {
        if ([[self logName] isEqualToString:@"Task_"])
            [self initPlist];
        else
            [self init];
        //[self logWithNewDate:today];
        return TRUE;
    }
}

// (void)logWithNewDate:(NSString *)newLogDate
//      - creates a new log by appending the new date newLogDate
- (void)logWithNewDate:(NSString *)newLogDate {
    fclose(log);
    
    // Create directory path
    NSString *directory = [self pathOfCreatedDirectory];
    
    // Create current log file
    [self todaysDate];
    NSString *path = [directory stringByAppendingPathComponent:[[self logName]
                                                                stringByAppendingString:[newLogDate
                                                                                         stringByAppendingString:@".log"]]];
    log = fopen([path fileSystemRepresentation], "a");
}

// (NSString *)pathOfCreatedDirectory
//      - creates a directory and returns the path to it
- (NSString *)pathOfCreatedDirectory {
    NSString *directory = [@"~/Library/Logs/Discipline/Log/" stringByStandardizingPath];
    directory = [directory stringByAppendingPathComponent:[self logDirectory]];
    
    if ([[directory lastPathComponent] isEqualToString:@"Tasks"]) {
        directory = [directory stringByDeletingLastPathComponent];
        directory = [directory stringByDeletingLastPathComponent];
        directory = [directory stringByAppendingPathComponent:@"Tasks"];
    }
    
    // Create directory
    [[NSFileManager defaultManager] 
     createDirectoryAtPath:[directory stringByStandardizingPath]
     withIntermediateDirectories:YES attributes:nil error:nil];
    
    return directory;
}

//  gets list of applications from Applications and /Developer/Applications folder
- (NSArray *)scanAppFolder {
    BOOL isDir = NO;
    NSFileManager *theDefaultMan = [NSFileManager defaultManager];
    NSString *appPath = [@"/Applications" stringByStandardizingPath];
    NSString *devPath = [@"/Developer/Applications" stringByStandardizingPath];
    NSArray *appPathNames = [theDefaultMan contentsOfDirectoryAtPath:appPath error:nil];
    NSArray *devPathNames = [theDefaultMan contentsOfDirectoryAtPath:devPath error:nil];
    NSArray *subpathContents;
    NSMutableArray *appPathWithoutApp = [NSMutableArray arrayWithCapacity:[appPathNames count]];
    NSMutableArray *devPathWithoutApp = [NSMutableArray arrayWithCapacity:[devPathNames count]];

    //  Check /Applications folder
    for(NSString *name in appPathNames) {
        [appPathWithoutApp addObject:[name stringByDeletingPathExtension]];
        if ([theDefaultMan fileExistsAtPath:[appPath stringByAppendingPathComponent:name] isDirectory:&isDir] && isDir) {
            subpathContents = [theDefaultMan contentsOfDirectoryAtPath:[appPath stringByAppendingPathComponent:name] 
                                                                 error:nil];
            for(id subName in subpathContents) {
                [appPathWithoutApp addObject:[subName stringByDeletingPathExtension]];
            }
            isDir = NO;
        }
    }
    
    //  Check /Developer/Applications folder
    for(NSString *devName in devPathNames) {
        [devPathWithoutApp addObject:[devName stringByDeletingPathExtension]];
        if ([theDefaultMan fileExistsAtPath:[devPath stringByAppendingPathComponent:devName] isDirectory:&isDir] && isDir) {
            subpathContents = [theDefaultMan contentsOfDirectoryAtPath:[devPath stringByAppendingPathComponent:devName] 
                                                                 error:nil];
            for(id subName in subpathContents) {
                [devPathWithoutApp addObject:[subName stringByDeletingPathExtension]];
            }
            isDir = NO;
        }        
    }
    
    [appPathWithoutApp addObjectsFromArray:devPathWithoutApp];
    NSArray *finalListOfApps = [NSArray arrayWithArray:appPathWithoutApp];

    return finalListOfApps;
}

// (NSString *)todaysDate
//      - sets logDate. Is of the form YYYY-MM-DD
- (NSString *)todaysDate {
    NSString *theDate;
    NSRange theRange;
    theRange.location = 0;
    theRange.length = 10;
    unichar *str = malloc((theRange.length)*(sizeof(unichar)));
    
    // Sets current date of log
    NSDate *currentDate = [NSDate date];
    theDate = [currentDate description];
    [theDate getCharacters:str range:theRange];
    theDate = [NSString stringWithCharacters:str length:sizeof(str)+6];
    free(str);
    return theDate;
}

@end


