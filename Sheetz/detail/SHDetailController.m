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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)contact:(id)sender
{
    if ([self.contactEmail isEqualToString:@""]) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Contact"
                                                           delegate:self
                                                  cancelButtonTitle:@"Dismiss"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:self.contactPhone, nil];
        
        [sheet showInView:self.view];
        
    } else if (![self.contactEmail isEqualToString:@""] && ![self.contactPhone isEqualToString:@""]) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Contact"
                                                           delegate:self
                                                  cancelButtonTitle:@"Dismiss"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:self.contactPhone, self.contactEmail, nil];
        
        [sheet showInView:self.view];
    
    } else {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Contact"
                                                           delegate:self
                                                  cancelButtonTitle:@"Dismiss"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:self.contactEmail, nil];
        
        [sheet showInView:self.view];
    }
}

- (IBAction)done:(id)sender
{
    [self performSegueWithIdentifier:@"detailDone" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    PFImageView *imageView = [PFImageView new];
    imageView.file = self.file;
    
    self.listingImage.image = imageView.image;
    self.listingTitle.text = [self.information objectForKey:@"title"];
    self.listingPrice.text = [self.information objectForKey:@"price"];
    self.listingCampus.text = [self.information objectForKey:@"campus"];
    self.listingStreet.text = [self.information objectForKey:@"street"];
    
    self.contactEmail = [self.information objectForKey:@"email"];
    self.contactPhone = [self.information objectForKey:@"phone"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
