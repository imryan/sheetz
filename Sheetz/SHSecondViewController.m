//
//  SHSecondViewController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHCustomCell.h"
#import <Parse/Parse.h>

@implementation SHSecondViewController
@synthesize tableData;

- (IBAction)refresh:(id)sender
{
    [self loadDatabaseData];
}

#pragma mark - TableView Methods

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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Listings"];
    PFUser *user = [PFUser currentUser];
    
    [query whereKey:@"member" equalTo:user.username];
    
    tableData = [query findObjects];
    
    PFObject *listing = [tableData objectAtIndex:indexPath.row];
    [cell.postTitleLabel setText:[listing objectForKey:@"title"]];
    [cell.postDescLabel setText:[listing objectForKey:@"description"]];
    [cell.postPriceLabel setText:[listing objectForKey:@"price"]];
    
    return cell;
}

#pragma mark - Load Database Data

- (void)loadDatabaseData
{
    PFQuery *listingQuery = [PFQuery queryWithClassName:@"Listings"];
    [listingQuery whereKeyExists:@"title"];
    [listingQuery whereKey:@"member" equalTo:[PFUser currentUser].username];
    [listingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             tableData = objects;
             [self.tableView reloadData];
         }
         
     }];
}

#pragma mark - ViewDidLoad & Friends

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
