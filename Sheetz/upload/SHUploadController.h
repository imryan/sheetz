//
//  SHUploadController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHUploadController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate> {
    
    IBOutlet UISegmentedControl *segmentControl;
    IBOutlet UIImageView *imageView;
    IBOutlet UIView *secondView;
    IBOutlet UIView *thirdView;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *campus;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, retain) UIImage *photo;

@property (nonatomic) UIImagePickerController *imagePickerController;

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *campusField;
@property (nonatomic, retain) IBOutlet UITextField *priceField;
@property (nonatomic, retain) IBOutlet UITextField *streetField;
@property (nonatomic, retain) IBOutlet UITextView *descriptionField;

- (IBAction)cancelUpload:(id)sender;
- (IBAction)nextView:(id)sender;
- (IBAction)selectImage:(id)sender;
- (IBAction)overview:(id)sender;

@end
