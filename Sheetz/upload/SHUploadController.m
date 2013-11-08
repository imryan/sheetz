//
//  SHUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "MHNatGeoViewControllerTransition.h"

#import "SHUploadController.h"
#import "SHAppDelegate.h"

@implementation SHUploadController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)uploadListing:(id)sende
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.title = self.title;
    delegate.desc  = self.desc;
    delegate.price = self.price;
    
    [self performSegueWithIdentifier:@"next1" sender:self];
}

- (IBAction)uploadListing2:(id)sender
{
    [self performSegueWithIdentifier:@"next2" sender:self];
}

- (IBAction)cancelUpload:(id)sender
{
    [self dismissNatGeoViewController];
}

#pragma mark ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
