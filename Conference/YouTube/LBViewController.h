//
//  LBViewController.h
//  LBYouTubeView
//
//  Created by Laurin Brandner on 27.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBYouTubePlayerViewController.h"

//#import "Car.h"
//#import "Event.h"
@interface LBViewController : UIViewController <LBYouTubePlayerControllerDelegate> {
    LBYouTubePlayerViewController* controller;
}

@property (nonatomic, strong) LBYouTubePlayerViewController* controller;
@property(nonatomic,strong)NSString *youtubeUrl;
-(void)Backbuton;
@property (unsafe_unretained, nonatomic) IBOutlet UINavigationBar *youtubeNavigator;
- (IBAction)shareButtonPressed:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UILabel *youTubeHeadLabel;

- (IBAction)backBtnACtion:(id)sender;

//@property(strong ,nonatomic)Property *pro;
@property(strong,nonatomic)NSString *type;
//@property(strong,nonatomic)Event *event;
@end
