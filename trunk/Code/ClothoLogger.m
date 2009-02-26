//
//  ClothoLogger.m
//  Moirae
//
//  Created by Joseph Subida on 2/9/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import "ClothoLogger.h"

@implementation ClothoLogger

@synthesize logDate;

- (id)init {
    if (!(self = [super init]))
        return nil;
    
    // Create directory path
    NSString *directory = [self pathOfCreatedDirectory];
    
    // Create current log file
    [self todaysDate];
    NSString *path = [directory stringByAppendingPathComponent:[[self logName]
                                       stringByAppendingString:[logDate
                                       stringByAppendingString:@".log"]]];
    log = fopen([path fileSystemRepresentation], "a");
    return self;
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

// (NSString *)pathOfCreatedDirectory
//      - creates a directory and returns the path to it
- (NSString *)pathOfCreatedDirectory {
    NSString *directory = [@"~/Library/Logs/Discipline/Logs/" stringByStandardizingPath];
    //NSString *directory = [@"~/Desktop" stringByStandardizingPath];
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

// (NSString *)todaysDate
//      - sets logDate. Is of the form YYYY-MM-DD
- (NSString *)todaysDate {
    NSRange theRange;
    theRange.location = 0;
    theRange.length = 10;
    unichar *str = malloc((theRange.length)*(sizeof(unichar)));
    
    // Sets current date of log
    NSDate *currentDate = [NSDate date];
    self.logDate = [currentDate description];
    [self.logDate getCharacters:str range:theRange];
    self.logDate = [NSString stringWithCharacters:str length:sizeof(str)+6];
    free(str);
    return self.logDate;
}

#pragma mark -
#pragma mark Actions

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

    NSLog(@"today is: %@", today);
    free(theDay);
    if ([logDate isEqualToString:today])
        return FALSE;
    else {
        [self logWithNewDate:today];
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

// (void)logTask
//      - writes theData to the Task log file
- (void)logTask:(NSString *)theData {
    if ([self logShouldRoll])
        [self logRoll];
    fprintf(log, [theData UTF8String]);
    fflush(log);
    
    /******************* PLIST CODE ***********************
    NSString *errorDesc; 
    //NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Data" 
    //                                                       ofType:@"plist"]; 
    NSString *bundlePath = [@"~/Documents/xCode Projects/PropertyListExample/Resources/Data.plist" stringByStandardizingPath];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: 
                               [NSArray arrayWithObjects: personName, phoneNumbers, nil] 
                                                          forKeys:[NSArray arrayWithObjects: @"Name", @"Phones", nil]]; 
    NSData *plistData = [NSPropertyListSerialization 
                         dataFromPropertyList:plistDict 
                         format:NSPropertyListXMLFormat_v1_0 
                         errorDescription:&errorDesc]; 
    if (plistData) { 
        [plistData writeToFile:bundlePath atomically:YES]; 
    } 
    else { 
        NSLog(errorDesc); 
        [errorDesc release]; 
    } 
     */
}

// (void)logProcess
//      - writes theData to the Process log file
- (void)logProcess:(NSString *)theData {
    fprintf(log, [theData UTF8String]);
    fflush(log);
}

@end


