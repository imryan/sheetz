//
//  SHLaunchController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "MHNatGeoViewControllerTransition.h"
#import "SHLaunchController.h"

@implementation SHLaunchController

#pragma mark - ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"skipLaunch" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end