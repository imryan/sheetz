//
//  SHSecondViewController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    IBOutlet UINavigationBar *navBar;
    NSInteger indexPathRow;
}


@property (nonatomic, retain) NSArray *tableData;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *noPostsLabel;

- (IBAction)refresh:(id)sender;

@end
