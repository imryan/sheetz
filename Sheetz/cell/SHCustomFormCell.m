//
//  SHCustomFormCell.m
//  Sheetz
//
//  Created by Ryan Cohen on 11/19/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHCustomFormCell.h"
#import "SHAppDelegate.h"
#import "SHCustomField.h"

@implementation SHCustomFormCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Some init
    }
    return self;
}

#pragma mark - UITextField methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            [self.descTextField canBecomeFirstResponder];
            [self.descTextField becomeFirstResponder];
            break;
        case 1:
            [self.priceTextField becomeFirstResponder];
            break;
        case 2:
            [self.campusTextField becomeFirstResponder];
            break;
    }
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.title  = self.titleTextField.text;
    self.desc   = self.descTextField.text;
    self.price  = self.priceTextField.text;
    self.campus = self.campusTextField.text;
}

- (BOOL)allFieldsEntered {
    
    if ([self.title isEqualToString:@""] ||
        [self.desc isEqualToString:@""]  ||
        [self.price isEqualToString:@""] ||
        [self.campus isEqualToString:@""]) {
        
        return false;
        
    } else {
        return true;
    }
}

- (void)layoutSubviews
{
    self.titleTextField.delegate  = self;
    self.descTextField.delegate   = self;
    self.priceTextField.delegate  = self;
    self.campusTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
