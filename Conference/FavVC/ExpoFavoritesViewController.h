//
//  ExpoFavoritesViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"

@interface ExpoFavoritesViewController : UIViewController{
    
    UIButton *button;
}

@property (strong, nonatomic) IBOutlet UITableView *favTableView;

@property (strong, nonatomic) IBOutlet UILabel *homeLabel;

@property (nonatomic, retain) NSMutableArray *favEventsArray;
- (IBAction)homeBtnAction:(id)sender;

@end
