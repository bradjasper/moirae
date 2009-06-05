//
//  DebrieferMainView.m
//  Debriefer
//
//  Created by Joseph Subida on 5/23/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

//#import "DebrieferQuestionData.h"
//#import "DebrieferQuestionViewController.h"

#import "DebrieferQuestionViewController.h"

#import "DebrieferMainView.h"

@implementation DebrieferMainView

@synthesize questionVC;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    // Drawing code here.
}

- (void)dealloc {
    [questionVC release];
    [super dealloc];
}

- (void)awakeFromNib {
    [self initView];
}

//  sets up both cells to today's and yesterday's date, allows empty 
//  selection, deselect all cells
- (void)initDateMatrix {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle]; // e.g. Monday, November 17, 1987
    [formatter setTimeStyle:NSDateFormatterNoStyle]; //  no time displayed
    
    [dateToday setTitle:[formatter stringFromDate:[NSDate date]]];
    [dateYesterday setTitle:
     [formatter stringFromDate:
      [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval)-86400.0]]];
    
    [datePicker setAllowsEmptySelection:YES];
    [datePicker deselectAllCells];
    
    [formatter release];
}

//  add other things here if you want to mess around with the main view
- (void)initView {
    [self initDateMatrix];
}

//  returns whether a file with the chosen date in it's name exists
- (BOOL)checkDate:(NSString *)chosenDate {
    NSString *formattedChosen = [self formatAppendedDate:chosenDate];
    NSString *path = [@"~/Library/Logs/Discipline/Tasks/" stringByStandardizingPath];
    NSString *file = [[@"Task_" stringByAppendingString:formattedChosen] stringByAppendingPathExtension:@"plist"];
    NSSet *filesInDir = [NSSet setWithArray:[[NSFileManager defaultManager] directoryContentsAtPath:path]];
    
    if ([filesInDir containsObject:file])
        return YES;
    else
        return NO;
}

- (IBAction)dateButtonPressed:(id)sender {
    [next setEnabled:YES];
}

- (NSString *)formatAppendedDate:(NSString *)dateToFormat {
    NSDate *typeDate = [NSDate dateWithNaturalLanguageString:dateToFormat];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [formatter stringFromDate:typeDate];
    [formatter release];
    return formattedDate;
}

- (void)loadDebrieferView {
    NSWindow *theWindow = [self window];
    BOOL ended = [theWindow makeFirstResponder:theWindow];
    if (!ended) {
        NSBeep();
        return;
    }
    
    NSView *theView = [questionVC view];
    
    //  Compute the new window frame
    NSSize currentSize = [[theWindow contentView] frame].size;
    NSSize newSize = [theView frame].size;
    newSize.height += [questionVC theFactor];
    float deltaWidth = newSize.width - currentSize.width;
    float deltaHeight = newSize.height - currentSize.height;
    NSRect windowFrame = [theWindow frame];
    windowFrame.size.height += deltaHeight;
    windowFrame.origin.y -= deltaHeight;
    windowFrame.size.width += deltaWidth;
    
    [theWindow setFrame:windowFrame
                display:YES
                animate:YES];
    
    //  Put the view in the window
    [theWindow setContentView:theView];
    [next setTitle:@"Next"];
}

- (IBAction)nextButtonPressed:(id)sender {
    NSString *selectedDate = [[datePicker selectedCell] title];
    [wait setHidden:NO];
    [wait startAnimation:self];
    [next setEnabled:NO];
    [datePicker setEnabled:NO];
    
    BOOL dateIsOk = [self checkDate:selectedDate];
    if (dateIsOk) {
        [self setQuestionVC:[[DebrieferQuestionViewController alloc] initWithDate:selectedDate]];
        [self loadDebrieferView];
    }
    else {
        NSRunInformationalAlertPanel(@"Ooops!", @"You don't have any tasks for this day!", @"OK", nil, nil);
        [wait setHidden:YES];
        [next setEnabled:NO];
        [datePicker setEnabled:YES];
    }
}

@end
