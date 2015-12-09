//
//  LITViewController.m
//  LITEventMachine
//
//  Created by Lobanov Dmitry on 12/09/2015.
//  Copyright (c) 2015 Lobanov Dmitry. All rights reserved.
//

#import "LITViewController.h"
#import <LITEMEventMachine.h>
#import <LITEMEventBase.h>

#import "LITCustomEvents.h"

@interface LITViewController ()

@end

@implementation LITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LITEMEventBase *baseEvent = [[LITEMEventSayHello alloc] christmasIsComing];
    // type is an arbitrary string
    
    [[LITEMEventMachine eventMachine].eventBus fireEvent:baseEvent];
}

@end
