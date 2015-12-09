//
//  LITAppDelegate.h
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 12/09/2015.
//  Copyright (c) 2015 Lobanov Dmitry. All rights reserved.
//

@import UIKit;
#import <LITEMBaseListener.h>
#import <LITEMBaseEventFactory.h>

@interface LITAppDelegate : UIResponder <UIApplicationDelegate, LITEMBaseListenerProtocol>

@property (strong, nonatomic) UIWindow *window;

@end
