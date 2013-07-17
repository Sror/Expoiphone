//
//  MMCSInfoViewController.h
//  MMCS
//
//  Created by varun on 22/02/13.
//  Copyright (c) 2013 InApp Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"
#import "ConferenceAppDelegate.h"

@interface ConfWebViewController : UIViewController<UIWebViewDelegate>{
    
    
    NSString *titleHead;
    
}

@property (strong, nonatomic) IBOutlet UIWebView *InfoWebView;
@property (nonatomic, retain) NSString *eventId;
@property (nonatomic, retain) NSString *titleWeb;

@property(nonatomic) int selectedIndex;

@property (strong, nonatomic) MKNetworkOperation *webViewOperation;



- (IBAction)backBtnAction:(id)sender;


@end
