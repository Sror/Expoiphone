//
//  ExpoSocialViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 29/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfMainViewController.h"

@interface ExpoSocialViewController : UIViewController{
    
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)fbBtnAction:(id)sender;
- (IBAction)youTubeBtnAction:(id)sender;
- (IBAction)instBtnAction:(id)sender;
- (IBAction)twitBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *fbBtn;
@property (strong, nonatomic) IBOutlet UIButton *ytBtn;
@property (strong, nonatomic) IBOutlet UIButton *igBtn;
@property (strong, nonatomic) IBOutlet UIButton *twtBtn;

@property (strong, nonatomic) IBOutlet UILabel *homeLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *arabContainerView;

@property (strong, nonatomic) IBOutlet UIButton *arabfbBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabytBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabigBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabTwtBtn;
@property (strong, nonatomic) IBOutlet UIImageView *detImg1;
@property (strong, nonatomic) IBOutlet UIImageView *detImg2;
@property (strong, nonatomic) IBOutlet UIImageView *detImg3;
@property (strong, nonatomic) IBOutlet UIImageView *detImg4;




- (IBAction)homeBtnAction:(id)sender;
@end
