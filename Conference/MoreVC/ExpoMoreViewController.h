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

@interface ExpoMoreViewController : UIViewController{
    
    
}
@property (strong, nonatomic) IBOutlet UIScrollView *moreScrollView;




- (IBAction)mediaCornerBtnAction:(id)sender;
- (IBAction)visitorInfoBtnAction:(id)sender;
- (IBAction)socialMediaBtnAction:(id)sender;
- (IBAction)staffLoginBtnAction:(id)sender;
- (IBAction)subFormBtnAction:(id)sender;

- (IBAction)homeBtnAction:(id)sender;

@end
