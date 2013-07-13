//
//  ExpoMoreViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"
#import "ConfMainViewController.h"
#import "MediaCornerViewController.h"
#import "ConfVisitorInfoViewController.h"
#import "ExpoSocialViewController.h"
#import "ConfSignInViewController.h"

@interface ExpoMoreViewController : UIViewController{
    
    
}
@property (strong, nonatomic) IBOutlet UIScrollView *moreScrollView;

@property (strong, nonatomic) IBOutlet UIButton *mediaBtn;
@property (strong, nonatomic) IBOutlet UIButton *visitorBtn;
@property (strong, nonatomic) IBOutlet UIButton *socialMediaBtn;
@property (strong, nonatomic) IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) IBOutlet UIButton *subFormBtn;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;



- (IBAction)mediaCornerBtnAction:(id)sender;
- (IBAction)visitorInfoBtnAction:(id)sender;
- (IBAction)socialMediaBtnAction:(id)sender;
- (IBAction)staffLoginBtnAction:(id)sender;
- (IBAction)subFormBtnAction:(id)sender;

- (IBAction)homeBtnAction:(id)sender;

@end
