//
//  SHFirstViewController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHFirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (nonatomic, retain) NSArray *tableData;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)submitListing;
- (void)loadDatabaseData;
- (void)logoutUser;
- (IBAction)displayMenu:(id)sender;
- (IBAction)refresh:(id)sender;

@end
