//
//  SHSecondUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 11/10/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "MHNatGeoViewControllerTransition.h"
#import "SHAppDelegate.h"
#import "SHSecondUploadController.h"

@implementation SHSecondUploadController

- (IBAction)previousView:(id)sender
{
    [self dismissNatGeoViewController];
}

- (IBAction)uploadListing:(id)sender
{
    self.price = self.priceTextField.text;
    
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.price = self.price;
    
    [self performSegueWithIdentifier:@"uploadListing" sender:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
