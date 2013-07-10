//
//  ConfMainViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 15/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExpoAboutViewController.h"
#import "ExpoEventsViewController.h"
#import "ExpoFavoritesViewController.h"
#import "ExpoContactsViewController.h"
#import "ExpoMoreViewController.h"

#import "MKNetworkOperation.h"
#import "MKNetworkKit.h"
#import "UIImageView+MKNetworkKitAdditions.h"


@interface ConfMainViewController : UIViewController<UIScrollViewDelegate>{
    
    BOOL pageControlBeingUsed;
    CGPoint offset;
    UILabel *titleView2;
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UITableView *latestNewsTableView;
@property (nonatomic, retain) NSMutableArray *latestNewsList;


@property (strong, nonatomic) IBOutlet UILabel *latestNewsHeaderLabel;

@property (nonatomic, retain) NSMutableArray *currentEventArr;



@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;


@property (strong, nonatomic) IBOutlet UIView *toolBarView;
@property (strong, nonatomic) IBOutlet UIButton *aboutUsBtn;
@property (strong, nonatomic) IBOutlet UIButton *eventsBtn;
@property (strong, nonatomic) IBOutlet UIButton *favBtn;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;








-(void)viewWillAppear:(BOOL)animated;

-(void)refreshView:(NSNotification *) notification;


@end
