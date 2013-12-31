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

#define MENU_TAG 50
#define FADE_TAG 60

@implementation SHFirstViewController
@synthesize tableData;

- (IBAction)displayMenu:(id)sender
{
    [self displayAlert];
}
- (void)displayAlert
{
    self.tabBarController.tabBar.alpha = 1.0f;
    
    UIView *fadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    fadeView.tag = FADE_TAG;
    
    fadeView.alpha = 0.0f;
    [UIView beginAnimations:@"fadeInView" context:NULL];
    [UIView setAnimationDuration:0.3];
    fadeView.alpha = 1.0f;
    [UIView commitAnimations];
    
    [self.view addSubview:fadeView];
    
    fadeView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    
    for (UIView *view in [self.view subviews]) {
        if (view.tag == MENU_TAG) {
            view.userInteractionEnabled = true;
        } else {
            view.userInteractionEnabled = false;
        }
    }
    
    CGRect frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 190, 205);
    CGPoint center = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.tag = MENU_TAG;
    
    view.center = center;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 7;
    view.clipsToBounds = true;
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton addTarget:self action:@selector(submitListing) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setFrame:CGRectMake(30, 14, 133, 51)];
    [submitButton setImage:[UIImage imageNamed:@"submit@2x.png"] forState:UIControlStateNormal];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton addTarget:self action:@selector(logoutUser) forControlEvents:UIControlEventTouchUpInside];
    [logoutButton setFrame:CGRectMake(30, 76, 133, 51)];
    [logoutButton setImage:[UIImage imageNamed:@"logout@2x.png"] forState:UIControlStateNormal];
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissButton addTarget:self action:@selector(handleExit) forControlEvents:UIControlEventTouchUpInside];
    [dismissButton setFrame:CGRectMake(30, 140, 133, 51)];
    [dismissButton setImage:[UIImage imageNamed:@"dismiss@2x.png"] forState:UIControlStateNormal];
    
    [view addSubview:submitButton];
    [view addSubview:logoutButton];
    [view addSubview:dismissButton];
    [self.view addSubview:view];
}

- (void)handleExit
{
    UIView *view = [self.view viewWithTag:MENU_TAG];
    [view removeFromSuperview];
    
    UIView *fade = [self.view viewWithTag:FADE_TAG];
    [fade removeFromSuperview];
    
    for (UIView *view in [self.view subviews]) {
        view.userInteractionEnabled = true;
    }
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
    
    /* Custom cell attributes
    cell.clipsToBounds = true;
    cell.layer.cornerRadius = 10;
     */
    
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
            [cell.postImageView setImage:imageView.image];
            
        } else {
            NSLog(@"Error loading image.");
        }
    }];
    
    /* Compare image data and assign the placeholder image if image view is empty
    NSData *imageData = UIImagePNGRepresentation(cell.postImageView.image);
    if ([imageData isEqualToData:nil]) {
        NSLog(@"Image isn't null");
    }
    */
    
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
