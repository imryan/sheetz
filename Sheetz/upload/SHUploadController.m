//
//  SHUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "MHNatGeoViewControllerTransition.h"

#import "SHUploadController.h"
#import "SHCustomField.h"
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

- (IBAction)nextView:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSInteger selectedSegment = control.selectedSegmentIndex;
    
    switch (selectedSegment) {
        case 0:
            [self.titleField becomeFirstResponder];
            [secondView setHidden:true];
            [thirdView setHidden:true];
            break;
        case 1:
            [self.descriptionField becomeFirstResponder];
            [secondView setHidden:false];
            [thirdView setHidden:true];
            break;
        case 2:
            [secondView setHidden:true];
            [self.view endEditing:true];
            [thirdView setHidden:false];
            break;
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        picker.showsCameraControls = false;
    }
    
    self.imagePickerController = picker;
    [self presentViewController:self.imagePickerController animated:true completion:nil];
}

- (IBAction)selectImage:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Menu"
                                                       delegate:self
                                              cancelButtonTitle:@"Dismiss"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Take Photo", @"Choose from library", nil];
    [sheet showInView:thirdView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"This device does not have a camera. Please select a photo from your photo library instead."
                                                               delegate:self
                                                      cancelButtonTitle:@"Dismiss"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            break;
        case 1:
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
    }
}

- (IBAction)overview:(id)sender
{
    self.title  = self.titleField.text;
    self.campus = self.campusField.text;
    self.price  = self.priceField.text;
    self.street = self.streetField.text;
}

- (IBAction)cancelUpload:(id)sender
{
    [self dismissNatGeoViewController];
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

#pragma mark ViewDidLoad & Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [secondView setHidden:true];
    [thirdView setHidden:true];
    [self.titleField becomeFirstResponder];
    
    self.titleField.delegate = self;
    self.campusField.delegate = self;
    self.priceField.delegate = self;
    self.streetField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
