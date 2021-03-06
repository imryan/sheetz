//
//  SHDetailController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/24/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SHDetailController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSDictionary *information;
@property (nonatomic, strong) PFFile *file;

@property (nonatomic, retain) NSString *descriptionString;
@property (nonatomic, retain) IBOutlet UILabel *listingTitle;
@property (nonatomic, retain) IBOutlet UILabel *listingCampus;
@property (nonatomic, retain) IBOutlet UILabel *listingPrice;
@property (nonatomic, retain) IBOutlet UILabel *listingStreet;
@property (nonatomic, retain) IBOutlet UIImageView *listingImage;

@property (nonatomic, retain) NSString *contactEmail;
@property (nonatomic, retain) NSString *contactPhone;

- (IBAction)done:(id)sender;
- (IBAction)description:(id)sender;
- (IBAction)contact:(id)sender;
- (NSString *)formatPhoneNumber:(NSString *)number;

@end