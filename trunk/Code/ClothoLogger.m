//
//  ClothoLogger.m
//  Moirae
//
//  Created by Joseph Subida on 2/9/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import "ClothoLogger.h"

@implementation ClothoLogger

@synthesize logDate, logPath, theBuffer;

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
    theBuffer = [[NSMutableArray alloc] init];

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

- (id)initWithNameAndDirectory:(NSString *)nameOfLog 
                     directory:(NSString *)directoryOfLog 
                       forDate:(NSDate *)dateToUse {
    NSString *directory = [@"~/Library/Logs/Discipline/Log/" stringByStandardizingPath];
    directory = [directory stringByAppendingPathComponent:directoryOfLog];
    [self setLogPath:directory];
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
    else if ([nameOfLog isEqualToString:@"System_Snapshot_"]) {
        path = [directory stringByAppendingPathComponent:
                [nameOfLog stringByAppendingString:[dateToUse description]]];
        return path;
    }
    else {
        path = [directory stringByAppendingPathComponent:
                [nameOfLog stringByAppendingString:[[NSDate date] description]]];
        return path;        
    }
}

- (void) dealloc {
    fclose(log);
    [logDate release];
    [logPath release];
    [theBuffer release];
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
    
    //  check if we should create a new log file for the new day
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
//    NSLog(@"Data logged: %@", theData);
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
    
    [self initWithNameAndDirectory:@"Mouse_" directory:@"Mouse" forDate:nil];
    fprintf(log, [logged UTF8String]);
    fflush(log);
}

- (void)logScreenShot:(CGImageRef)screenShot {
    NSString *path = [self initWithNameAndDirectory:@"ScreenShots_" directory:@"ScreenShots" forDate:nil];
    [self writeCGImage:screenShot toFile:[path stringByAppendingPathExtension:@"png"]];
}

- (void)logSystemSnapshot:(NSMutableArray *)list forDate:(NSDate *)dateToLog {
    BOOL isDir;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateFormatter stringFromDate:dateToLog];
    
    NSString *path = [self initWithNameAndDirectory:@"System_Snapshot_" 
                                          directory:@"System_Snapshots"
                                            forDate:dateToLog];
    NSString *dirPath = 
    [[path stringByDeletingLastPathComponent] 
     stringByAppendingPathComponent:[@"System_Snapshots_" stringByAppendingString:today]];
    
    //  if the directory exists, then just write the file into it
    if ([[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir] 
        && isDir == YES) {
        // cool. now write to that directory...
    }
    //  else make the directory then write the file into it
    else {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath 
                                                   attributes:nil];
    }
    
    NSString *filePath = [[dirPath stringByAppendingPathComponent:[path lastPathComponent]]
                          stringByAppendingPathExtension:@"plist"];
    [list writeToFile:filePath atomically:NO];
        
    //        [self moveFilesToFolderForDate:logDate];

    [dateFormatter release];
}


#pragma mark -
#pragma mark Helper Functions

- (NSArray *)optionNotOnScreen:(NSMutableArray *)runningApps {
    NSArray *allApps = [NSArray arrayWithArray:
                        [[runningApps objectAtIndex:0] objectForKey:@"OptionAll"]];
    NSSet *onScreenOnly = [NSSet setWithArray:
                           [[runningApps objectAtIndex:1] objectForKey:@"OptionOnScreenOnly"]];
    NSMutableArray *notOnScreen = [[[NSMutableArray alloc] init] autorelease];
    for (id appName in allApps) {
        if (![onScreenOnly containsObject:appName])
            [notOnScreen addObject:appName];
    }
    return notOnScreen;
}

- (NSMutableArray *)changeWindowName:(NSMutableArray *)arrayOfSnapshots {
    NSMutableArray *arrayToReturn = [NSMutableArray array];
    BOOL somethingNotDone = YES;
    for (id element in arrayOfSnapshots) {
        NSString *hashedWindowName = [element objectForKey:@"kCGWindowName"];

        if ( ([[element objectForKey:@"kCGWindowName"] isEqualToString:@""]) || 
            ([element objectForKey:@"kCGWindowName"] == nil) ) {
            [arrayToReturn addObject:[NSDictionary dictionaryWithDictionary:element]];
            somethingNotDone = NO;
        }
        else {
            NSData *hashData = [hashedWindowName dataUsingEncoding:NSUTF8StringEncoding];
            hashedWindowName = 
            [[hashData description] stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSMutableDictionary *elementChanged = [NSMutableDictionary dictionaryWithDictionary:element];
            [elementChanged setObject:hashedWindowName forKey:@"kCGWindowIdent"];
            [elementChanged removeObjectForKey:@"kCGWindowName"];
            [arrayToReturn addObject:elementChanged];
            somethingNotDone = NO;
        }
        
        if (somethingNotDone) {
            [arrayToReturn addObject:[NSDictionary dictionaryWithDictionary:element]];
        }
        somethingNotDone = YES;
    }
    return arrayToReturn;
}
//  if application listed in process list is also in Applications or 
//  /Developer/Applications folder, keep it in the process list
- (NSMutableArray *)compareAppFolderToProcess:(NSMutableArray *)processList {
    
    //  get all application names. last object in userAppList will be a dictionary of
    //  the application names and their paths
    NSMutableArray *userAppList = [NSMutableArray arrayWithArray:[self scanAppFolder]];
    NSDictionary *appPaths = [userAppList lastObject];
    [userAppList removeLastObject];
    
    NSMutableArray *markedForDeletion = [NSMutableArray array];
    NSMutableDictionary *markedToAdd = [NSMutableDictionary dictionary];
    NSString *nameFromProcess;
    int i = 0;
    
    for(id dictEntry in processList) {
        nameFromProcess = [dictEntry objectForKey:@"kCGWindowOwnerName"];
        if( (![userAppList containsObject:nameFromProcess]) ) {

            BOOL isNotFound = YES;
            for (NSString *appName in userAppList) {
                
                if ( ([appName rangeOfString:nameFromProcess].length > 0) 
                    || ([nameFromProcess rangeOfString:appName].length > 0) ) {
                    [markedToAdd setObject:[appPaths objectForKey:appName] 
                                    forKey:nameFromProcess];
                    isNotFound = NO;
                    break;
                }
                
            }
                if (isNotFound)
                    [markedForDeletion addObject:dictEntry];                

        }
        else {
            [markedToAdd setObject:[appPaths objectForKey:nameFromProcess] 
                            forKey:nameFromProcess];
        }
        i++;
    }
    
    for(id target in markedForDeletion) {
        [processList removeObject:target];
    }
    [processList addObject:[NSDictionary dictionaryWithObject:markedToAdd forKey:@"ApplicationPaths"]];
    
    return processList;
}

// for on screen only and given an array of NSDictionaries, returns an 
// array of NSDictionaries that contain only the key-value pairs specified by keyList
- (NSMutableArray *)filterArrayWithOptions:(NSMutableArray *)processList 
                                   options:(NSArray *)keyList {
    
    NSMutableArray *arrayToReturn = [[[NSMutableArray alloc] init] autorelease];
    int i;
    // using for-loop instead of fast enumeration because we need to preserve
    // ordering from front to back
    for (i=0; i<[processList count]; i++) {
        NSMutableDictionary *processDict = [[NSMutableDictionary alloc] init];
        int j;
        
        //  go through all of the keys in keyList
        for (j=0; j<[keyList count]; j++) {
            NSString *theKey = [keyList objectAtIndex:j];
            [processDict setObject:[[processList objectAtIndex:i] objectForKey:theKey] 
                            forKey:theKey];
        }
//        [arrayToReturn addObject:processDict];
        
        // set up theBuffer for ProcessWatcher
        if ([[[processList objectAtIndex:i] objectForKey:@"kCGWindowIdent"] length] == 0) {
            if ([[[processList objectAtIndex:i] 
                  objectForKey:@"kCGWindowOwnerName"] isEqualToString:@"Finder"]) {
                [processDict setObject:@"-=desktop=-" forKey:@"kCGWindowIdent"]; 
            }
            else {
                [processDict setObject:@"NO NAME" forKey:@"kCGWindowIdent"]; 
            }
        }
        else {
            [processDict setObject:[[processList objectAtIndex:i] objectForKey:@"kCGWindowIdent"] 
                            forKey:@"kCGWindowIdent"];
        }
        [[self theBuffer] addObject:processDict];
        [arrayToReturn addObject:processDict];
        [processDict release];
    }
    
    NSDictionary *bufferDict = [NSDictionary dictionaryWithObject:[self theBuffer] 
                                                           forKey:@"OnScreenUpdate"];
                                
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnScreenUpdate" 
                                                        object:self 
                                                      userInfo:bufferDict];
    
    return arrayToReturn;
}

- (NSString *)hashString:(NSString *)inputString {
    
    NSData *hashData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *hashedWindowName = 
    [[hashData description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return hashedWindowName;
    
//    NSString *hashedWindowName = @"";
    NSString *hashCommand = 
    [[@"do shell script \"md5 -s " 
      stringByAppendingString:inputString] 
     stringByAppendingString:@"\""];
    NSAppleScript *hashWindowName = [[NSAppleScript alloc] initWithSource:hashCommand];
    NSDictionary *errorDict = [NSDictionary dictionary];
    
    if (![hashWindowName isCompiled]) {
        [hashWindowName compileAndReturnError:&errorDict];
        //            NSLog(@"Clotho Logger - Compile hash script: %@", erro);
    }
    
    NSAppleEventDescriptor *hashResult = [hashWindowName executeAndReturnError:&errorDict];
    //        NSLog(@"Clotho Logger - Execute hash script: %@", [hashResult stringValue]);
    [hashWindowName release];
    
    if (hashResult != nil) {
        hashedWindowName = [[[hashResult stringValue] componentsSeparatedByString:@"= "] objectAtIndex:1];
    }
    else {
        hashedWindowName = @"";
    }
    if ([errorDict count] > 0) {
        NSLog(@"BEGIN ERROR--------------------------");
        for (NSString *key in [errorDict allKeys]) {
            NSLog(@"%@", [errorDict objectForKey:key]);
        }
        NSLog(@"END ERROR----------------------------");
    }
    return hashedWindowName;
        
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

// (void)moveFilesToFolderForDate:(NSString *)theDate
//      - creates a new folder for theDate and moves the files that have
//        theDate in the file's name into the new folder
- (void)moveFilesToFolderForDate:(NSString *)theDate {
    //  create date to append to folder name
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //  create source path, target path, and new folder
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager directoryContentsAtPath:logPath];
    NSString *originalPath = [NSString stringWithString:logPath];
    NSString *targetPath = [[logPath stringByAppendingPathComponent:
                            [[self logName] stringByAppendingString:
                             [dateFormatter stringFromDate:
                              [NSDate dateWithNaturalLanguageString:
                               [self logDate]]]]] stringByStandardizingPath];
    [fileManager createDirectoryAtPath:targetPath 
           withIntermediateDirectories:NO 
                            attributes:nil 
                                 error:nil];
    
    //  move files to new folder that contain theDate in the file's name
    for (NSString *file in directoryContents) {
        BOOL isDir;
        NSString *sourcePath = [originalPath stringByAppendingPathComponent:file];
        if ([fileManager fileExistsAtPath:sourcePath isDirectory:&isDir] 
            && [file rangeOfString:theDate].length
            && !isDir) {
            NSError *err;
            if(![fileManager moveItemAtPath:sourcePath
                                     toPath:[targetPath stringByAppendingPathComponent:file] 
                                      error:&err]) {
                NSLog(@"%@",[err localizedFailureReason]);
                NSLog(@"%@",[err localizedDescription]);
            }
        }
    }
    [dateFormatter release];
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

//  gets list of application names from /Applications and /Developer/Applications folder
- (NSArray *)scanAppFolder {
    BOOL isDir = NO;
    NSFileManager *theDefaultMan = [NSFileManager defaultManager];
    NSString *appPath = [@"/Applications" stringByStandardizingPath];
    NSString *devPath = [@"/Developer/Applications" stringByStandardizingPath];
    NSArray *appNames = [theDefaultMan contentsOfDirectoryAtPath:appPath error:nil];
    NSArray *devAppNames = [theDefaultMan contentsOfDirectoryAtPath:devPath error:nil];
    NSArray *subpathContents;
    NSArray *subSubpathContents;
    NSMutableDictionary *appPathDict = [NSMutableDictionary dictionary];
    NSMutableArray *appPathWithoutApp = [NSMutableArray arrayWithCapacity:[appNames count]];
    NSMutableArray *devPathWithoutApp = [NSMutableArray arrayWithCapacity:[devAppNames count]];

    //  Check /Applications folder
    for(NSString *appName in appNames) {
        
        //  If the file we're looking at is an app, we're done
        if ([[appName pathExtension] isEqualToString:@"app"]) {
            [appPathWithoutApp addObject:[appName stringByDeletingPathExtension]];
            [appPathDict setObject:[appPath stringByAppendingPathComponent:appName] 
                            forKey:[appName stringByDeletingPathExtension]];
        }
        
        //  Otherwise, if it's a folder, check it's contents
        else {
            
            NSString *subpath = [appPath stringByAppendingPathComponent:appName];
            if ([theDefaultMan fileExistsAtPath:subpath isDirectory:&isDir] && isDir) {
                
                subpathContents = [theDefaultMan contentsOfDirectoryAtPath:subpath 
                                                                     error:nil];
                for(id subName in subpathContents) {
                    
                    if ([[subName pathExtension] isEqualToString:@"app"]) {
                        
                        [appPathWithoutApp addObject:[subName stringByDeletingPathExtension]];
                        [appPathDict setObject:[subpath stringByAppendingPathComponent:subName] 
                                        forKey:[subName stringByDeletingPathExtension]];
                        
                    }
                    
                    else {
                        
                        NSString *subSubpath = [subpath stringByAppendingPathComponent:subName];                        
                        if ([theDefaultMan fileExistsAtPath:subSubpath
                                                 isDirectory:&isDir] && isDir) {
                        
                        subSubpathContents = [theDefaultMan contentsOfDirectoryAtPath:subSubpath 
                                                                                error:nil];
                        for (id subSubName in subSubpathContents) {
                            
                            if ([[subSubName pathExtension] isEqualToString:@"app"]) {
                                
                                [appPathWithoutApp addObject:[subSubName stringByDeletingPathExtension]];
                                [appPathDict setObject:[subSubpath stringByAppendingPathComponent:subSubName] 
                                                forKey:[subSubName stringByDeletingPathExtension]];
                            
                                }                        
                            }
                        }
                    } 
                }
                isDir = NO;
            }
        }
    }
    
    //  Check /Developer/Applications folder
    for(NSString *devName in devAppNames) {
        if ([[devName pathExtension] isEqualToString:@"app"]) {
            [devPathWithoutApp addObject:[devName stringByDeletingPathExtension]];
            [appPathDict setObject:[devPath stringByAppendingPathComponent:devName] 
                            forKey:[devName stringByDeletingPathExtension]];
        }
        else {
            NSString *subpath = [devPath stringByAppendingPathComponent:devName];
            if ([theDefaultMan fileExistsAtPath:subpath isDirectory:&isDir] && isDir) {
                subpathContents = [theDefaultMan contentsOfDirectoryAtPath:[devPath stringByAppendingPathComponent:devName] 
                                                                     error:nil];
                for(id subName in subpathContents) {
                    if ([[subName pathExtension] isEqualToString:@"app"]) {
                        [devPathWithoutApp addObject:[subName stringByDeletingPathExtension]];
                        [appPathDict setObject:[subpath stringByAppendingPathComponent:subName] 
                                        forKey:[subName stringByDeletingPathExtension]];
                    }
                }
                isDir = NO;
            }
        }
    }
    
    [appPathWithoutApp addObjectsFromArray:devPathWithoutApp];
    [appPathWithoutApp addObject:@"Finder"];
    [appPathDict setObject:@"/System/Library/CoreServices/Finder.app" 
                    forKey:@"Finder"];
    [appPathWithoutApp addObject:appPathDict];
    NSArray *finalListOfApps = [NSArray arrayWithArray:appPathWithoutApp];
    
    return finalListOfApps;
}

//- (NSDate *)formatDateToAppend:(NSString *)dateToAppend
                                                                                           
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


