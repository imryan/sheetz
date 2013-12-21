//
//  SHBackSegue.m
//  Sheetz
//
//  Created by Ryan Cohen on 12/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHBackSegue.h"

@implementation SHBackSegue

- (void)perform
{
    UIViewController *source = [self sourceViewController];
    UIViewController *dest   = [self destinationViewController];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.30;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [source.view.window.layer addAnimation:transition forKey:nil];
    [source presentViewController:dest animated:false completion:nil];
}

@end
