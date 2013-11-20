//
//  SHUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "MHNatGeoViewControllerTransition.h"

#import "SHUploadController.h"
#import "SHAppDelegate.h"
#import "SHCustomFormCell.h"

@implementation SHUploadController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Might remove this
- (IBAction)nextView:(id)sender
{
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    
    switch (indexPath.row) {
        case 0:
            cellId = @"CellId";
            break;
        case 1:
            cellId = @"CellId2";
            break;
        case 2:
            cellId = @"CellId3";
            break;
        case 3:
            cellId = @"CellId4";
            break;
    }
    
    SHCustomFormCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    //[tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

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

- (IBAction)cancelUpload:(id)sender
{
    [self dismissNatGeoViewController];
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
