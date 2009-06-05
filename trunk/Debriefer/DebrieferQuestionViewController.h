//
//  DebrieferQuestionViewController.h
//  Debriefer
//
//  Created by Joseph Subida on 5/23/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DebrieferLogger.h"
#import "DebrieferQuestionData.h"

@interface DebrieferQuestionViewController : NSViewController {
    IBOutlet NSProgressIndicator *progress;
    IBOutlet NSTextField *questionCounter;
    IBOutlet NSTextField *datePrompt;
    IBOutlet NSTextField *timePrompt;
    IBOutlet NSTextField *taskPrompt;
    IBOutlet NSMatrix *appsDisplayed;
    IBOutlet NSButton *noneDisplayed;
    IBOutlet NSButton *nextButton;
    
    NSMutableArray *debrieferDataList;
    NSArray *taskFileList;
    NSMutableDictionary *theIcons;
    NSInteger totalQNumber;
    NSInteger remainQNumber;
    NSInteger theFactor;
    
    DebrieferQuestionData *questionData;
    DebrieferLogger *dataToLog;
}

@property (nonatomic, retain) NSMutableArray *debrieferDataList;
@property (nonatomic, retain) NSArray *taskFileList;
@property (nonatomic, retain) NSMutableDictionary *theIcons;
@property (nonatomic, retain) DebrieferQuestionData *questionData;
@property (nonatomic, retain) DebrieferLogger *dataToLog;
@property (nonatomic, assign) NSInteger totalQNumber;
@property (nonatomic, assign) NSInteger remainQNumber;
@property (nonatomic, assign) NSInteger theFactor;

- (IBAction)appNameClicked:(id)sender;
- (IBAction)nextButtonClicked:(id)sender;

- (id)initWithDate:(NSString *)dateToInitWith;

- (void)appToLog:(NSString *)appName;
- (NSArray *)createDebrieferDataArray:(NSString *)withDate;
- (void)displayApplications;
- (void)displayPrompts;
- (void)initMatrix;
- (void)loadNextQuestion;
- (void)loadNextTask;
- (NSString *)prettyPrintDate:(NSString *)uglyDate;
- (NSString *)prettyPrintTime:(NSString *)uglyTime;
- (void)reloadViewBasedOn:(NSInteger)factor;
- (void)retrieveApplicationIcons;
- (NSString *)retrieveIconNameAtPath:(NSString *)iconPath;
- (NSString *)retrieveYesterday:(NSString *)today;
- (void)transition1:(NSTimer *)theTimer;
- (void)transition2:(NSTimer *)theTimer;
- (void)updateProgress;
- (void)updateQuestionCounter;

@end

