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
#import "FDStatusBarNotifierView.h"

@implementation SHRegisterController

- (IBAction)registerUser:(id)sender
{
    if (self.usernameField.text.length > 15) {
        FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Username must be 15 characters or less."];
        notifierView.timeOnScreen = 3.0;
        notifierView.alpha = 0.6f;
        [notifierView showInWindow:self.view.window];
    }
    
    else if ([self.emailField.text isEqualToString:@""]
        || [self.usernameField.text isEqualToString:@""]
        || [self.passwordField.text isEqualToString:@""]) {

        FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please fill in all fields."];
        notifierView.timeOnScreen = 3.0;
        notifierView.alpha = 0.6f;
        [notifierView showInWindow:self.view.window];
        
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
                FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:errorString];
                notifierView.timeOnScreen = 3.0;
                notifierView.alpha = 0.6f;
                [notifierView showInWindow:self.view.window];
                
                [MBProgressHUD hideHUDForView:self.view animated:true];
                
                [self.emailField setEnabled:true];
                [self.usernameField setEnabled:true];
                [self.passwordField setEnabled:true];
                [self.emailField becomeFirstResponder];
            }
            
        }];
    }
}

- (void)pushView
{
    [self dismissViewControllerAnimated:true completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
}

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
            
        case 125:
            return @"Invalid email.";
            break;
    }
    
    return @"Uncaught error.";
}

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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.masksToBounds = true;
    textField.layer.cornerRadius = 5;
    textField.layer.borderColor = [[UIColor grayColor]CGColor];
    textField.layer.borderWidth = 1.0f;
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.layer.masksToBounds = true;
    textField.layer.borderColor = [[UIColor clearColor]CGColor];
    textField.layer.borderWidth = 1.0f;
    return true;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Some init
    }
    return self;
}

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
    
    CGRect emailFrame = self.emailField.frame;
    emailFrame.size.height = 35;
    self.emailField.frame = emailFrame;
    
    CGRect usernameFrame = self.usernameField.frame;
    usernameFrame.size.height = 35;
    self.usernameField.frame = usernameFrame;
    
    CGRect passwordFrame = self.passwordField.frame;
    passwordFrame.size.height = 35;
    self.passwordField.frame = passwordFrame;
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