//
//  ExpoNewsDetailViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 01/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpoNewsDetailViewController : UIViewController

@property BOOL fromCommonView;

@property(nonatomic, retain) NSMutableDictionary *commonDic;

@property (nonatomic, retain) NSMutableArray *imageArray;

@property (strong, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong, nonatomic) IBOutlet UITextView *newsDetailTxtView;

@property (nonatomic, retain) News *newsDetail;

@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
- (IBAction)homeBtnAction:(id)sender;

@end
