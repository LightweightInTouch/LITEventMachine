//
//  LITEMEventMachine.h
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LITEMEventBus.h"

@interface LITEMEventMachine : NSObject

+ (instancetype)eventMachine;

@property (strong, nonatomic, readonly) LITEMEventBus *eventBus;

@end
