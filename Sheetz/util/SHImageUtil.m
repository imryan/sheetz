//
//  SHImageUtil.m
//  Sheetz
//
//  Created by Ryan Cohen on 12/23/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHImageUtil.h"

@implementation SHImageUtil

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
