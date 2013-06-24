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

@interface ConfMainViewController : UIViewController<UIScrollViewDelegate>{
    
    BOOL pageControlBeingUsed;
    CGPoint offset; 
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UITableView *latestNewsTableView;
@property (nonatomic, retain) NSMutableArray *latestNewsList;



@end
