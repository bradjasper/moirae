//
//  ClothoiTunesWatcher.m
//  Clotho
//
//  Created by Nicholas Jitkoff on 10/5/08.
//  Copyright 2008 Blacktree. All rights reserved.
//

#import "ClothoiTunesWatcher.h"


@implementation ClothoiTunesWatcher
- (id) init {
  self = [super init];
  if (self != nil) {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(trackChanged:) name:@"com.apple.iTunes.playerInfo" object:nil];
  }
  return self;
}

- (NSString *)logName {
  return @"iTunes.log";
}


- (void)trackChanged:(NSNotification *)notif {
  NSDictionary *info = [notif userInfo];
  NSString *message = [NSString stringWithFormat:@"%@\t%@\t%@\t%@\t%@\n",
                       [info valueForKey:@"Location"],
                       [info valueForKey:@"Name"],
                       [info valueForKey:@"Artist"],
                       [info valueForKey:@"Album"],
                       [info valueForKey:@"Player State"]];
  
  
  fprintf(log, [message UTF8String]);
  
  fflush(log);
  
}

- (void)dealloc {
  [[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
  [super dealloc]; 
}
@end
