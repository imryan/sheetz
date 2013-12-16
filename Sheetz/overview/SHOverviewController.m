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

- (IBAction)nextView:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSInteger selectedSegment = control.selectedSegmentIndex;
    
    switch (selectedSegment) {
        case 0:
            [secondView setHidden:true];
            break;
        case 1:
            [secondView setHidden:false];
            break;
        case 2:
            break;
            
    }
}

- (IBAction)uploadListing:(id)sender
{
    PFFile *image = [PFFile fileWithData:data];
    
    if (image == nil) {
        NSLog(@"NIL IMAGE");
    }
    
    PFObject *listing = [PFObject objectWithClassName:@"Listings"];
    listing[@"title"]         = self.titleLabel.text;
    listing[@"description"]   = self.descTextView.text;
    listing[@"price"]         = self.priceLabel.text;
    listing[@"campus"]        = self.campusLabel.text;
    listing[@"street"]        = self.streetLabel.text;
    listing[@"member"]        = [PFUser currentUser].username;
    
    [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [listing setObject:image forKey:@"image"];
            
            [listing saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"Listing added successfully.");
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
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.titleLabel.text   = delegate.title;
    self.descTextView.text = delegate.desc;
    self.priceLabel.text   = [NSString stringWithFormat:@"$%@", delegate.price];
    self.campusLabel.text  = delegate.campus;
    self.coverImage.image  = delegate.photo;
    
    data = UIImagePNGRepresentation(delegate.photo);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [secondView setHidden:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
