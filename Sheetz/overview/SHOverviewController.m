//
//  SHOverviewController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/21/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "MHNatGeoViewControllerTransition.h"
#import "SHOverviewController.h"
#import "SHUploadController.h"
#import "SHAppDelegate.h"

@implementation SHOverviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)uploadListing:(id)sender
{
    PFObject *listing = [PFObject objectWithClassName:@"Listings"];
    listing[@"title"]  = self.titleLabel.text;
    listing[@"description"]   = self.descTextView.text;
    listing[@"price"]  = self.priceLabel.text;
    listing[@"campus"] = self.campusLabel.text;
  //listing[@"street"] = self.streetLabel.text;
    listing[@"member"] = [PFUser currentUser].username;
    
    [listing saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (succeeded) {
             NSLog(@"Successfully posted!");
             [self performSegueWithIdentifier:@"backHome" sender:self];
             
         } else {
             NSLog(@"Error posting!");
         }
         
     }];
}

- (IBAction)editListing:(id)sender
{
    [self dismissNatGeoViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.titleLabel.text   = delegate.title;
    self.descTextView.text = delegate.desc;
    self.priceLabel.text   = [NSString stringWithFormat:@"$%@", delegate.price];
    self.campusLabel.text  = delegate.campus;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
