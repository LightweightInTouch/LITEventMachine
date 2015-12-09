//
//  LITCustomEvents.h
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 09.12.15.
//  Copyright © 2015 Lobanov Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LITEMEventBase.h>

@interface LITEMEventSayHello : LITEMEventBase

- (instancetype) initWithWho:(NSString *)who andSayWhat:(NSString *)what;

- (instancetype) christmasIsComing;

@property (copy, nonatomic) NSString *who;
@property (copy, nonatomic) NSString *what;

@end