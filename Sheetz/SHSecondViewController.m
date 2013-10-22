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

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userListings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    SHCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        cell = [[SHCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Listings"];
    [query whereKey:@"user" equalTo:user];
    userListings = [query findObjects];
     
    PFObject *listing = [tableData objectAtIndex:indexPath.row];
    [cell.postTitleLabel setText:[listing objectForKey:@"title"]];
    [cell.postDescLabel setText:[listing objectForKey:@"description"]];
    [cell.postPriceLabel setText:[NSString stringWithFormat:@"$%@", [listing objectForKey:@"price"]]];
    
    return cell;
    */
    
    return cell;
}

#pragma mark - ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    PFUser *user = [PFUser currentUser];
    self.usernameLabel.text = user.username;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"M/yyyy"];
    
    NSString *dateJoined = [formatter stringFromDate:user.createdAt];
    
    NSDate *date = [formatter dateFromString:dateJoined];
    
    self.memberSinceLabel.text = dateJoined;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
