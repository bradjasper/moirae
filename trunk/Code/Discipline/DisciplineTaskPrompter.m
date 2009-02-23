//
//  DisciplineTaskPrompter.m
//  Discipline
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Google Inc. All rights reserved.
//

#import "DisciplineTaskPrompter.h"


@implementation DisciplineTaskPrompter

- (void)createAlertWindow {
    [NSBundle loadNibNamed:@"DisciplineTaskPrompt" owner:self];
}

- (void)createShieldWindow {
    [super createShieldWindow];
    NSImageView *imageView = [[[NSImageView alloc] initWithFrame:[[shieldWindow contentView] frame]] autorelease];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DisciplineSilhouette" ofType:@"pdf"];
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    [imageView setImageScaling:NSImageScaleProportionallyUpOrDown];
    
    [imageView setImage:image];
    [imageView setWantsLayer:YES];
    [imageView setAlphaValue:0.1];
    [shieldWindow setContentView:imageView];
}

@end
