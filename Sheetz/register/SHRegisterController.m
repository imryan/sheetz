//
//  SHRegisterController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <Parse/Parse.h>
#import "SHRegisterController.h"
#import "SHFirstViewController.h"
#import "MHNatGeoViewControllerTransition.h"

@implementation SHRegisterController

#pragma mark - Register user

- (IBAction)registerUser:(id)sender
{
    // Make sure the username is < 15 chars
    if (self.usernameField.text.length > 15)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                        message:@"Your username must be 15 characters or less." delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        // Check if all the fields are filled
        if ([self.emailField.text isEqualToString:@""] || [self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                            message:@"Please fill in the missing fields."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    } else {
        
        [self.activityIndicator startAnimating];
        
        self.email    = self.emailField.text;
        self.username = self.usernameField.text;
        self.password = self.passwordField.text;
        
        PFUser *user = [PFUser user];
        user.email    = self.email;
        user.username = self.username;
        user.password = self.password;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         
         {
             if (!error)
             {
                 // Move to next view for welcome/tutorial
                 [self.activityIndicator stopAnimating];
                 [self pushView];
                 
                 // Development
                 NSLog(@"User [%@] successfully registered.", user.username);
                 
             } else {
                 
                 NSString *errorString = [self translateErrorCode:error];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                                 message:errorString
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [self.activityIndicator stopAnimating];
                 
                 // Development
                 NSLog(@"User [%@] failed to register.", user.username);
             }
             
         }];
    }
}

#pragma mark - Push view

- (void)pushView
{
    [self dismissNatGeoViewController];
    [self.presentingViewController dismissNatGeoViewController];
}

#pragma mark - Error codes

- (NSString *)translateErrorCode:(NSError *)error
{
    switch ([error code])
    {
        case 203:
            return @"That email is already in use.";
            break;
            
        case 202:
            return @"That username is already in use.";
            break;
    }
    
    return @"Uncaught error.";
}

#pragma mark - UITextField methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = textField.tag++;
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return false;
}

#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.emailField.delegate = self;
        self.usernameField.delegate = self;
        self.passwordField.delegate = self;
    }
    return self;
}

#pragma mark - ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator setHidden:true];
    [self.activityIndicator setHidesWhenStopped:true];
    [self.emailField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.emailField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end