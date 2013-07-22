//
//  EventsDetailViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 09/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"
#import "MKNetworkKit.h"
#import "MapViewControllerr.h"
#import "Events.h"
#import "ConferenceHelper.h"
#import "ConfMainViewController.h"
#import "FGalleryViewController.h"
#import "SlideMenuView.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface EventsDetailViewController : UIViewController<UIActionSheetDelegate,FGalleryViewControllerDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>
{
    
    NSIndexPath   *checkedCell;
}

@property(nonatomic, retain) NSString* selectedVideo;
@property(nonatomic, retain) Events *eventDetail;
@property (strong, nonatomic)  FGalleryViewController *networkGallery;

@property (nonatomic, retain) NSMutableArray *phoneArray;

@property (nonatomic) int bounceInt;
@property (nonatomic) int fGalleryType;

@property (strong, nonatomic) IBOutlet UILabel *bounceViewHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel *sponsorHeadLabel;
@property (strong, nonatomic) IBOutlet UILabel *supporterHeadLabel;
@property (strong, nonatomic) IBOutlet UILabel *mediaPartnerHeadLabel;

@property (strong, nonatomic) IBOutlet UIButton *imagGalleryBtn;
@property (strong, nonatomic) IBOutlet UIButton *videoGalleryBtn;
@property (strong, nonatomic) IBOutlet UIButton *exhitBtn;
@property (strong, nonatomic) IBOutlet UIButton *regBtn;

@property (strong, nonatomic) IBOutlet UIButton *arabImgBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabVideoBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabExhibitBtn;
@property (strong, nonatomic) IBOutlet UIButton *arabRegBtn;

@property (strong, nonatomic) IBOutlet UIImageView *borderImgView;
@property (strong, nonatomic) IBOutlet UILabel *eventDescLabel;


@property (nonatomic, retain) NSMutableArray* sponsorArray;
@property (nonatomic, retain) NSMutableArray* supporterArray;
@property (nonatomic, retain) NSMutableArray* mediaArray;



@property (nonatomic) BOOL fromFavList;

@property (strong, nonatomic) IBOutlet UIImageView *eventLogoImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTxtView;
@property (strong, nonatomic) IBOutlet UIButton *bounceGoBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;


@property (retain, nonatomic) IBOutlet SlideMenuView *sponsorsView;
@property (retain, nonatomic) IBOutlet SlideMenuView *supportersView;
@property (retain, nonatomic) IBOutlet SlideMenuView *mediapartnersVieew;

@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIButton *brochureBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *locationBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;

@property (strong, nonatomic) IBOutlet UILabel *homLabel;
@property (strong, nonatomic) IBOutlet UILabel *brochureLabel;
@property (strong, nonatomic) IBOutlet UILabel *addCalLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapLabel;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@property (strong, nonatomic) IBOutlet UILabel *callLbabel;







@property (strong, nonatomic) IBOutlet UIView *videoGalleryView;
@property (strong, nonatomic) IBOutlet UITableView *videoGalleryTableView;
- (IBAction)closeVideosBtnAction:(id)sender;
- (IBAction)playVideoBtnAction:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *toolBarView;



@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

@property (strong, nonatomic) MKNetworkOperation *downloadOperation;



- (IBAction)imageGalleryBtnAction:(id)sender;
- (IBAction)videoGalleryBtnAction:(id)sender;
- (IBAction)exhibitorBtnAction:(id)sender;
- (IBAction)registrationBtnAction:(id)sender;


- (IBAction)HomeToolBarBtnAction:(id)sender;
- (IBAction)galleryToolBarBtnAction:(id)sender;
- (IBAction)adCalendarToolBarBtnAction:(id)sender;
- (IBAction)mapToolBarBtnAction:(id)sender;
- (IBAction)shareToolBarBtnAction:(id)sender;
- (IBAction)callToolBarBtnAction:(id)sender;



-(void)displayComposerSheet;

-(void)launchMailAppOnDevice;




@end
