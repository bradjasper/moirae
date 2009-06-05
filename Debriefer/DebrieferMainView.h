//
//  DebrieferMainView.h
//  Debriefer
//
//  Created by Joseph Subida on 5/23/09.
//  Copyright 2009 University of Illinois Champaign-Urbana. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DebrieferMainView : NSView {
    IBOutlet NSButton *next;
    IBOutlet NSButtonCell *dateToday;
    IBOutlet NSButtonCell *dateYesterday;
    IBOutlet NSMatrix *datePicker;
    IBOutlet NSProgressIndicator *wait;
    DebrieferQuestionViewController *questionVC;
}

@property (nonatomic, retain) DebrieferQuestionViewController *questionVC;

- (void)initDateMatrix;
- (void)initView;

- (IBAction)dateButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;

- (BOOL)checkDate:(NSString *)chosenDate;
- (NSString *)formatAppendedDate:(NSString *)dateToFormat;
- (void)loadDebrieferView;

@end
