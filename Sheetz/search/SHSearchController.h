//
//  SHSearchController.h
//  Sheetz
//
//  Created by Ryan Cohen on 12/30/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSearchController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSArray *tableData;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *noPostsLabel;

- (IBAction)cancelSearch:(id)sender;
- (void)searchDatabaseWithString:(NSString *)text;

@end
