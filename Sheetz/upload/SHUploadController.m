//
//  SHUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHUploadController.h"
#import "SHCustomField.h"
#import "SHAppDelegate.h"
#import "SHImageUtil.h"
#import "SHContactController.h"
#import "FDStatusBarNotifierView.h"

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
    picker.allowsEditing = true;
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
    
    [self dismissViewControllerAnimated:true completion:nil];
    [segmentControl setSelectedSegmentIndex:2];
    [secondView setHidden:true];
    [thirdView setHidden:false];
    [self disableFields];

    self.photo = image;
    imageView.image = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:true completion:nil];
    [segmentControl setSelectedSegmentIndex:2];
    [thirdView setHidden:false];
    [secondView setHidden:true];
    [self disableFields];
    
    [self preferredStatusBarStyle];
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
    self.title  = self.titleField.text;
    self.desc   = self.descriptionField.text;
    self.campus = self.campusField.text;
    self.price  = self.priceField.text;
    self.street = self.streetField.text;
    
    if ([self isStringEmpty:self.title]  ||
        [self isStringEmpty:self.campus] ||
        [self isStringEmpty:self.price] ||
        [self isStringEmpty:self.desc]  ||
        [self isStringEmpty:self.street]) {
        
        FDStatusBarNotifierView *notifierView = [[FDStatusBarNotifierView alloc] initWithMessage:@"Please complete the form."];
        notifierView.timeOnScreen = 3.0;
        notifierView.alpha = 0.6f;
        [notifierView showInWindow:self.view.window];
        
    } else {
        
        SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.title  = self.title;
        delegate.desc   = self.desc;
        delegate.price  = self.price;
        delegate.campus = self.campus;
        delegate.street = self.street;
        
        self.photo = [SHImageUtil imageWithImage:self.photo scaledToSize:CGSizeMake(320, 285)];
        delegate.photo = self.photo;
        
        [self performSegueWithIdentifier:@"contact" sender:self];
    }
}

- (IBAction)cancelUpload:(id)sender
{
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.title  = @"";
    delegate.desc   = @"";
    delegate.price  = @"";
    delegate.campus = @"";
    delegate.street = @"";
    delegate.photo = nil;
    delegate.contactEmail = @"";
    delegate.contactPhone = @"";
    
    [self dismissViewControllerAnimated:true completion:nil];
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
    textField.layer.borderColor = [[UIColor grayColor] CGColor];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.titleField.text = delegate.title;
    self.campusField.text = delegate.campus;
    self.priceField.text = delegate.price;
    self.streetField.text = delegate.street;
    self.descriptionField.text = delegate.desc;
    imageView.image = delegate.photo;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.titleField.delegate = self;
    self.campusField.delegate = self;
    self.priceField.delegate = self;
    self.streetField.delegate = self;
    
    [segmentControl setSelectedSegmentIndex:0];
    [self enableFields];
    [self.titleField becomeFirstResponder];
    
    [secondView setHidden:true];
    [thirdView setHidden:true];
    
    CGRect titleFrame = self.titleField.frame;
    titleFrame.size.height = 35;
    self.titleField.frame = titleFrame;
    
    CGRect campusFrame = self.campusField.frame;
    campusFrame.size.height = 35;
    self.campusField.frame = campusFrame;
    
    CGRect priceFrame = self.priceField.frame;
    priceFrame.size.height = 35;
    self.priceField.frame = priceFrame;
    
    CGRect streetFrame = self.streetField.frame;
    streetFrame.size.height = 35;
    self.streetField.frame = streetFrame;
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