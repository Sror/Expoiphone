//
//  StaffLoginViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 17/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfMainViewController.h"
#import "ConferenceAppDelegate.h"

@interface StaffLoginViewController : UIViewController

- (IBAction)eventVisitorBtnAction:(id)sender;
- (IBAction)exhibitorBtnAction:(id)sender;

- (IBAction)homeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *bounceView;
@property (strong, nonatomic) IBOutlet UITableView *eventTableView;
- (IBAction)closeBtnAction:(id)sender;
- (IBAction)goBtnAction:(id)sender;


@end
