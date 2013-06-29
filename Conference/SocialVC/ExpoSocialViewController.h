//
//  ExpoSocialViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 29/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfMainViewController.h"

@interface ExpoSocialViewController : UIViewController{
    
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)fbBtnAction:(id)sender;
- (IBAction)youTubeBtnAction:(id)sender;
- (IBAction)instBtnAction:(id)sender;
- (IBAction)twitBtnAction:(id)sender;


- (IBAction)homeBtnAction:(id)sender;
@end
