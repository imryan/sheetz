//
//  SHLoginController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHLoginController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

- (IBAction)loginUser:(id)sender;
- (NSString *)translateErrorCode:(NSError *)error;

@end
