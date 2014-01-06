//
//  SHDetailController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/24/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHDetailController.h"
#import "SHFirstViewController.h"
#import "FDStatusBarNotifierView.h"
#import <MessageUI/MFMailComposeViewController.h>

@implementation SHDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)formatPhoneNumber:(NSString *)number
{
    NSString *formattedString = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@")" withString:@""];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return formattedString;
}

- (IBAction)contact:(id)sender
{
    if ([self.contactEmail isEqualToString:@""]) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Contact"
                                                           delegate:self
                                                  cancelButtonTitle:@"Dismiss"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:[self formatPhoneNumber:self.contactPhone], nil];
        
        [sheet showInView:self.view];
        
    } else if (![self.contactEmail isEqualToString:@""] && ![self.contactPhone isEqualToString:@""]) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Contact"
                                                           delegate:self
                                                  cancelButtonTitle:@"Dismiss"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:[self formatPhoneNumber:self.contactPhone], self.contactEmail, nil];
        
        [sheet showInView:self.view];
    
    } else {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Contact"
                                                           delegate:self
                                                  cancelButtonTitle:@"Dismiss"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:self.contactEmail, nil];
        
        [sheet showInView:self.view];
    }
}

- (IBAction)description:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Description"
                                                    message:self.descriptionString
                                                   delegate:self
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)done:(id)sender
{
    [self performSegueWithIdentifier:@"detailDone" sender:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *option = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([option isEqualToString:@"Dismiss"]) {
        return;
    }
    
    else if ([option rangeOfString:@"@"].location != NSNotFound) {
        
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:@[self.contactEmail]];
        [controller setSubject:self.listingTitle.text];
        [controller setMessageBody:@"" isHTML:NO];
        
        [self presentViewController:controller animated:true completion:nil];
        
    } else {
        
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [self formatPhoneNumber:self.contactPhone]]]];
            
        } else {
            FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"This device cannot make calls."];
            notifierView.timeOnScreen = 3.0;
            notifierView.alpha = 0.6f;
            [notifierView showInWindow:self.view.window];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *resultString;
    switch (result) {
        case MFMailComposeResultSent:
            resultString = @"Mail sent.";
            break;
        case MFMailComposeResultFailed:
            resultString = @"Mail not sent.";
            break;
        case MFMailComposeResultSaved:
            resultString = @"Mail saved. Was not sent.";
            break;
        case MFMailComposeResultCancelled:
            resultString = @"Mail not sent.";
            break;
    }
    
    FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:resultString];
    notifierView.timeOnScreen = 3.0;
    notifierView.alpha = 0.6f;
    [notifierView showInWindow:self.view.window];
    
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    PFImageView *imageView = [PFImageView new];
    imageView.file = self.file;
    
    self.listingImage.image = imageView.image;
    self.listingTitle.text = [self.information objectForKey:@"title"];
    self.listingPrice.text = [self.information objectForKey:@"price"];
    self.listingCampus.text = [self.information objectForKey:@"campus"];
    self.listingStreet.text = [self.information objectForKey:@"street"];
    self.descriptionString = [self.information objectForKey:@"description"];
    
    self.contactEmail = [self.information objectForKey:@"email"];
    self.contactPhone = [self.information objectForKey:@"phone"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
