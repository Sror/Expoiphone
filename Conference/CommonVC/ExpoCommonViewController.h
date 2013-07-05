//
//  ExpoCommonViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 06/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpoCommonViewController : UIViewController{
    
}

@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) NSString *titleHeaderString;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

- (IBAction)homBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;




@end
