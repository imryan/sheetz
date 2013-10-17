//
//  SHCustomFormCell.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCustomFormCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UITextView *titleTextView;
@property (nonatomic, retain) IBOutlet UITextView *descTextView;
@property (nonatomic, retain) IBOutlet UITextView *priceTextView;

- (NSString *)getTitleText;
- (NSString *)getDescText;
- (NSString *)getPriceText;

@end
