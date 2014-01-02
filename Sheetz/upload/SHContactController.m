//
//  SHContactController.m
//  Sheetz
//
//  Created by Ryan Cohen on 12/26/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHContactController.h"
#import "SHAppDelegate.h"
#import "FDStatusBarNotifierView.h"
#import "SHCustomField.h"

@implementation SHContactController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)back:(id)sender
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.contactEmail = self.emailField.text;
    delegate.contactPhone = self.phoneField.text;
    [self performSegueWithIdentifier:@"backToEdit" sender:self];
}

- (BOOL)isStringEmpty:(NSString *)string
{
    if ([string length] == 0) {
        return true;
    }
    
    if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return true;
    }
    return false;
}

- (IBAction)overview:(id)sender
{
    if ([self isStringEmpty:self.phoneField.text]) {
        if ([self isStringEmpty:self.emailField.text]) {
            [self displayErrorWithString:@"Please select a contact option."];
            
        } else {
            if ([self.emailField.text rangeOfString:@"@"].location == NSNotFound) {
                [self displayErrorWithString:@"Please enter a valid email address."];
            } else {
                [self sendDataAndContinue];
            }
        }
    }
    
    else if ([self isStringEmpty:self.emailField.text]) {
        if ([self isStringEmpty:self.phoneField.text]) {
            [self displayErrorWithString:@"Please select a contact option."];
            
        } else {
            if (self.phoneField.text.length < 10) {
                [self displayErrorWithString:@"Please enter a valid phone number."];
            } else {
                [self sendDataAndContinue];
            }
        }
    }
    
    else if (![self isStringEmpty:self.emailField.text]) {
        if ([self.emailField.text rangeOfString:@"@"].location != NSNotFound) {
            if (![self isStringEmpty:self.phoneField.text]) {
                if (self.phoneField.text.length >= 10) {
                    [self sendDataAndContinue];
                } else {
                    [self displayErrorWithString:@"Please enter a valid phone number."];
                }
            }
        } else {
            [self displayErrorWithString:@"Please enter a valid email address."];
        }
    }
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

- (void)displayErrorWithString:(NSString *)message
{
    FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:message];
    notifierView.timeOnScreen = 3.0;
    notifierView.alpha = 0.6f;
    [notifierView showInWindow:self.view.window];
}

- (void)sendDataAndContinue
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.contactEmail = self.emailField.text;
    delegate.contactPhone = self.phoneField.text;
    
    [self performSegueWithIdentifier:@"overview" sender:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.emailField.delegate = self;
    self.phoneField.delegate = self;
    
    [self.emailField becomeFirstResponder];
    
    CGRect emailFrame = self.emailField.frame;
    emailFrame.size.height = 35;
    self.emailField.frame = emailFrame;
    
    CGRect phoneFrame = self.phoneField.frame;
    phoneFrame.size.height = 35;
    self.phoneField.frame = phoneFrame;
    
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.emailField.text = delegate.contactEmail;
    self.phoneField.text = delegate.contactPhone;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
