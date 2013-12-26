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
            FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please select a contact option."];
            notifierView.timeOnScreen = 3.0;
            notifierView.alpha = 0.6f;
            [notifierView showInWindow:self.view.window];
            
        } else {
            
            if ([self.emailField.text rangeOfString:@"@"].location == NSNotFound) {
                FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please enter a valid email address."];
                notifierView.timeOnScreen = 3.0;
                notifierView.alpha = 0.6f;
                [notifierView showInWindow:self.view.window];
            } else {
                [self sendDataAndContinue];
            }
        }
    }
    
    if ([self isStringEmpty:self.emailField.text]) {
        if ([self isStringEmpty:self.phoneField.text]) {
            FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please select a contact option."];
            notifierView.timeOnScreen = 3.0;
            notifierView.alpha = 0.6f;
            [notifierView showInWindow:self.view.window];
        } else {
            
            if (self.phoneField.text.length < 10) {
                FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please enter a valid phone number."];
                notifierView.timeOnScreen = 3.0;
                notifierView.alpha = 0.6f;
                [notifierView showInWindow:self.view.window];
            } else {
                [self sendDataAndContinue];
            }
        }
    }
    
    if (![self isStringEmpty:self.emailField.text] && ![self isStringEmpty:self.phoneField.text] &&
        [self.emailField.text rangeOfString:@"@"].location != NSNotFound && self.phoneField.text.length >= 10) {
        
        NSLog(@"Contacting @ phone and email");
        [self sendDataAndContinue];
    } else {
        FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please enter a valid phone number & email address."];
        notifierView.timeOnScreen = 3.0;
        notifierView.alpha = 0.6f;
        [notifierView showInWindow:self.view.window];
    }
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
    [self.emailField becomeFirstResponder];
    
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