//
//  UINavigationController+Push.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 15/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UINavigationController (Push)

- (void)pushFadeViewController:(UIViewController *)viewController;
- (void)fadePopViewController;

@end
