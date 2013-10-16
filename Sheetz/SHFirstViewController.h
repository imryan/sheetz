//
//  SHFirstViewController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHFirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)loadDatabaseData;
- (void)returnToLaunchWithStyle:(UIModalTransitionStyle)style;
- (IBAction)logoutUser:(id)sender;

@end
