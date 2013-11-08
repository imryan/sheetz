//
//  SHLaunchController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "Reachability.h"
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
    Reachability *reach = [Reachability reachabilityWithHostname:@"http://google.com"];
    
    reach.reachableBlock = ^(Reachability *reach)
    {
        NSLog(@"[Reachability] connected.");
    };
    
    reach.unreachableBlock = ^(Reachability *reach)
    {
        NSLog(@"[Reachability] not connected.");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connectivity"
                                                       message:@"Please connect to the internet to continie."
                                                      delegate:self
                                              cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    };
    
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