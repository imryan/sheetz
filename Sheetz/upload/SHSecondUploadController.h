//
//  SHSecondUploadController.h
//  Sheetz
//
//  Created by Ryan Cohen on 11/10/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSecondUploadController : UIViewController


- (IBAction)previousView:(id)sender;
- (IBAction)uploadListing:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField *priceTextField;
@property (nonatomic, retain) IBOutlet UITextField *campusTextField;

@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *campus;

@end
