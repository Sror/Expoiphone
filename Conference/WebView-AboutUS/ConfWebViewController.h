//
//  MMCSInfoViewController.h
//  MMCS
//
//  Created by varun on 22/02/13.
//  Copyright (c) 2013 InApp Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConferenceAppDelegate.h"

@interface ConfWebViewController : UIViewController<UIWebViewDelegate>{
    
    
}

@property (strong, nonatomic) IBOutlet UIWebView *InfoWebView;
@property (nonatomic, retain) NSString *eventId;

@property(nonatomic) int selectedIndex;

@property (strong, nonatomic) MKNetworkOperation *webViewOperation;



- (IBAction)backBtnAction:(id)sender;


@end
