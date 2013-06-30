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

@interface EventsDetailViewController : UIViewController<UIActionSheetDelegate>



@property(nonatomic, retain) Events *eventDetail;


@property (nonatomic) BOOL fromFavList;

@property (strong, nonatomic) IBOutlet UIImageView *eventLogoImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTxtView;


@property (strong, nonatomic) IBOutlet UIView *toolBarView;



@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;


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








@end
