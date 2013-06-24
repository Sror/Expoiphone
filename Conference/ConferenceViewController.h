//
//  ConferenceViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 04/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"

#import "ExpoRegViewController.h"
#import "ExpoAboutViewController.h"
#import "ExpoEventsViewController.h"
#import "ExpoFavoritesViewController.h"
#import "ExpoContactsViewController.h"
#import "ExpoMoreViewController.h"
#import "ConfMainViewController.h"

//#import "UINavigationController+Push.h"

@interface ConferenceViewController : UIViewController{
    
    
    
}
@property (strong, nonatomic) UITabBarController *tabBarController;


@property (nonatomic) BOOL regView;
- (IBAction)login:(id)sender;

- (IBAction)englishBtnAction:(id)sender;
- (IBAction)arabicBtnAction:(id)sender;


@end
