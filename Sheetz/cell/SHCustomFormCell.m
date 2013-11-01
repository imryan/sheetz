//
//  SHCustomFormCell.m
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
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

#pragma mark - UITextField/TextView Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return false;
    
    if ([textField isKindOfClass:[SHCustomField class]])
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[(SHCustomField *)textField nextField] becomeFirstResponder];
            
        });
    
    return true;
}
    
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.title = self.titleTextField.text;
    self.desc  = self.descTextView.text;
    self.price = self.priceTextField.text;
    
    SHAppDelegate *delegate = (SHAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.title = self.title;
    delegate.desc  = self.desc;
    delegate.price = self.price;
    
    NSLog(@"Title on ending: %@", delegate.title);
}

#pragma mark - LayoutSubviews & Friends

- (void)layoutSubviews
{
    self.titleTextField.delegate = self;
    self.descTextView.delegate  = self;
    self.priceTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
