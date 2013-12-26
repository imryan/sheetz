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

- (IBAction)overview:(id)sender
{
    if ([self.phoneField.text isEqualToString:@""]) {
        if ([self.emailField.text isEqualToString:@""]) {
            FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please select a contact option."];
            notifierView.timeOnScreen = 3.0;
            notifierView.alpha = 0.6f;
            [notifierView showInWindow:self.view.window];
            
        } else {
            NSLog(@"Contacting by email only");
            [self sendDataAndContinue];
        }
    }
    
    if ([self.emailField.text isEqualToString:@""]) {
        if ([self.phoneField.text isEqualToString:@""]) {
            FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please select a contact option."];
            notifierView.timeOnScreen = 3.0;
            notifierView.alpha = 0.6f;
            [notifierView showInWindow:self.view.window];
        } else {
            NSLog(@"Contacting by phone");
            [self sendDataAndContinue];
        }
    }
    
    if (![self.emailField.text isEqualToString:@""] && ![self.phoneField.text isEqualToString:@""]) {
        NSLog(@"Contacting @ phone and email");
        [self sendDataAndContinue];
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
