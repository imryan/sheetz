//
//  SHLoginController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "SHLoginController.h"
#import "SHFirstViewController.h"
#import "SHLaunchController.h"

@implementation SHLoginController
@synthesize activityIndicator, usernameField, passwordField;

#pragma mark - Login user

- (IBAction)loginUser:(id)sender
{
    if ([usernameField.text isEqualToString:@""] || [passwordField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                        message:@"Please enter in all fields." delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        
        [activityIndicator startAnimating];
        [PFUser logInWithUsernameInBackground:usernameField.text password:passwordField.text block:^(PFUser *user, NSError *error)
         {
             if (user)
             {
                 // Change view
                 [activityIndicator stopAnimating];
                 [self pushView];
                 
                 // Development
                 NSLog(@"User [%@] successfully logged in.", usernameField.text);
                 
             } else {
                 
                 NSString *errorString = [self translateErrorCode:error];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                                 message:errorString delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [activityIndicator stopAnimating];
                 
                 // Development
                 NSLog(@"User [%@] failed to log in.", usernameField.text);
                 NSLog(@"%d", [error code]);
             }
         }];
    }
}

#pragma mark - Push view

- (void)pushView
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Error codes

- (NSString *)translateErrorCode:(NSError *)error
{
    switch ([error code])
    {
        case 101:
            return @"Login invalid.";
            break;
    }
    
    return @"Uncaught error.";
}

#pragma mark - UITextField Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger nextTag = textField.tag + 1;
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    return false;
}

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Something I guess
    }
    return self;
}

#pragma mark - ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
    [activityIndicator setHidden:true];
    [activityIndicator setHidesWhenStopped:true];
    [usernameField becomeFirstResponder];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
