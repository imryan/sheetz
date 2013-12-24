//
//  SHDetailController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/24/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SHDetailController : UIViewController

@property (nonatomic, strong) NSDictionary *information;
@property (nonatomic, strong) PFFile *file;

@property (nonatomic, retain) IBOutlet UILabel *listingTitle;
@property (nonatomic, retain) IBOutlet UILabel *listingCampus;
@property (nonatomic, retain) IBOutlet UILabel *listingPrice;
@property (nonatomic, retain) IBOutlet UILabel *listingStreet;
@property (nonatomic, retain) IBOutlet UIImageView *listingImage;

- (IBAction)done:(id)sender;

@end