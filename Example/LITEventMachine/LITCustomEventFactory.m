//
//  LITCustomEventFactory.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 09.12.15.
//  Copyright © 2015 Lobanov Dmitry. All rights reserved.
//

#import "LITCustomEventFactory.h"
#import "LITCustomEvents.h"

@implementation LITCustomEventFactory

+ (NSArray *)events {
    return @[
             [LITEMEventSayHello new]
             ];
}

@end
