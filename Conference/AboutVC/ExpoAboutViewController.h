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

@property (strong, nonatomic) IBOutlet UIScrollView *arabScrollView;

@property (strong, nonatomic) IBOutlet UIButton *historyBtn;
@property (strong, nonatomic) IBOutlet UIButton *mgmntBtn;
@property (strong, nonatomic) IBOutlet UIButton *servicesBtn;
@property (strong, nonatomic) IBOutlet UIButton *faciltiesBtn;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arabdet1;
@property (strong, nonatomic) IBOutlet UIImageView *arabdet2;
@property (strong, nonatomic) IBOutlet UIImageView *arabdet3;
@property (strong, nonatomic) IBOutlet UIImageView *arab4;

@property (strong, nonatomic) IBOutlet UIButton *arabBtnH;
@property (strong, nonatomic) IBOutlet UIButton *arabBtnM;
@property (strong, nonatomic) IBOutlet UIButton *arabBtnS;
@property (strong, nonatomic) IBOutlet UIButton *arabBtnF;
@property (strong, nonatomic) IBOutlet UIImageView *arabHImg;
@property (strong, nonatomic) IBOutlet UIImageView *arabMgImg;
@property (strong, nonatomic) IBOutlet UIImageView *arabSImg;
@property (strong, nonatomic) IBOutlet UIImageView *arabFImg;




- (IBAction)buttonClickAction:(id)sender;
- (IBAction)homeBtnAction:(id)sender;


@end
