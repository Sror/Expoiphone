//
//  ExpoEventsViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"
#import "EventsCell.h"
#import "EventsDetailViewController.h"
#import "ConfEventSearchViewController.h"

@interface ExpoEventsViewController : UIViewController{
    
    
}


@property BOOL fromSearch;

@property (strong, nonatomic) IBOutlet UIButton *searchBtn;


@property (nonatomic, retain) NSMutableArray *eventsList;

@property (strong, nonatomic) IBOutlet UITableView *eventsListTableView;
- (IBAction)searchBtnAction:(id)sender;

@end
