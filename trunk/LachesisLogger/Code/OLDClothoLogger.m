//
//  ClothoLogger.m
//  Moirae
//
//  Created by J. Nicholas Jitkoff on 11/5/08.
//  Copyright 2008 Google Inc. All rights reserved.
//

#import "ClothoLogger.h"


@implementation ClothoLogger
- (NSString *)logName {
  return @"log.log";
}

- (id) init {
  self = [super init];
  if (self != nil) {
    NSString *directory = [@"~/Library/Logs/Discipline" stringByStandardizingPath];
    NSString *path = [directory stringByAppendingPathComponent:[self logName]];
    log = fopen([path fileSystemRepresentation], "a");
  }
  return self;
}

- (void) dealloc{
  fclose(log);
  [super dealloc];
}

@end
