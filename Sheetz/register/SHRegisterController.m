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
#import "SHCustomField.h"
#import "MBProgressHUD.h"

@implementation SHRegisterController

#pragma mark - Register user

- (IBAction)registerUser:(id)sender
{
    if (self.usernameField.text.length > 15) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                        message:@"Your username must be 15 characters or less." delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    if ([self.emailField.text isEqualToString:@""]
        || [self.usernameField.text isEqualToString:@""]
        || [self.passwordField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                        message:@"Please fill in the missing fields."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        [self.emailField setEnabled:false];
        [self.usernameField setEnabled:false];
        [self.passwordField setEnabled:false];
        
        self.email    = self.emailField.text;
        self.username = self.usernameField.text;
        self.password = self.passwordField.text;
        
        PFUser *user  = [PFUser user];
        user.email    = self.email;
        user.username = self.username;
        user.password = self.password;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
            hud.mode = MBProgressHUDAnimationFade;
            hud.labelText = @"Signing up";
            
            if (!error) {
                [self pushView];
                
            } else {
                NSString *errorString = [self translateErrorCode:error];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                                message:errorString
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [MBProgressHUD hideHUDForView:self.view animated:true];
                
                [self.emailField setEnabled:true];
                [self.usernameField setEnabled:true];
                [self.passwordField setEnabled:true];
                [self.emailField becomeFirstResponder];
            }
            
        }];
    }
}

#pragma mark - Push view

- (void)pushView
{
    [self dismissViewControllerAnimated:true completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
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

#pragma mark Initialization

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
    [self.emailField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.emailField becomeFirstResponder];
    
    self.emailField.delegate = self;
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end