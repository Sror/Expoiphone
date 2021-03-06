//
//  ConfVisitorInfoViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 17/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfMainViewController.h"
#import "ConferenceAppDelegate.h"

@interface ConfVisitorInfoViewController : UIViewController{
    
    
}
- (IBAction)abtSharjahBtnAction:(id)sender;
- (IBAction)travelBtnAction:(id)sender;
- (IBAction)hotelBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *hotelBtn;
@property (strong, nonatomic) IBOutlet UIButton *travelBtn;
@property (strong, nonatomic) IBOutlet UIButton *abtBtn;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *engContainerView;

@property (strong, nonatomic) IBOutlet UIScrollView *arabContainerView;
@property (strong, nonatomic) IBOutlet UIButton *arabASBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabTVBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabHSBtn;
@property (strong, nonatomic) IBOutlet UIImageView *detImg1;
@property (strong, nonatomic) IBOutlet UIImageView *detImg2;
@property (strong, nonatomic) IBOutlet UIImageView *detImg3;




- (IBAction)homeBtnAction:(id)sender;



@end
