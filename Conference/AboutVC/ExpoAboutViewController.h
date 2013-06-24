//
//  ExpoAboutViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"
#import "ConfWebViewController.h"

@interface ExpoAboutViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIScrollView *aboutUsScrollView;


- (IBAction)buttonClickAction:(id)sender;

- (IBAction)homeBtnAction:(id)sender;


@end
