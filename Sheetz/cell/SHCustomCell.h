//
//  SHCustomCell.h
//  Sheetz
//
//  Created by Ryan Cohen on 10/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *postPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCampusLabel;

@end
