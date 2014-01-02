//
//  SHSearchController.m
//  Sheetz
//
//  Created by Ryan Cohen on 12/30/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHSearchController.h"
#import "SHDetailController.h"
#import <Parse/Parse.h>
#import "SHCustomCell.h"

@implementation SHSearchController
@synthesize tableData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom init
    }
    return self;
}

- (IBAction)cancelSearch:(id)sender
{
    [self performSegueWithIdentifier:@"cancelSearch" sender:self];
}

- (void)searchDatabaseWithString:(NSString *)text
{
    NSMutableArray *results = [NSMutableArray array];
    
    PFQuery *listingQuery = [PFQuery queryWithClassName:@"Listings"];
    [listingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            if ([[object objectForKey:@"title"] caseInsensitiveCompare:text]  == NSOrderedSame  ||
                [[object objectForKey:@"campus"] caseInsensitiveCompare:text] == NSOrderedSame  ||
                [[object objectForKey:@"price"] caseInsensitiveCompare:text]  == NSOrderedSame) {
                [results addObject:object];
            } else {
                self.noPostsLabel.text = [NSString stringWithFormat:@"No listings found for '%@'", text];
            }
        }
        
        if (!error) {
            tableData = results;
            [self.tableView reloadData];
        }
        
    }];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![[segue identifier] isEqualToString:@"cancelSearch"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SHDetailController *detailView = (SHDetailController *)segue.destinationViewController;
        PFObject *object = [tableData objectAtIndex:indexPath.row];
        PFFile *file = [object objectForKey:@"image"];
        
        detailView.information = [tableData objectAtIndex:indexPath.row];
        detailView.file = file;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchDatabaseWithString:searchBar.text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
