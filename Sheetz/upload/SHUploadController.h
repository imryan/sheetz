//
//  SHUploadController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHUploadController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextView  *descTextView;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *price;

- (IBAction)cancelUpload:(id)sender;
- (IBAction)nextView:(id)sender;

@end
