//
//  SHLaunchController.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHLaunchController : UIViewController

@property (assign, nonatomic) BOOL didLogin;
@property (assign, nonatomic) BOOL didRegister;

- (IBAction)pushRegisterView:(id)sender;
- (IBAction)pushLoginView:(id)sender;

@end
