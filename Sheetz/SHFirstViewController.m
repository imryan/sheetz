//
//  SHFirstViewController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//


#import <Parse/Parse.h>
#import "SHCustomCell.h"
#import "SHAppDelegate.h"
#import "SHLaunchController.h"
#import "SHFirstViewController.h"
#import "SHUploadController.h"
#import "SHDetailController.h"

@implementation SHFirstViewController
@synthesize tableData;

- (IBAction)displayMenu:(id)sender
{
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Menu"
                                                      delegate:self
                                             cancelButtonTitle:@"Dismiss"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Submit Listing", @"Logout", nil];
    [menu showInView:self.view];
}

- (IBAction)refresh:(id)sender
{
    [self loadDatabaseData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self submitListing];
            break;
        case 1:
            [self logoutUser];
            break;
    }
}

- (void)submitListing
{
    [self performSegueWithIdentifier:@"upload" sender:self];
}

- (void)logoutUser
{
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
}

- (void)loadDatabaseData
{
    PFQuery *listingQuery = [PFQuery queryWithClassName:@"Listings"];
    [listingQuery whereKeyExists:@"title"];
    [listingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         if (!error) {
             tableData = objects;
             [self.tableView reloadData];
         }
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    SHCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[SHCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    PFObject *listing = [tableData objectAtIndex:indexPath.row];
    [cell.postTitleLabel setText:[listing objectForKey:@"title"]];
    [cell.postDescLabel setText:[listing objectForKey:@"description"]];
    [cell.postPriceLabel setText:[listing objectForKey:@"price"]];
    [cell.postCampusLabel setText:[listing objectForKey:@"campus"]];
    
    PFImageView *imageView = [PFImageView new];
    imageView.file = (PFFile *)listing[@"image"];
    
    [imageView loadInBackground:^(UIImage *image, NSError *error) {        
        if (!error) {
            cell.postImageView.layer.cornerRadius = 7;
            cell.postImageView.clipsToBounds = true;
            [cell.postImageView setImage:imageView.image];
            
        } else {
            NSLog(@"Error loading image.");
        }
    }];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SHDetailController *detailView = (SHDetailController *)segue.destinationViewController;
        PFObject *object = [tableData objectAtIndex:indexPath.row];
        PFFile *file = [object objectForKey:@"image"];
        
        detailView.information = [tableData objectAtIndex:indexPath.row];
        detailView.file = file;
        
    } else {
        return;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDatabaseData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
