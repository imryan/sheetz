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
    [cell.postPriceLabel setText:[listing objectForKey:@"price"]];
    
    PFImageView *imageView = [PFImageView new];
    imageView.file = (PFFile *)listing[@"image"];
    
    [imageView loadInBackground:^(UIImage *image, NSError *error) {
        if (!error) {
            cell.imageView.layer.cornerRadius = 7;
            cell.imageView.clipsToBounds = true;
            cell.postImageView.image = image;
            
        } else {
            return;
        }
    }];
    
    
    return cell;
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
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SHDetailController *detailView = (SHDetailController *)segue.destinationViewController;
    PFObject *object = [tableData objectAtIndex:indexPath.row];
    PFFile *file = [object objectForKey:@"image"];
    
    detailView.information = [tableData objectAtIndex:indexPath.row];
    detailView.file = file;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDatabaseData];
}

- (void)viewWillAppear:(BOOL)animated
{
    PFUser *user = [PFUser currentUser];
    self.usernameLabel.text = user.username;
    
    NSDate *date = user.createdAt;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    NSString *dateString = [df stringFromDate:date];
    dateString = [NSString stringWithFormat:@"Joined on %@", dateString];
    
    self.memberSinceLabel.text = dateString;
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
