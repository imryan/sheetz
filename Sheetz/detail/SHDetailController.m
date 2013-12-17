//
//  SHDetailController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/24/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHDetailController.h"
#import "SHFirstViewController.h"

@implementation SHDetailController

- (IBAction)done:(id)sender
{
    [self performSegueWithIdentifier:@"detailDone" sender:self];
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
	
    self.listingTitle.text  = self.title;
    self.listingCampus.text = self.campus;
    self.listingPrice.text  = self.price;
    self.listingStreet.text = self.street;
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
