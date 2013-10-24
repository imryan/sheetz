//
//  SHLaunchController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHLaunchController.h"
#import "SHRegisterController.h"
#import "SHLoginController.h"
#import "MHNatGeoViewControllerTransition.h"

@implementation SHLaunchController

#pragma mark - Push to register view

- (IBAction)pushRegisterView:(id)sender
{
    SHRegisterController *registerView = [SHRegisterController new];
    [self presentNatGeoViewController:registerView];
    
    self.didRegister = true;
}

#pragma mark - Push to login view

- (IBAction)pushLoginView:(id)sender
{
    SHLoginController *loginView = [SHLoginController new];
    [self presentNatGeoViewController:loginView];
    
    self.didLogin = true;
}

#pragma mark - ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.didLogin || self.didRegister)
    {
        [self dismissNatGeoViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end