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

#pragma mark - Login user

- (IBAction)loginUser:(id)sender
{
    if ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                        message:@"Please enter in all fields." delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        
        [self.activityIndicator startAnimating];
        
        self.username = self.usernameField.text;
        self.password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:self.username password:self.password block:^(PFUser *user, NSError *error)
         {
             if (user)
             {
                 // Change view
                 [self.activityIndicator stopAnimating];
                 [self pushView];
                 
                 // Development
                 NSLog(@"User [%@] successfully logged in.", self.usernameField.text);
                 
             } else {
                 
                 NSString *errorString = [self translateErrorCode:error];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                                 message:errorString delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [self.activityIndicator stopAnimating];
                 
                 // Development
                 NSLog(@"User [%@] failed to log in.", self.username);
                 NSLog(@"%ld", (long)[error code]);
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
    
    NSInteger nextTag = textField.tag++;
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
        // Some init
    }
    return self;
}

#pragma mark - ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator setHidden:true];
    [self.activityIndicator setHidesWhenStopped:true];
    [self.usernameField becomeFirstResponder];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
