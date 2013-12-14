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
#import "SHCustomField.h"

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
                 [self.activityIndicator stopAnimating];
                 [self performSegueWithIdentifier:@"login" sender:self];
                 
             } else {
                 
                 NSString *errorString = [self translateErrorCode:error];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                                 message:errorString delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [self.activityIndicator stopAnimating];
             }
         }];
    }
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return false;
    
    if ([textField isKindOfClass:[SHCustomField class]])
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[(SHCustomField *)textField nextField] becomeFirstResponder];
            
        });
    
    return true;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.usernameField becomeFirstResponder];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
