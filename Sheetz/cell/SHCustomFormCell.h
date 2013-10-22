//
//  SHCustomFormCell.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCustomFormCell : UITableViewCell <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextView  *descTextView;
@property (nonatomic, retain) IBOutlet UITextField *priceTextField;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *price;

@end
