//
//  SomeClass.m
//  BuggyProject
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import "SomeClass.h"

@implementation SomeClass

+ (void)printTextInMain:(NSString *)someText {
    // all af the tasks should be performed in the different, background thread (despite - refreshing UI)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"%@", someText);
        });
    });
}

@end
