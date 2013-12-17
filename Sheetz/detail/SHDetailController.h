//
//  SHDetailController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/24/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDetailController : UIViewController

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *campus;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, retain) UIImage *photo;

@property (nonatomic, retain) IBOutlet UILabel *listingTitle;
@property (nonatomic, retain) IBOutlet UILabel *listingCampus;
@property (nonatomic, retain) IBOutlet UILabel *listingPrice;
@property (nonatomic, retain) IBOutlet UILabel *listingStreet;
@property (nonatomic, retain) IBOutlet UIImageView *listingImage;

- (IBAction)done:(id)sender;

@end
