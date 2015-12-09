//
//  LITEMEventBase.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import "LITEMEventBase.h"

@implementation LITEMEventBase

+ (NSString *)type {
    return NSStringFromClass(self);
}

- (NSString *)type {
    if (!_type) {
        return [self.class type];
    }
    return _type;
}

- (NSString *)description {
    return self.type;
}

@end
