//
//  DebrieferQuestionViewController.m
//  Debriefer
//
//  Created by Joseph Subida on 5/23/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import "DebrieferLogger.h"
#import "DebrieferQuestionData.h"
#import "DebrieferTasks.h"

#import "DebrieferQuestionViewController.h"

@interface NSWindow (animationTime)

- (NSTimeInterval)animationResizeTime:(NSRect)newWindowFrame;

@end

@implementation NSWindow (animationTime)

- (NSTimeInterval)animationResizeTime:(NSRect)newWindowFrame {
    return (NSTimeInterval)0.5;
}

@end


#pragma mark -

@implementation DebrieferQuestionViewController

@synthesize debrieferDataList, taskFileList, theIcons, 
            questionData, dataToLog, totalQNumber, remainQNumber, theFactor;

//  *************************************************************************************************
- (id)initWithDate:(NSString *)dateToInitWith {
    if (![super initWithNibName:@"DebrieferQuestionView" bundle:nil])
        return nil;
    
    //  retrieve list of files to debrief with
    taskFileList = [[[DebrieferTasks alloc] initWithDate:dateToInitWith] taskFileList];
    
    //  initialize DebrieferQuestionData object for each file
    NSArray *questionDataArray = [self createDebrieferDataArray:dateToInitWith];
    questionData = [[DebrieferQuestionData alloc] initWithQuestionData:[questionDataArray objectAtIndex:0]];
    debrieferDataList = [[NSMutableArray alloc] initWithArray:questionDataArray];
    
    dataToLog = [[DebrieferLogger alloc] init];
    
    theIcons = [[NSMutableDictionary alloc] init];
    theFactor = 0;
    [self setRepresentedObject:questionData];
    [appsDisplayed setTabKeyTraversesCells:YES];
    [NSApp setDelegate:self];
    return self;
}


//  *************************************************************************************************
- (void)dealloc {
    [taskFileList release];
    [theIcons release];
    [debrieferDataList release];
    [questionData release];
    [dataToLog release];
    [super dealloc];
}

//  *************************************************************************************************
- (void)awakeFromNib {
    
    [self updateQuestionCounter];
    [self updateProgress];
    [[noneDisplayed selectedCell] setBackgroundStyle:NSBackgroundStyleLight];
    [noneDisplayed setState:NSOffState];
    [nextButton setEnabled:NO];
    
    //  create datePrompt, timePrompt, and taskPrompt
    [self displayPrompts];
    
    //  create appsDisplayed
    [self displayApplications];
    
    NSInteger matrixHeight = [appsDisplayed frame].size.height;
    
    if (theFactor != matrixHeight) {
        [self reloadViewBasedOn:(matrixHeight - theFactor)];
        theFactor = matrixHeight;
    }
        
    [NSTimer scheduledTimerWithTimeInterval:0.25f
                                     target:self
                                   selector:@selector(transition1:)
                                   userInfo:nil
                                    repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.25f
                                     target:self
                                   selector:@selector(transition2:)
                                   userInfo:nil
                                    repeats:NO];
    
}

#pragma mark -
#pragma mark User Actions

//  *************************************************************************************************
- (IBAction)appNameClicked:(id)sender {
    
    if ([[[sender selectedCell] title] rangeOfString:@"Radio"].length > 0)
        return;
    
    NSString *selectedCellTitle;
    
    //  app name selected
    if ([sender respondsToSelector:@selector(deselectAllCells)]) { 
        if ([noneDisplayed state] == NSOnState) {
            [dataToLog resetApps];
            [[noneDisplayed selectedCell] setBackgroundStyle:NSBackgroundStyleLight];
            [noneDisplayed setState:NSOffState];
        }
        selectedCellTitle = [[sender selectedCell] title];
    }
    
    //  none is selected
    else {  
        //  none is now on
        if ([noneDisplayed state] == NSOnState) { 
            [dataToLog resetApps];
            [appsDisplayed deselectAllCells];
            for (id cell in [appsDisplayed cells])
                [cell setBackgroundStyle:NSBackgroundStyleLight];
            selectedCellTitle = [noneDisplayed title];   
        }
        else {
            selectedCellTitle = [noneDisplayed title];
        }
    }
    
    [self appToLog:selectedCellTitle];
    
    if ([[[dataToLog dataToLog] objectForKey:@"apps"] count] >= 1) {
        [nextButton setEnabled:YES];
    }
    else {
        [nextButton setEnabled:NO];
    }
    
}

//  *************************************************************************************************
- (IBAction)nextButtonClicked:(id)sender {
    
    [dataToLog logData:[NSString stringWithFormat:@"%d", [questionData daysAgo]] forKey:@"daysAgo"];
    [dataToLog writeToFile];
    [dataToLog resetApps];
    
    //  If there are more tasks in questionData, remove current task from it so that
    //  task at index 1 will be the current task
    if ([[questionData taskList] count] > 1) {
        [questionData removeDataForTask:[[taskPrompt cell] title]];
        [self loadNextTask];
    }
    
    //  If there are no more tasks in questionData and there is one or more
    //  debrieferData items, load a new day
    else if ([debrieferDataList count] > 1 /* && ([[questionData taskList] count] == 1) */) { 
        [debrieferDataList removeObjectAtIndex:0];
        [questionData release];
        questionData = [[DebrieferQuestionData alloc] initWithQuestionData:[debrieferDataList objectAtIndex:0]];
        [self loadNextTask];
    }
    
    //  Else we have nothing else to ask!
    else {       
        NSLog(@"We done");
        NSRunInformationalAlertPanel(@"Done!", @"That wasn't so bad, was it?", @"Yep", nil, nil);
        [[[self view] window] performClose:self];
    }
    [nextButton setEnabled:NO];
    
}


#pragma mark -
#pragma mark Helper Functions


//  *************************************************************************************************
- (void)appToLog:(NSString *)appName {
    
    NSNumber *appID;
    if ([appName rangeOfString:@"None - "].length > 0)
        appID = [NSNumber numberWithInt:1234];
    else
        appID = [[[[questionData appsList] objectAtIndex:0] objectForKey:@"appsIDs"] objectForKey:appName];
    [dataToLog logApp:[appID stringValue]];
    
}

//  *************************************************************************************************
- (NSArray *)createDebrieferDataArray:(NSString *)withDate {
    NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
    
    int i;
    for (i=0; i<[taskFileList count]; i++) {
        [returnArray addObject:
         [[DebrieferQuestionData alloc] initWithFile:[taskFileList objectAtIndex:i] sinceNow:i withDate:withDate]];
        withDate = [self retrieveYesterday:withDate];
        [[returnArray objectAtIndex:i] shuffleTasks];
    }
    return returnArray;
}

//  *************************************************************************************************
- (void)displayApplications {
    NSArray *apps = [[[questionData appsList] objectAtIndex:0] objectForKey:@"apps"];
    NSInteger numberOfCols, numberOfRows;
    int i, j;
    
    numberOfRows = [apps count]/4 + ([apps count] % 2);
    if ([apps count] > 4)
        numberOfCols = 4;
    else
        numberOfCols = [apps count];
    
    [appsDisplayed renewRows:1 columns:1];
    for (i=0; i<numberOfRows-1; i++)
        [appsDisplayed addRow];
    for (j=0; j<numberOfCols-1; j++) {
        [appsDisplayed addColumn];
    }
    
    [self retrieveApplicationIcons];

    i=0, j=0;
    for (NSString *appName in apps) {
        if (j == numberOfCols) {
            j=0;
            i++;
        }
        
        NSSize theSize;
        theSize.width = 130;
        theSize.height = 75;
        [appsDisplayed setAutosizesCells:YES];
        [appsDisplayed setCellSize:theSize];
        [[appsDisplayed cellAtRow:i column:j] setGradientType:NSGradientConvexStrong];
        [[appsDisplayed cellAtRow:i column:j] setTransparent:NO];
        [[appsDisplayed cellAtRow:i column:j] setBordered:YES];
        [[appsDisplayed cellAtRow:i column:j] setBezeled:YES];
        [[appsDisplayed cellAtRow:i column:j] setHighlightsBy:NSRoundRectBezelStyle];
        [[appsDisplayed cellAtRow:i column:j] setShowsStateBy:NSChangeBackgroundCellMask];
        [[appsDisplayed cellAtRow:i column:j] setTitle:appName];
        [[appsDisplayed cellAtRow:i column:j] setImage:[theIcons objectForKey:appName]];
        j++;
    }
    [appsDisplayed setAlphaValue:0.0];
    [appsDisplayed sizeToCells];
    [appsDisplayed display];
}

//  *************************************************************************************************
- (void)displayPrompts {
    NSString *task = [[[questionData taskList] objectAtIndex:0] objectForKey:@"task"];
    NSString *date = [[[questionData taskList] objectAtIndex:0] objectForKey:@"date"];
    NSString *time = [[[questionData appsList] objectAtIndex:0] objectForKey:@"time"];
    if ( (date == nil) || (time == nil) ) {
        NSLog(@"you're nil: date - %@ time %@", date, time);
    }
    if ([task isEqualToString:@""])
        task = @"---Nothing. Way to be productive!---";
    date = [self prettyPrintDate:date];
    time = [self prettyPrintTime:time];
    
    [taskPrompt setTitleWithMnemonic:task];
    [taskPrompt setFont:[NSFont boldSystemFontOfSize:13.0]];
    [taskPrompt setAlphaValue:0.0];

    [datePrompt setTitleWithMnemonic:[NSString stringWithFormat:@"%@ at %@", date, time]];
    [datePrompt setFont:[NSFont boldSystemFontOfSize:17.0]];
    [datePrompt setAlphaValue:0.0];
//    [timePrompt setTitleWithMnemonic:time];
//    [timePrompt setFont:[NSFont boldSystemFontOfSize:17.0]];
//    [timePrompt setAlphaValue:0.0];
    
}

//  *************************************************************************************************
- (void)initMatrix {
    
    //  clear matrix
    int i, appsNum = [appsDisplayed numberOfRows];
    for (i=1; i<appsNum; i++) {
        [appsDisplayed removeRow:1];
    }
    [appsDisplayed deselectAllCells];
}

//  *************************************************************************************************
- (void)loadNextQuestion {
    if ([[questionData taskList] count] == 0)
        NSLog(@"You little trickster, you");
    else {
        [self setRepresentedObject:questionData];
        [self initMatrix];
        [self awakeFromNib];
    }
}

//  *************************************************************************************************
- (void)loadNextTask {
    //  Make sure we didn't do anything screwy. Then load the next task
    if ([[questionData taskList] count] == 0)
        [self nextButtonClicked:nil];
    else
        [self loadNextQuestion];
}

//  *************************************************************************************************
- (NSString *)prettyPrintDate:(NSString *)uglyDate {
    NSDate *theUglyDate = [NSDate dateWithString:uglyDate];
    NSString *prettyDate;

    NSDateFormatter *formatterForLog = [[NSDateFormatter alloc] init];
    [formatterForLog setDateFormat:@"MM/dd/yy"];
    prettyDate = [formatterForLog stringFromDate:theUglyDate];
    [dataToLog logData:prettyDate forKey:@"date"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    prettyDate = [formatter stringFromDate:theUglyDate];
    
    [formatter release];
    [formatterForLog release];
    
    return prettyDate;
}

//  *************************************************************************************************
- (NSString *)prettyPrintTime:(NSString *)uglyTime {
    
    NSDate *theUglyTime = [NSDate dateWithNaturalLanguageString:uglyTime];
    NSString *prettyTime;
    
    NSDateFormatter *formatterForLog = [[NSDateFormatter alloc] init];
    [formatterForLog setDateFormat:@"HH:mm:ss"];
    prettyTime = [formatterForLog stringFromDate:theUglyTime];
    [dataToLog logData:prettyTime forKey:@"time"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    prettyTime = [formatter stringFromDate:theUglyTime];

    [formatter release];
    [formatterForLog release];
    return prettyTime;    
}

//  *************************************************************************************************
- (void)reloadViewBasedOn:(NSInteger)factor {
    NSWindow *theWindow = [[self view] window];
    BOOL ended = [theWindow makeFirstResponder:theWindow];
    if (!ended) {
        return;
    }
    NSView *theView = [self view];
    
    //  Compute the new window frame
    NSSize currentSize = [[theWindow contentView] frame].size;
    NSSize newSize = [theView frame].size;
    newSize.height += factor;
    float deltaWidth = newSize.width - currentSize.width;
    float deltaHeight = newSize.height - currentSize.height;
    NSRect windowFrame = [theWindow frame];
    windowFrame.size.height += deltaHeight;
    windowFrame.origin.y -= deltaHeight;
    windowFrame.size.width += deltaWidth;
    
    [theWindow setFrame:windowFrame
                display:YES
                animate:YES];
    [theWindow setContentView:theView];
}

//  *************************************************************************************************
- (void)retrieveApplicationIcons {
    
    NSSize iconSize;
    iconSize.width = 50.0;
    iconSize.height = 50.0;
    
    for (id appData in [questionData appsList]) {
        if ([[appData allKeys] count] == 4) {
            
            //  get application paths from question data
            NSDictionary *applicationPaths = [appData objectForKey:@"appPaths"];
            NSArray *applicationNames = [applicationPaths allKeys];
            
            for (NSString *key in applicationNames) {
                
                //  if not already, store application icon in memory
                if (![[theIcons allKeys] containsObject:key]) {
                    //  get application's Info.plist
                    NSString *infoPath = 
                    [[applicationPaths objectForKey:key] stringByAppendingString:@"/Contents/Info.plist"];
                    if (![[NSFileManager defaultManager] fileExistsAtPath:[infoPath stringByStandardizingPath]]) {
                        NSLog(@"Error: retrieveApplicationIcons - file does not exist");
                    }
                    else {
                        //  get icon name: "CFBundleIconFile"
                        NSString *iconName = [self retrieveIconNameAtPath:infoPath];
                        
                        //  look in /Contents/Resources for icon name
                        NSString *iconPath = [[[infoPath stringByDeletingLastPathComponent]
                                               stringByAppendingPathComponent:@"Resources"]
                                              stringByAppendingPathComponent:iconName];
                        if ([[NSFileManager defaultManager] fileExistsAtPath:iconPath]) {
                            NSImage *iconImage = [[NSImage alloc] initWithContentsOfFile:iconPath];
                            [iconImage setSize:iconSize];
                            [theIcons setObject:iconImage forKey:key];
                            [iconImage release];
                        }
                        //  if icon name is not there, enumerate through whole directory /(appname).app/Contents
                        else {
                            NSLog(@"Error: retrieveApplicationIcons - icon not in /Contents/Resources/");
                        }
                    }
                }
            }
        }
        else {
            //  just show application name
        }
    }

//    if ([[NSFileManager defaultManager] fileExistsAtPath:
//         [@"/Applications/iTunes.app/Contents/Info.plist" stringByStandardizingPath]]) {
//        NSLog(@"it exists!");
//        NSData *plistXML = [[NSFileManager defaultManager] 
//                            contentsAtPath:[@"/Applications/iTunes.app/Contents/Info.plist" stringByStandardizingPath]]; 
//        NSDictionary *infoPlist = (NSDictionary *)[NSPropertyListSerialization 
//                                                   propertyListFromData:plistXML 
//                                                   mutabilityOption:NSPropertyListImmutable
//                                                   format:&format errorDescription:&errorDesc];
//        NSLog(@"application icon: %@", [infoPlist objectForKey:@"CFBundleIconFile"]);
//        NSData *iconData = [NSData dataWithContentsOfFile:@"/Applications/iTunes.app/Contents/Resources/iTunes.icns"];
//        NSImage *iconImage = [[NSImage alloc] initWithContentsOfFile:@"/Applications/iTunes.app/Contents/Resources/iTunes.icns"];
//        [appIcon setImage:iconImage];
//    }
//    else {
//        NSLog(@"it doesn't exist!");
//    }
}

//  *************************************************************************************************
- (NSString *)retrieveIconNameAtPath:(NSString *)iconPath {
    NSString *errorDesc = nil; 
    NSPropertyListFormat format;
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:iconPath];
    NSDictionary *infoPlist = (NSDictionary *)[NSPropertyListSerialization 
                                               propertyListFromData:plistXML 
                                               mutabilityOption:NSPropertyListImmutable
                                               format:&format errorDescription:&errorDesc];
    NSString *iconName = [infoPlist objectForKey:@"CFBundleIconFile"];
    if ([[iconName pathExtension] length] <= 0)
        iconName = [iconName stringByAppendingPathExtension:@"icns"];
    return iconName;
}

//  *************************************************************************************************
- (NSString *)retrieveYesterday:(NSString *)today {
    NSDate *dateToday = [NSDate dateWithNaturalLanguageString:today];
    NSTimeInterval timeTillYest = -86400.0;
    NSDate *dateYesterday = [dateToday initWithTimeInterval:timeTillYest sinceDate:dateToday];
    return [dateYesterday description];
}

//  *************************************************************************************************
- (void)transition1:(NSTimer *)theTimer {
    
//    [NSAnimationContext beginGrouping];
//    [[NSAnimationContext currentContext] setDuration:1.15f];
    
    [[datePrompt animator] setAlphaValue:1.0];
    [[taskPrompt animator] setAlphaValue:1.0];
//    [[timePrompt animator] setAlphaValue:1.0];
    
//    [NSAnimationContext endGrouping];
    
}

//  *************************************************************************************************
- (void)transition2:(NSTimer *)theTimer {
//    int i, j;
//    for (i=0; i<[appsDisplayed numberOfRows]; i++) {
//        for (j=0; j<[appsDisplayed numberOfColumns]; j++) {
//            [[[appsDisplayed cellAtRow:i column:j] animator] setAlphaValue:1.0];
//        }
//    }
    [[appsDisplayed animator] setAlphaValue:1.0];
}

//  *************************************************************************************************
- (void)updateProgress {
    [progress setIndeterminate:NO];
    [progress incrementBy:((100.0/(totalQNumber + remainQNumber))+0.1)];
}

//  *************************************************************************************************
- (void)updateQuestionCounter {
    
    if (!remainQNumber) {
        remainQNumber = 1;
        totalQNumber = 0;
        
        for (id dataObject in debrieferDataList) {
            totalQNumber += [[dataObject taskList] count];
        }
    }
    else {
        remainQNumber += 1;
    }
    
    [questionCounter setTitleWithMnemonic:
     [NSString stringWithFormat:@"%d/%d", remainQNumber, totalQNumber]];
    
}

//  *************************************************************************************************
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end
