//
//  LITEMBaseEventFactory.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import "LITEMBaseEventFactory.h"

@interface NSArray (FunctionalStyleMethods)
- (id)accumulateObjectsUsingBlock:(id (^)(id accumulatedValue, id obj, NSUInteger idx))block withInitialValue:(id)initialValue;
@end

@implementation NSArray (FunctionalStyleMethods)

- (id)accumulateObjectsUsingBlock:(id (^)(id accumulatedValue, id obj, NSUInteger idx))block withInitialValue:(id)initialValue {
    // do something with default value
    __block id accumulatedValue = initialValue ? initialValue : nil;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block) {
            accumulatedValue = block(accumulatedValue, obj, idx);
        }
    }];
    return accumulatedValue;
}

@end

@interface LITEMBaseEventFactory ()

@property (copy, nonatomic, readwrite) NSDictionary *types;

@end

@implementation LITEMBaseEventFactory

+ (NSArray *)events {
    return
    @[
      /*Place for custom events*/
    ];
}

- (NSDictionary *)types {
    
    if (!_types) {
        _types = [[self.class events] accumulateObjectsUsingBlock:^id(NSDictionary * accumulatedValue, LITEMEventBase *obj, NSUInteger idx) {
            NSMutableDictionary *value = [accumulatedValue mutableCopy];
            value[obj.type] = obj;
            accumulatedValue = [value copy];
            return accumulatedValue;
        } withInitialValue:@{}];
    }
    return _types;
    
}

- (LITEMEventBase *)eventWithType:(NSString *)type {
    if (!type) {
        NSLog(@"%@: Event with type: %@ not registered. Check it!", self.class, type);
        return nil;
    }

    return self.types[type];
}

- (LITEMEventBase *)decodeEventWithMessage:(NSString *)message {
    // implement in your factory
    return nil;
}

+ (LITEMEventBase *)eventWithType:(NSString *)type {
    return [[self new] eventWithType:type];
}

@end