//
//  LITEMEventBase.h
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 LightweightInTouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LITEMEventBase : NSObject

+ (NSString *)type;

@property (nonatomic, copy) NSString *type;

@end
