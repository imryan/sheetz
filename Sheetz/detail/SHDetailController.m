//
//  SHDetailController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/24/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHDetailController.h"
#import "SHFirstViewController.h"
#import "MHNatGeoViewControllerTransition.h"

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Load data from table cell index
    SHFirstViewController *firstController = [SHFirstViewController new];
    NSString *title = [firstController.tableData objectAtIndex:0];
    
    self.listingTitle.text = title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
