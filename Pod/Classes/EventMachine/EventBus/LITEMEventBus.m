//
//  LITEMEventBus.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import "LITEMEventBus.h"

@interface LITEMEventRouter : NSObject

- (void)subscribeOnEventWithMessage:(NSString *)message;

@property(nonatomic, weak) id<LITEMBaseListenerEventGenerator> generator;
@property(nonatomic, weak) LITEMEventBus *bus;
@end

@implementation LITEMEventRouter

void notificationCallback(CFNotificationCenterRef center,
                          void * observer,
                          CFStringRef name,
                          void const * object,
                          CFDictionaryRef userInfo) {

    LITEMEventRouter *router = (__bridge LITEMEventRouter *)observer;
    // put it in general bus?
    LITEMEventBase *event = nil;
    if ([router.generator respondsToSelector:@selector(decodeEventWithMessage:)]) {
        event = [router.generator decodeEventWithMessage:(__bridge NSString *)(name)];
    }
    // fire it inside bus?
    [router.bus fireEvent:event];
}

- (void)subscribeOnEventWithMessage:(NSString *)message {
    CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(center,
                                    (__bridge const void *)(self),
                                    notificationCallback,
                                    (__bridge CFStringRef)message,
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}

@end

@interface LITEMEventBus() <LITEMBaseListenerEventGenerator>

@property (nonatomic, strong) NSArray *listeners;
@property (nonatomic, strong) LITEMEventRouter *router;

@end

@implementation LITEMEventBus

#pragma mark - Getters

- (LITEMEventRouter *)router {
    if (!_router) {
        _router = [LITEMEventRouter new];
        _router.generator = self;
        _router.bus = self;
    }
    return _router;
}

- (LITEMBaseEventFactory *)eventFactory {
    if (!_eventFactory) {
        _eventFactory = [LITEMBaseEventFactory new];
    }
    return _eventFactory;
}

- (NSArray *)listeners {
    if (!_listeners) {
        _listeners = @[];//[NSPointerArray weakObjectsPointerArray];
    }
    return _listeners;
}

- (void)subscribeListener:(LITEMBaseListener *)listener onEvent:(LITEMEventBase *)event {

    listener.generator = self;
    self.listeners = [self.listeners arrayByAddingObject:listener];

    // add to notification center
    if ([listener respondsToSelector:@selector(emListenEvent:)]) {
        [[NSNotificationCenter defaultCenter] addObserver:listener selector:@selector(emListenEvent:) name:event.type object:nil];
    }
    
    if ([listener respondsToSelector:@selector(emListenNotification:)]) {
        [[NSNotificationCenter defaultCenter] addObserver:listener selector:@selector(emListenNotification:) name:event.type object:nil];
    }
}

- (void)subscribeListener:(LITEMBaseListener *)listener onEventWithType:(NSString *)type {
    [self subscribeListener:listener onEvent:[self.eventFactory eventWithType:type]];
}

- (void)unsubscribeListener:(LITEMBaseListener *)listener {
    
    [[NSNotificationCenter defaultCenter] removeObserver:listener];

    // eliminates NULLs if they are exists

    // [self.listeners compactAndRemovePointerEqualsTo:(__bridge void *)listener];
    // [self.listeners ];
    
}

- (void)unsubscribeAll {
    for (NSUInteger i = 0; i < self.listeners.count; ++i) {
//        void *listener = [self.listeners pointerAtIndex:i];
        LITEMBaseListener *listener = [self.listeners objectAtIndex:i];
        [self unsubscribeListener:(listener)];
    }
    
    [self unsubscribeRouter];
}

- (void)unsubscribeRouter {
    CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterRemoveEveryObserver(center, (__bridge const void *)(self.router));
}

- (void)fireEvent:(LITEMEventBase *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:event.type object:event];
}

- (void)fireEventWithMessage:(NSString *)message {
    // fire event, bus will handle it?
    CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterPostNotification(center, (__bridge CFStringRef)message, NULL, NULL, YES);
    [self.router subscribeOnEventWithMessage:message];

}

- (void)fireEventWithType:(NSString *)type {
    [self fireEvent:[self.eventFactory eventWithType:type]];
}

- (void)dealloc {
    [self unsubscribeAll];
}

#pragma mark - Delegates / Listener Event Generator

- (LITEMEventBase *)eventWithType:(NSString *)type {
    return [self.eventFactory eventWithType:type];
}

- (LITEMEventBase *)decodeEventWithMessage:(NSString *)message {
    return [self.eventFactory decodeEventWithMessage:message];
}

@end

@implementation LITEMEventBus (DelegatedSubscriptions)

- (LITEMBaseListener *)listenerForDelegate:(id<LITEMBaseListenerProtocol>)delegate withName:(NSString *)name {
    LITEMBaseListener *listener = [LITEMBaseListener new];
    listener.delegate = delegate;
    listener.name = name;
    return listener;
}

- (void)subscribeDelegate:(id<LITEMBaseListenerProtocol>)delegate withName:(NSString *)name onEvent:(LITEMEventBase *)event {
    LITEMBaseListener *listener = [self listenerForDelegate:delegate withName:name];
    [self subscribeListener:listener onEvent:event];
}

- (void)subscribeDelegate:(id<LITEMBaseListenerProtocol>)delegate withName:(NSString *)name onEventType:(NSString *)type {
    LITEMBaseListener *listener = [self listenerForDelegate:delegate withName:name];
    [self subscribeListener:listener onEventWithType:type];
}

- (void)unsubscribeDelegate:(id<LITEMBaseListenerProtocol>)delegate withName:(NSString *)name {
    
    LITEMBaseListener *listener = nil;
    NSUInteger index = [self.listeners indexOfObjectPassingTest:^BOOL(LITEMBaseListener   * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj.name isEqualToString:name];
    }];
    
    listener = index == NSNotFound ? nil : self.listeners[index];
        
    if (listener) {
        [[NSNotificationCenter defaultCenter] removeObserver:listener];
    }
    
    self.listeners =
    [self.listeners filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(LITEMBaseListener * _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return ![evaluatedObject isEqualToListener:listener];
    }]];
}

@end