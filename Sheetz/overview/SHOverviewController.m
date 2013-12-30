//
//  SHOverviewController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/21/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "MBProgressHUD.h"
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

- (IBAction)description:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Description"
                                                    message:self.descriptionString
                                                   delegate:self
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)uploadListing:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = @"Uploading";
    
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    PFFile *image = [PFFile fileWithData:data];
    PFObject *listing = [PFObject objectWithClassName:@"Listings"];
    listing[@"title"]         = self.titleLabel.text;
    listing[@"description"]   = self.descriptionString;
    listing[@"price"]         = self.priceLabel.text;
    listing[@"campus"]        = self.campusLabel.text;
    listing[@"street"]        = self.streetLabel.text;
    listing[@"member"]        = [PFUser currentUser].username;
    listing[@"phone"]         = delegate.contactPhone;
    listing[@"email"]         = delegate.contactEmail;

    [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [listing setObject:image forKey:@"image"];
            
            [listing saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"Listing added successfully.");
                    [MBProgressHUD hideHUDForView:self.view animated:true];
                    [self performSegueWithIdentifier:@"backHome" sender:self];
                    
                } else {
                    NSLog(@"Error uploading listing.");
                }
            }];
            
            NSLog(@"Uploaded image successfully.");
            
        } else {
            NSLog(@"Error uploading image.");
        }
    }];
}

- (IBAction)editListing:(id)sender
{
    [self performSegueWithIdentifier:@"editListing" sender:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.titleLabel.text   = delegate.title;
    self.descriptionString = delegate.desc;
    self.priceLabel.text   = [NSString stringWithFormat:@"$%@", delegate.price];
    self.campusLabel.text  = delegate.campus;
    self.coverImage.image  = delegate.photo;
    self.streetLabel.text  = delegate.street;
    
    data = UIImagePNGRepresentation(delegate.photo);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
