//
//  SHOverviewController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/21/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHOverviewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UITextView *descTextView;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *campusLabel;

- (IBAction)editListing:(id)sender;
- (IBAction)uploadListing:(id)sender;

@end
