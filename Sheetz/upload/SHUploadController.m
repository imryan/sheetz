//
//  SHUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "MHNatGeoViewControllerTransition.h"

#import "SHUploadController.h"
#import "SHAppDelegate.h"

@implementation SHUploadController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)nextView:(id)sender
{
    self.title  = self.titleTextField.text;
    self.desc   = self.descTextView.text;
    self.price  = self.priceTextField.text;
    self.campus = self.campusTextField.text;
    
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.title  = self.title;
    delegate.desc   = self.desc;
    delegate.price  = self.price;
    delegate.campus = self.campus;
    
    [self performSegueWithIdentifier:@"nextListing" sender:self];
}

- (IBAction)cancelUpload:(id)sender
{
    [self dismissNatGeoViewController];
}

#pragma mark ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView setScrollEnabled:true];
    [self.scrollView setContentSize:CGSizeMake(320, 1000)];
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
