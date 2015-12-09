//
//  LITEMEventMachine.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import "LITEMEventMachine.h"

@interface LITEMEventMachine()

@property (strong, nonatomic, readwrite) LITEMEventBus *eventBus;

@end

@implementation LITEMEventMachine

#pragma mark - Instantiation

+ (instancetype)eventMachine {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void) setup {
    // nothing hah!
}

#pragma mark - Getters
- (LITEMEventBus *)eventBus {
    if (!_eventBus) {
        _eventBus = [[LITEMEventBus alloc] init];
    }
    return _eventBus;
}


@end
