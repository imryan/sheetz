//
//  SHFirstViewController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "SHAppDelegate.h"
#import "SHLaunchController.h"
#import "SHFirstViewController.h"

@implementation SHFirstViewController

- (void)viewDidAppear:(BOOL)animated
{
    PFUser *user = [PFUser currentUser];
    
    if (!user)
    {
        [self returnToLaunchWithStyle:UIModalTransitionStyleCrossDissolve];
    }
}

- (IBAction)logoutUser:(id)sender
{
    [PFUser logOut];
    [self returnToLaunchWithStyle:UIModalTransitionStyleCoverVertical];
}

- (void)returnToLaunchWithStyle:(UIModalTransitionStyle)style
{
    SHLaunchController *launchController = [SHLaunchController new];
    self.modalTransitionStyle = style;
    [self presentViewController:launchController animated:true completion:nil];
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    // Push to detail view after deselect
}

#pragma mark - ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
	tableData = [NSMutableArray arrayWithObjects:@"Room for rent", @"Dorm for rent", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
