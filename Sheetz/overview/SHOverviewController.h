//
//  SHOverviewController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/21/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHOverviewController : UIViewController
{
    NSData *data;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) NSString *descriptionString;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *streetLabel;
@property (nonatomic, retain) IBOutlet UILabel *campusLabel;
@property (nonatomic, retain) IBOutlet UIImageView *coverImage;

- (IBAction)editListing:(id)sender;
- (IBAction)description:(id)sender;
- (IBAction)uploadListing:(id)sender;

@end
