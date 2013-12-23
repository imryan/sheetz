//
//  SHImageUtil.h
//  Sheetz
//
//  Created by Ryan Cohen on 12/23/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHImageUtil : UIImage

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
