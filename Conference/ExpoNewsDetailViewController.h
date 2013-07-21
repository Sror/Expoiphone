//
//  ExpoNewsDetailViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 01/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGalleryViewController.h"

@interface ExpoNewsDetailViewController : UIViewController<FGalleryViewControllerDelegate>{
    
    UIButton *button;
}

@property BOOL fromCommonView;

@property(nonatomic, retain) NSMutableDictionary *commonDic;
@property (nonatomic, retain) NSString *titleHeaderString;

@property (nonatomic, retain) NSMutableArray *imageArray;

@property (strong, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong, nonatomic) IBOutlet UITextView *newsDetailTxtView;

@property (nonatomic, retain) News *newsDetail;

@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

@property (strong, nonatomic) IBOutlet UIButton *playBtn;
- (IBAction)playBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;



@property (strong, nonatomic)  FGalleryViewController *networkGallery;


- (IBAction)homeBtnAction:(id)sender;




@end
