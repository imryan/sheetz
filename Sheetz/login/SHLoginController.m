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
#import "MBProgressHUD.h"
#import "FDStatusBarNotifierView.h"

@implementation SHLoginController

- (IBAction)loginUser:(id)sender
{
    if ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""])
    {
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                        message:@"Please enter in all fields." delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
         */
        
        FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please fill in all fields!"];
        notifierView.timeOnScreen = 3.0;
        notifierView.alpha = 0.6f;
        [notifierView showInWindow:self.view.window];
        
    } else {
        
        [self.usernameField setEnabled:false];
        [self.passwordField setEnabled:false];
        
        self.username = self.usernameField.text;
        self.password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:self.username password:self.password block:^(PFUser *user, NSError *error) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
            hud.mode = MBProgressHUDAnimationFade;
            hud.labelText = @"Logging in";
            
             if (user) {
                 [self performSegueWithIdentifier:@"login" sender:self];
                 
             } else {
                 NSString *errorString = [self translateErrorCode:error];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sheets"
                                                                 message:errorString delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 [MBProgressHUD hideHUDForView:self.view animated:true];
                 
                 [self.usernameField setEnabled:true];
                 [self.passwordField setEnabled:true];
             }
         }];
    }
}

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

- (void)viewWillAppear:(BOOL)animated
{
    [self.usernameField becomeFirstResponder];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
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
