//
//  SHUploadController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"

@interface SHUploadController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIView *secondView;
    IBOutlet UIView *thirdView;
}
@property FDTakeController *takeController;

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *campusField;
@property (nonatomic, retain) IBOutlet UITextField *priceField;
@property (nonatomic, retain) IBOutlet UITextField *streetField;
@property (nonatomic, retain) IBOutlet UITextView *descriptionField;

@property (nonatomic, strong) IBOutlet UIImageView *photo1;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *campus;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *street;

- (IBAction)cancelUpload:(id)sender;
- (IBAction)nextView:(id)sender;
- (IBAction)selectImage:(id)sender;
- (IBAction)overview:(id)sender;

@end
