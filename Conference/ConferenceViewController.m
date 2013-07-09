//
//  ConferenceViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 04/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConferenceViewController.h"





@interface ConferenceViewController ()

@end

@implementation ConferenceViewController

@synthesize regView;
@synthesize tabBarController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
 
    
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    if ([[[[ConferenceHelper SharedHelper] ReadFromthePlistFile:@"RegView.plist"] valueForKey:@"reg"]isEqualToString:@"1"]) {
        NSLog(@"Exists");
        [self setRegView:1];
    }else{
         NSLog(@"Null");
        [self setRegView:0];
    }
    
    NSLog(@"dic saved is %@",[[[ConferenceHelper SharedHelper] ReadFromthePlistFile:@"RegView.plist"] valueForKey:@"reg"]);
    
   // [self setRegView:[[[ConferenceHelper SharedHelper] ReadFromthePlistFile:@"RegView.plist"] valueForKey:@"reg"]];}
}


- (IBAction)login:(id)sender {
    
    
    ////FB WORKING CODE
    
   /* if ([[FBSession activeSession] isOpen]) {
        NSLog(@"Valid session");
        [ApplicationDelegate publishStory];
      //  [[FBSession activeSession] closeAndClearTokenInformation];
    }
    else{
    
        [ApplicationDelegate openSessionWithAllowLoginUI:YES];}*/
    
    ////Twitter WORKING CODE
    
    
   /* if([TWTweetComposeViewController canSendTweet])
    {
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:@"Twitter Test Project"];
       // [tweetSheet addImage:[UIImage imageWithContentsOfFile:[thumbPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img.jpg"]]]];
        
        [tweetSheet addImage:[UIImage imageNamed:@"Default.png"]];
      //  [self.navController presentModalViewController:tweetSheet animated:YES];
     //   [self.navigationController]
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
        tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result)  {
            
            [tweetSheet.view removeFromSuperview];
            switch (result) {
                case TWTweetComposeViewControllerResultCancelled:
                    //[self.HUD hide:YES];
                    
                    NSLog(@"TWTweetComposeViewControllerResultCancelled");
                    break;
                case TWTweetComposeViewControllerResultDone: {
                    
                    NSLog(@"TWTweetComposeViewControllerResultDone");
                    
                    break;
                default:
                    break;
                }
            }
        };
    }else
    {
        // you can show alert here
       // [self.HUD hide:YES];
        UIAlertView *twitAlert = [[UIAlertView alloc]initWithTitle:@"SharjahExpoCentre" message:@"Please add one Twitter account to your settings and try again" delegate:self cancelButtonTitle:@"oK" otherButtonTitles:nil, nil];
        [twitAlert show];
    }*/
}

-(void)showExpoRegistrationView{
    
    ExpoRegViewController * expiew = [[ExpoRegViewController alloc] initWithNibName:@"ExpoRegViewController" bundle:nil];
    
    [self.navigationController pushFadeViewController:expiew];
    
}

/*-(void)showMainHomeView{
    
    ConfMainViewController *mainView = [[ConfMainViewController alloc] initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:mainView];
    
}*/


- (IBAction)englishBtnAction:(id)sender {
    
    ApplicationDelegate.langBool=LANG_English;
    [ApplicationDelegate setLangCode:ENG_Code];
    if (!regView) {
        [self showExpoRegistrationView];
    }else{
        [ApplicationDelegate showMainHomeView];
    }

    
}

- (IBAction)arabicBtnAction:(id)sender {
    ApplicationDelegate.langBool=LANG_ARABIC;
    [ApplicationDelegate setLangCode:ARAB_Code];
    
    if (!regView) {
        [self showExpoRegistrationView];
    }else{
        //[self createTabBarViewControllers];
         [ApplicationDelegate showMainHomeView];
    }
}




 
  
 
 


@end
