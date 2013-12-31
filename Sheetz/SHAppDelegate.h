//
//  SHAppDelegate.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *campus;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, copy) NSString *contactEmail;
@property (nonatomic, copy) NSString *contactPhone;

@end
