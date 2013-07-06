//
//  ConfLocation-WebViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 30/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"

@interface ExpoLocationViewController : UIViewController<UIWebViewDelegate>{
    
    
}
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSString *eventID;
@property (nonatomic) int viewType;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIWebView *webviewForForms;

@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSegmentControl;

@property (nonatomic, retain) NSURL *filePathUrl;

@property (nonatomic) int webViewType;

@property (nonatomic) BOOL forPdfView;
@property (nonatomic) BOOL forEnquiry;


@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
- (IBAction)segmentControlAction:(id)sender;

@end
