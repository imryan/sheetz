//
//  SHPushSegue.m
//  Sheetz
//
//  Created by Ryan Cohen on 12/14/13.
//  Copyright (c) 2013 Ryan Cohen. All rights reserved.
//

#import "SHPushSegue.h"

@implementation SHPushSegue

- (void)perform
{
    UIViewController *source = [self sourceViewController];
    UIViewController *dest   = [self destinationViewController];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    [source.view.window.layer addAnimation:transition forKey:nil];
    [source presentViewController:dest animated:NO completion:nil];
}

@end
