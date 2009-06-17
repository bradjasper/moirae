//
//  DisciplineController.m
//  Discipline
//
//  Created by alcor on 9/21/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "DisciplineController.h"
#import "ClothoProcessWatcher.h"
#import "ClothoScreenWatcher.h"
#import "ClothoiTunesWatcher.h"
#import "DisciplineTaskPrompter.h"
#import "ClothoTaskPrompter.h"
#import "QSAccessibility.h"

#define DOC_PATH [@"~/Library/Application Support/Discipline/" stringByStandardizingPath]

@implementation DisciplineController

- (void)applicationDidFinishLaunching:(NSApplication *)theApplication {
    
    BOOL shouldLogITunes = NO;
    QSEnableAccessibility();
  
    NSString *directory = [@"~/Library/Logs/Discipline" stringByStandardizingPath];
  
    [[NSFileManager defaultManager] createDirectoryAtPath:directory
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    [[ClothoProcessWatcher alloc] init];
    NSOperationQueue *theQueue = [NSOperationQueue new];
    NSInvocationOperation *theProcess = 
    [[NSInvocationOperation alloc] initWithTarget:self 
                                         selector:@selector(makeProcessThread) 
                                           object:nil];
    [theQueue addOperation:theProcess];
    
    [[ClothoTaskPrompter alloc] init];
    if (shouldLogITunes)
        [[ClothoiTunesWatcher alloc] init];
    
    NSImage *image = [NSImage imageNamed:@"clotho_logger2"];
    image = [image copy];
    [image setSize:NSMakeSize(16, 16)];
    
    NSMenu *pulldownMenu = [[NSMenu alloc] init];
    [NSMenu setMenuBarVisible:YES];
    NSMenuItem *quitButton = [[NSMenuItem alloc] initWithTitle:@"Quit Clotho" 
                                                        action:@selector(quitClotho) 
                                                 keyEquivalent:[NSString string]];
    NSMenuItem *openFolderButton = [[NSMenuItem alloc] initWithTitle:@"Open Log Folder"
                                                              action:@selector(openLogFolder)
                                                       keyEquivalent:[NSString string]];
    [pulldownMenu insertItem:openFolderButton atIndex:0];
    [pulldownMenu insertItem:quitButton atIndex:1];
    
    NSStatusItem *item = 
    [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [item retain];
    [item setImage:image];
    [item setMenu:pulldownMenu];
    [item setHighlightMode:YES];
    
    [self addSelfToLoginItems];
    
}

- (void)makeProcessThread {
    [[ClothoScreenWatcher alloc] init];
}

- (void)addSelfToLoginItems {
    
    NSString *path = [@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath];
    NSString *clothoAppPath = @"/Applications/Clotho/Clotho Logger.app";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //  check if file exists
        if (![NSFileHandle fileHandleForUpdatingAtPath:path]) {
            NSLog(@"File not found");
        }        
        
        //  read in existing task file
        NSString *errorDesc = nil; 
        NSPropertyListFormat format; 
        NSData *plistXML = [[NSFileManager defaultManager] 
                            contentsAtPath:path]; 
        NSMutableDictionary *loginItems = 
        (NSMutableDictionary *)[NSPropertyListSerialization 
                                propertyListFromData:plistXML 
                                mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                format:&format errorDescription:&errorDesc]; 
        if (!loginItems) { 
            NSLog(errorDesc); 
        }
        [errorDesc release]; 
        
        //  check to see if already autolaunched. 
        BOOL alreadyAutoLaunched = NO;
        NSMutableArray *autoLaunchedList = [loginItems objectForKey:@"AutoLaunchedApplicationDictionary"];
        for (NSDictionary *item in autoLaunchedList) {
            if ([[item objectForKey:@"Path"] isEqualToString:clothoAppPath]) {
                alreadyAutoLaunched = YES;
                break;
            }
        }
        
        //  if not auto launched, add self to list
        if (!alreadyAutoLaunched) {
            NSMutableDictionary *clothoApp = [NSMutableDictionary dictionary];
            [clothoApp setObject:clothoAppPath forKey:@"Path"];
            [clothoApp setValue:[NSNumber numberWithBool:YES] forKey:@"Hide"];
            
            [autoLaunchedList addObject:clothoApp];
            [loginItems setObject:autoLaunchedList forKey:@"AutoLaunchedApplicationDictionary"];
            [loginItems writeToFile:path atomically:NO];
        }
        
    }
    else {
        NSLog(@"Unable to add to login items");
    }
    
}

- (void)openLogFolder {
    
    NSDictionary *errorDict = [NSDictionary dictionary]; 
    NSAppleScript *openFolder = [[NSAppleScript alloc] initWithSource:
                                 @"tell application \"Finder\" to open (path to home folder as text) & \"Library:Logs:Discipline\" as alias"];
    NSString *erro = @"";
    if (![openFolder isCompiled]) {
        [openFolder compileAndReturnError:&errorDict];
        NSLog(@"First: %@", erro);
    }
    erro = [[openFolder executeAndReturnError:&errorDict] stringValue];
    NSLog(@"Second: %@", erro);
    [openFolder release];

}

- (void)quitClotho {
    [[NSApplication sharedApplication] terminate:[NSApplication sharedApplication]];
}

@end
