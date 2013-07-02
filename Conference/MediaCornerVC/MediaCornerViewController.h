//
//  MediaCornerViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 17/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"
#import "ConfMainViewController.h"
#import "FGalleryViewController.h"
#import "UIView+bounce.h"

@interface MediaCornerViewController : UIViewController<FGalleryViewControllerDelegate>{
    
     NSIndexPath   *checkedCell;
    
}

@property(nonatomic, retain) NSString* selectedVideo;
@property (strong, nonatomic) IBOutlet UIScrollView *mcScrollView;
@property (strong, nonatomic)  FGalleryViewController *networkGallery;

@property (nonatomic, retain) NSMutableArray *imagesList;
@property (nonatomic, retain) NSMutableArray *videosList;

@property (strong, nonatomic) IBOutlet UIView *videoGalleryView;
@property (strong, nonatomic) IBOutlet UITableView *videoGalleryTableView;
- (IBAction)videoGalleryCloseBtnAction:(id)sender;
- (IBAction)playVideoBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *pressBtn;
@property (strong, nonatomic) IBOutlet UIButton *imgGalleryBtn;
@property (strong, nonatomic) IBOutlet UIButton *videoGalleryBtn;
@property (strong, nonatomic) IBOutlet UILabel *bounceLabel;



- (IBAction)homeBtnAction:(id)sender;
- (IBAction)pressReleaseBtnAction:(id)sender;
- (IBAction)imageGalleryBtnAction:(id)sender;
- (IBAction)videoGalleryBtnAction:(id)sender;

@end
