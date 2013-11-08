//
//  SHFirstViewController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//


#import <Parse/Parse.h>
#import "MHNatGeoViewControllerTransition.h"
#import "SHCustomCell.h"
#import "SHAppDelegate.h"
#import "SHLaunchController.h"
#import "SHFirstViewController.h"
#import "SHUploadController.h"

@implementation SHFirstViewController
@synthesize tableData;

#pragma mark - Display Menu & Actions

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

#pragma mark - Load Database Data

- (void)loadDatabaseData
{
    PFQuery *listingQuery = [PFQuery queryWithClassName:@"Listings"];
    [listingQuery whereKeyExists:@"title"];
    [listingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             tableData = objects;
             [self.tableView reloadData];
         }
         
     }];
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    SHCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        cell = [[SHCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    PFObject *listing = [tableData objectAtIndex:indexPath.row];
    [cell.postTitleLabel setText:[listing objectForKey:@"title"]];
    [cell.postDescLabel setText:[listing objectForKey:@"description"]];
    [cell.postPriceLabel setText:[NSString stringWithFormat:@"$%@", [listing objectForKey:@"price"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    // Push to detail view after select
}

#pragma mark - ViewDidLoad & Friends

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
