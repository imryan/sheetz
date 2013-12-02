//
//  SHUploadController.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "MHNatGeoViewControllerTransition.h"
#import "FDTakeController.h"

#import "SHUploadController.h"
#import "SHCustomField.h"
#import "SHAppDelegate.h"

@interface SHUploadController () <FDTakeDelegate>

@end

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

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    [self.photo1 setImage:photo];
}

- (IBAction)selectImage:(id)sender
{
    [self.takeController takePhotoOrChooseFromLibrary];
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
    
    self.takeController = [FDTakeController new];
    self.takeController.delegate = self;
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
