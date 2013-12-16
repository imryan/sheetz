//
//  SHUploadController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHUploadController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate> {
    
    IBOutlet UIView *secondView;
    IBOutlet UIView *thirdView;
    IBOutlet UIButton *image1, *image2, *image3, *image4, *image5, *image6;
    IBOutlet UISegmentedControl *segmentControl;
    
    NSMutableArray *images;
    NSInteger tag;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *campus;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, retain) NSMutableArray *photos;

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
