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
#define LOG_PATH [@"~/Library/Logs/Discipline" stringByStandardizingPath]
#define LOGIN_PATH [@"~/Library/Preferences/loginwindow.plist" stringByExpandingTildeInPath]

@implementation DisciplineController

- (id)init {
	
	if (self = [super init]) {
		
		//  create Clotho Logger icon
		NSImage *image = [NSImage imageNamed:@"lachisis_512_log"];
		image = [image copy];
		[image setSize:NSMakeSize(16, 16)];
		
		//  set up Clotho Logger menu item
		NSMenu *pulldownMenu = [[NSMenu alloc] init];
		[NSMenu setMenuBarVisible:YES];
		NSMenuItem *quitButton = [[NSMenuItem alloc] initWithTitle:@"Quit Lachesis" 
															action:@selector(quitLachesis) 
													 keyEquivalent:[NSString string]];
		NSMenuItem *openFolderButton = [[NSMenuItem alloc] initWithTitle:@"Open Log Folder"
																  action:@selector(openLogFolder)
														   keyEquivalent:[NSString string]];
		[pulldownMenu insertItem:openFolderButton atIndex:0];
		[pulldownMenu insertItem:quitButton atIndex:1];
		
		//  create Clotho Logger menu bar item 
		menuIcon = 
		[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
		[menuIcon setImage:image];
		[menuIcon setMenu:pulldownMenu];
		[menuIcon setHighlightMode:YES];
		[menuIcon retain];
		
	}
	
	return self;
	
}

- (void)applicationDidFinishLaunching:(NSNotification *)theApplication {
    
    BOOL shouldLogITunes = NO;
    QSEnableAccessibility();
    
    [[NSFileManager defaultManager] createDirectoryAtPath:LOG_PATH
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
    
    [self addSelfToLoginItems];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
    NSLog(@"Terminating Lachesis Logger with event type: %d", [[[aNotification object] currentEvent] type]);
    
}

- (void)makeProcessThread {
    [[ClothoScreenWatcher alloc] init];
}

- (void)addSelfToLoginItems {
    
    NSString *clothoAppPath = @"/Applications/Lachesis/Lachesis Logger.app";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:LOGIN_PATH]) {
        //  check if file exists
        if (![NSFileHandle fileHandleForUpdatingAtPath:LOGIN_PATH]) {
            NSLog(@"***Error: loginwindow.plist does not exist");
        }        
        
        //  read in existing task file
        NSString *errorDesc = nil; 
        NSPropertyListFormat format; 
        NSData *plistXML = [[NSFileManager defaultManager] 
                            contentsAtPath:LOGIN_PATH]; 
        NSMutableDictionary *loginItems = 
        (NSMutableDictionary *)[NSPropertyListSerialization 
                                propertyListFromData:plistXML 
                                mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                format:&format errorDescription:&errorDesc]; 
        if (!loginItems) { 
            NSLog(@"%@",errorDesc); 
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
            [loginItems writeToFile:LOGIN_PATH atomically:NO];
        }
        
    }
    else {
        NSLog(@"***Error: unable to add Lachesis Logger to login applications");
    }
    
}

- (void)openLogFolder {
    
    NSDictionary *errorDict = [NSDictionary dictionary]; 
    NSAppleScript *openFolder = [[NSAppleScript alloc] initWithSource:
                                 @"tell application \"Finder\" to open (path to home folder as text) & \"Library:Logs:Discipline\" as alias"];
    NSString *erro = @"";
    if (![openFolder isCompiled])
        [openFolder compileAndReturnError:&errorDict];
	
    erro = [[openFolder executeAndReturnError:&errorDict] stringValue];
    if (![erro isEqualToString:@""])
		NSLog(@"***Error compiling OpenLogFolder: %@", erro);
    [openFolder release];

}

- (void)quitLachesis {
    [[NSApplication sharedApplication] terminate:[NSApplication sharedApplication]];
}

@end
