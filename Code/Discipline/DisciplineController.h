//
//  DisciplineController.h
//  Discipline
//
//  Created by alcor on 9/21/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//


@interface DisciplineController : NSObject {
	
	NSStatusItem *menuIcon;
	
}

- (void)makeProcessThread;
- (void)addSelfToLoginItems;
- (void)openLogFolder;
- (void)quitLachesis;

@end
