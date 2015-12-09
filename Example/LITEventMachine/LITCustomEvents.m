//
//  LITCustomEvents.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 09.12.15.
//  Copyright © 2015 Lobanov Dmitry. All rights reserved.
//

#import "LITCustomEvents.h"

@implementation LITEMEventSayHello

- (instancetype) initWithWho:(NSString *)who andSayWhat:(NSString *)what {
    self = [super init];
    
    if (self) {
        self.who = who;
        self.what = what;
    }
    
    return self;
}

- (instancetype) christmasIsComing {
    return [self initWithWho:@"Santa" andSayWhat:@"Hohoho"];
}

- (NSString *)type {
    if (self.who && self.what) {
        return [[self.who stringByAppendingString:@" - "] stringByAppendingString:self.what];
    }
    
    return [super type];
}

@end
