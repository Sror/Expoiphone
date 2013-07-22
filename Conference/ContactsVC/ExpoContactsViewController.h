//
//  ExpoContactsViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"
#import "MapViewControllerr.h"
#import <MessageUI/MFMailComposeViewController.h>


@interface ExpoContactsViewController : UIViewController<UIActionSheetDelegate,MFMailComposeViewControllerDelegate>{
    
    
}

- (IBAction)homeBtnAction:(id)sender;
- (IBAction)enquiryBtnAction:(id)sender;
- (IBAction)shareBtnAction:(id)sender;
- (IBAction)mapBtnAction:(id)sender;
- (IBAction)callBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *homeLabel;
@property (strong, nonatomic) IBOutlet UILabel *enqLabel;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapLabel;
@property (strong, nonatomic) IBOutlet UILabel *callLabel;

-(void)displayComposerSheet;

-(void)launchMailAppOnDevice;

@end
