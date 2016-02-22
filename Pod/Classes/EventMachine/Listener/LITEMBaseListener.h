//
//  LITEMBaseListener.h
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LITEMEventBase.h"

@protocol LITEMBaseListenerProtocol <NSObject> // needed for selectors lookup

@optional
- (void)emListenEvent:(LITEMEventBase *)event;

@optional
- (void)emListenNotification:(NSNotification *)notification;

@end

@protocol LITEMBaseListenerEventGenerator <NSObject>

- (LITEMEventBase *)eventWithType:(NSString *)type;
@optional - (LITEMEventBase *)decodeEventWithMessage:(NSString *)message;

@end

@interface LITEMBaseListener : NSObject<LITEMBaseListenerProtocol>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic, readonly) NSString *type;
@property (copy, nonatomic) void (^completionBlock)(NSNotification *notification);
@property (weak, nonatomic) id<LITEMBaseListenerProtocol> delegate;
@property (weak, nonatomic) id<LITEMBaseListenerEventGenerator> generator;

#pragma mark - Equality
- (BOOL)isEqualToListener:(LITEMBaseListener *)listener;

@end
