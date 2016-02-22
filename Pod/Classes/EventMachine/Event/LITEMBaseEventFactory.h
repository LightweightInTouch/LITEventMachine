//
//  LITEMBaseEventFactory.h
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LITEMEventBase.h"

@interface LITEMBaseEventFactory : NSObject

// should return events instances array as
// @[
//  [EventCustom new]
// ]
// it is necessary for name based methods which
// fire or subscribe on events with only a type
+ (NSArray *)events;

@property (copy, nonatomic, readonly) NSDictionary *types;

- (LITEMEventBase *)eventWithType:(NSString *)type;

- (LITEMEventBase *)decodeEventWithMessage:(NSString *)message;

+ (LITEMEventBase *)eventWithType:(NSString *)type;

@end
