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
    UIView *preV = ((UIViewController *)self.sourceViewController).view;
    UIView *newV = ((UIViewController *)self.destinationViewController).view;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    newV.center = CGPointMake(preV.center.x - preV.frame.size.width, newV.center.y);
    [window insertSubview:newV aboveSubview:preV];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         newV.center = CGPointMake(preV.center.x, newV.center.y);
                         preV.center = CGPointMake(preV.center.x + preV.frame.size.width, newV.center.y);}
                     completion:^(BOOL finished){
                         [preV removeFromSuperview];
                         window.rootViewController = self.destinationViewController;
                     }];
}

@end
