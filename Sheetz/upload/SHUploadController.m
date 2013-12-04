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
            [self enableFields];
            [self.titleField becomeFirstResponder];
            [self.descriptionField setEditable:false];
            [secondView setHidden:true];
            [thirdView setHidden:true];
            break;
        case 1:
            [self disableFields];
            [self.descriptionField setEditable:true];
            [self.descriptionField becomeFirstResponder];
            [secondView setHidden:false];
            [thirdView setHidden:true];
            break;
        case 2:
            [self disableFields];
            [secondView setHidden:true];
            [self.descriptionField setEditable:false];
            [self.view endEditing:true];
            [thirdView setHidden:false];
            break;
    }
}

- (void)disableFields
{
    [self.titleField setEnabled:false];
    [self.campusField setEnabled:false];
    [self.priceField setEnabled:false];
    [self.streetField setEnabled:false];
}

- (void)enableFields
{
    [self.titleField setEnabled:true];
    [self.campusField setEnabled:true];
    [self.priceField setEnabled:true];
    [self.streetField setEnabled:true];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        picker.showsCameraControls = true;
    }
    
    self.imagePickerController = picker;
    [self presentViewController:self.imagePickerController animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.photo1 setImage:image];
    
    [self dismissViewControllerAnimated:true completion:nil];
    [thirdView setHidden:false];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:true completion:nil];
    [thirdView setHidden:false];
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
                [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            } else {
                [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
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
    self.desc   = self.descriptionField.text;
    self.campus = self.campusField.text;
    self.price  = self.priceField.text;
    self.street = self.streetField.text;
    
    if ([self.title isEqualToString:@""]  ||
        [self.campus isEqualToString:@""] ||
        [self.price isEqualToString:@""]  ||
        [self.desc isEqualToString:@""]   ||
        [self.street isEqualToString:@""]) {
        
        NSLog(@"Incompleted form!");
        
    } else {
        
        SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.title  = self.title;
        delegate.desc   = self.desc;
        delegate.price  = self.price;
        delegate.campus = self.campus;
        delegate.street = self.street;
        
        [self performSegueWithIdentifier:@"overview" sender:self];
    }
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
