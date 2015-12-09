//
//  LITEMBaseListener.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import "LITEMBaseListener.h"
#import "LITEMBaseEventFactory.h"

@implementation LITEMBaseListener

#pragma mark - Equality
- (BOOL)isEqualToListener:(LITEMBaseListener *)listener {
    return [self.name isEqualToString:listener.name] && [self.type isEqualToString:listener.type];
}

- (NSString *)type {
    return NSStringFromClass(self.class);
}

#pragma mark - Listening
- (void)emListenNotification:(NSNotification *)notification {    
    if ([self.delegate respondsToSelector:@selector(emListenNotification:)]) {
        [self.delegate emListenNotification:notification];
    }
    
    
    LITEMEventBase *event = nil;
    
    if ([notification.object isKindOfClass:[LITEMEventBase class]]) {
        event = notification.object;
    }
    else {
        event = [self.generator eventWithType:notification.name];
    }

    NSLog(@"%@, notification name: %@, event: %@ captured!\n send it to %@", NSStringFromClass(self.class), notification.name, event, self.delegate);
    
    [self prepareAsEvent:event];
}

- (void)prepareAsEvent:(LITEMEventBase *)event {
    if ([self.delegate respondsToSelector:@selector(emListenEvent:)]) {
        [self.delegate emListenEvent:event];
    }
}

@end
