//
//  SHSecondViewController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHDetailController.h"
#import "SHCustomCell.h"
#import <Parse/Parse.h>

@implementation SHSecondViewController
@synthesize tableData;

- (IBAction)refresh:(id)sender
{
    [self loadDatabaseData];
}

- (IBAction)logout:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout"
                                                    message:@"Are you sure you want to logout?"
                                                   delegate:self cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Logout", nil];
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableData count] == 0) {
        [self.noPostsLabel setHidden:false];
    } else {
        [self.noPostsLabel setHidden:true];
    }
    
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
    [cell.postPriceLabel setText:[listing objectForKey:@"price"]];
    [cell.postCampusLabel setText:[listing objectForKey:@"campus"]];
    
    PFImageView *imageView = [PFImageView new];
    imageView.file = (PFFile *)listing[@"image"];
    
    [imageView loadInBackground:^(UIImage *image, NSError *error) {
        if (!error) {
            cell.postImageView.clipsToBounds = true;
            cell.postImageView.layer.cornerRadius = 7;
            cell.postImageView.image = image;
            
        } else {
            return;
        }
    }];
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                        message:@"Are you sure you want to delete this listing?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Delete", nil];
        [alert show];
        indexPathRow = indexPath.row;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Delete"]) {
        PFObject *object = [tableData objectAtIndex:indexPathRow];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self loadDatabaseData];
            [self.tableView reloadData];
        }];
    }
    else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"No"]) {
        
    }
    
    else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Logout"]) {
        [PFUser logOut];
        [self performSegueWithIdentifier:@"logoutUser" sender:self];
        
    } else {
        return;
    }
}

- (void)loadDatabaseData
{
    PFQuery *listingQuery = [PFQuery queryWithClassName:@"Listings"];
    [listingQuery whereKeyExists:@"title"];
    [listingQuery whereKey:@"member" equalTo:[PFUser currentUser].username];
    [listingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         if (!error) {
             tableData = objects;
             [self.tableView reloadData];
         }
         
     }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![[segue identifier] isEqualToString:@"logoutUser"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SHDetailController *detailView = (SHDetailController *)segue.destinationViewController;
        PFObject *object = [tableData objectAtIndex:indexPath.row];
        PFFile *file = [object objectForKey:@"image"];
        
        detailView.information = [tableData objectAtIndex:indexPath.row];
        detailView.file = file;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDatabaseData];
}

- (void)viewWillAppear:(BOOL)animated
{
    PFUser *user = [PFUser currentUser];
    navBar.topItem.title = user.username;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end