//
//  SHCustomFormCell.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/16/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCustomFormCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextField *descTextField;
@property (nonatomic, retain) IBOutlet UITextField *priceTextField;

@end
