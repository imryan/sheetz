//
//  SHContactController.h
//  Sheetz
//
//  Created by Ryan Cohen on 12/26/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHContactController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *phoneField;

- (IBAction)back:(id)sender;
- (IBAction)overview:(id)sender;
- (void)sendDataAndContinue;

@end
