//
//  SHUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "MHNatGeoViewControllerTransition.h"

#import "SHCustomFormCell.h"
#import "SHUploadController.h"
#import "SHAppDelegate.h"

@implementation SHUploadController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)uploadListing:(id)sender
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"\nTitle: %@\nDesc: %@\nPrice: %@", delegate.title, delegate.desc, delegate.price);
}

- (IBAction)cancelUpload:(id)sender
{
    [self dismissNatGeoViewController];
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    SHCustomFormCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        cell = [[SHCustomFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
