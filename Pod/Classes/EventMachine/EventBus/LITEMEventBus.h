//
//  LITEMEventBus.h
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LITEMEventBase.h"
#import "LITEMBaseListener.h"
#import "LITEMBaseEventFactory.h"

@interface LITEMEventBus : NSObject

@property (strong, nonatomic) LITEMBaseEventFactory *eventFactory;

#pragma mark - Subscription
- (void)subscribeListener:(LITEMBaseListener *)listener onEventWithMessage:(NSString *)message;
- (void)subscribeListener:(LITEMBaseListener *)listener onEvent:(LITEMEventBase *)event;
- (void)subscribeListener:(LITEMBaseListener *)listener onEventWithType:(NSString *)type;

- (void)unsubscribeListener:(LITEMBaseListener *)listener;
- (void)unsubscribeAll;

#pragma mark - Fire
- (void)fireEvent:(LITEMEventBase *)event;
- (void)fireEventWithMessage:(NSString *)message;
- (void)fireEventWithType:(NSString *)type;

@end

@interface LITEMEventBus (DelegatedSubscriptions)

- (void)subscribeDelegate:(id<LITEMBaseListenerProtocol>)delegate withName:(NSString *)name onEvent:(LITEMEventBase *)event;
- (void)subscribeDelegate:(id<LITEMBaseListenerProtocol>)delegate withName:(NSString *)name onEventType:(NSString *)type;
- (void)unsubscribeDelegate:(id<LITEMBaseListenerProtocol>)delegate withName:(NSString *)name;

@end
