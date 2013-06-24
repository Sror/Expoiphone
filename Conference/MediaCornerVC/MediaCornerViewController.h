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

@interface MediaCornerViewController : UIViewController<FGalleryViewControllerDelegate>{
    
    
}
@property (strong, nonatomic) IBOutlet UIScrollView *mcScrollView;
@property (strong, nonatomic)  FGalleryViewController *networkGallery;

@property (nonatomic, retain) NSMutableArray *imagesList;
@property (nonatomic, retain) NSMutableArray *videosList;

- (IBAction)homeBtnAction:(id)sender;
- (IBAction)pressReleaseBtnAction:(id)sender;
- (IBAction)imageGalleryBtnAction:(id)sender;
- (IBAction)videoGalleryBtnAction:(id)sender;

@end
