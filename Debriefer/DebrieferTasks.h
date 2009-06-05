//
//  DebrieferTasks.h
//  Debriefer
//
//  Created by Joseph Subida on 5/25/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DebrieferTasks : NSObject {
    NSArray *taskFileList;
}

@property(nonatomic,retain) NSArray *taskFileList;

- (id)initWithDate:(NSString *)dateToInitWith;

- (NSString *)createTaskFileNameFromDate:(NSString *)fileDate;
- (NSString *)formatAppendedDate:(NSString *)dateToFormat;
- (BOOL)isSunday:(NSString *)dateInQuestion;
- (NSArray *)retrieveTaskFilesStartingAtDate:(NSString *)chosenDate;

@end
