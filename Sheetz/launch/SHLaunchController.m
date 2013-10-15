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

@implementation SHLaunchController

#pragma mark - Push to register view

- (IBAction)pushRegisterView:(id)sender
{
    SHRegisterController *registerView = [SHRegisterController new];
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:registerView animated:true completion:nil];
    
    self.didRegister = true;
}

#pragma mark - Push to login view

- (IBAction)pushLoginView:(id)sender
{
    SHLoginController *loginView = [SHLoginController new];
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginView animated:true completion:nil];
    
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
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end