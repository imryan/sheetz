//
//  SHCustomFormCell.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHCustomFormCell.h"
#import "SHAppDelegate.h"

@implementation SHCustomFormCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Some init
    }
    return self;
}

#pragma mark - UITextField Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger nextTag = textField.tag + 1;
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    return false;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.title = self.titleTextField.text;
    self.desc  = self.descTextField.text;
    self.price = self.priceTextField.text;
    
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.title = self.title;
    delegate.desc  = self.desc;
    delegate.price = self.price;
    
    NSLog(@"TITLE: %@", self.title);
}

- (void)layoutSubviews
{
    self.titleTextField.delegate = self;
    self.descTextField.delegate  = self;
    self.priceTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
