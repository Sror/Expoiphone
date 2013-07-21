//
//  ExpoContactsViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoContactsViewController.h"
#import "ExpoLocationViewController.h"
@interface ExpoContactsViewController ()

@end

@implementation ExpoContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self applyFonts];
    // Do any additional setup after loading the view from its nib.
   // [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"cUs-title"]];
   // [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    
}

-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}

-(void)updateUI{
    
    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cUs-title"]]];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    [self.enqLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"enq"]];
    [self.shareLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"share"]];
    [self.callLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"call"]];
    [self.mapLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"locationmap"]];
    

    
    
}
-(void)applyFonts{
    
   [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
   [self.enqLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
   [self.mapLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
   [self.callLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
   [self.shareLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnAction:(id)sender {
    [self.navigationController fadePopViewController];
}

- (IBAction)enquiryBtnAction:(id)sender {
    
    /*ExpoLocationViewController *loc = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
    [loc setViewType:WEBVIEW];
    [loc setWebViewType:EVENTREGISTRATION];
    [loc setTitleStr:@"event_registration"];
    //[loc setEventID:eventDetail.event_id];
    [self.navigationController pushFadeViewController:loc];*/
    
    
    ExpoLocationViewController *loc = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
    [loc setViewType:WEBVIEW];
    [loc setWebViewType:CONTACTENQUIRYFORM];
    [loc setForEnquiry:YES];
    //[loc setTitleStr:@"Enquiry"];
    //[loc setEventID:eventDetail.event_id];
    [self.navigationController pushFadeViewController:loc];
    
    
    
    
}

- (IBAction)shareBtnAction:(id)sender {
    
    
    UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"]
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"fb"],
                                        [[ConferenceHelper SharedHelper] getLanguageForAKey:@"twitter"],
                                        nil,
                                        nil];
    
    [photoSourcePicker showInView:self.view];
    
    
    
}

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
        {
            NSLog(@"FB share");
            
            if ([[FBSession activeSession] isOpen]) {
                NSLog(@"Valid session");
                [ApplicationDelegate publishStory];
                //  [[FBSession activeSession] closeAndClearTokenInformation];
            }
            else{
                
                [ApplicationDelegate openSessionWithAllowLoginUI:YES];}
            
        }
         break;
        case 1:
        {
         NSLog(@"Twitt share");
            
            if([TWTweetComposeViewController canSendTweet])
            {
                TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
                [tweetSheet setInitialText:@"Expo Centre Sharjah"];
                // [tweetSheet addImage:[UIImage imageWithContentsOfFile:[thumbPath stringByAppendingPathComponent:[NSString stringWithFormat:@"img.jpg"]]]];
                
                [tweetSheet addImage:[UIImage imageNamed:@"logo.jpg"]];
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
               /* UIAlertView *twitAlert = [[UIAlertView alloc]initWithTitle:@"SharjahExpoCentre" message:@"Please add one Twitter account to your settings and try again" delegate:self cancelButtonTitle:@"oK" otherButtonTitles:nil, nil];
                [twitAlert show];*/
                // [self.HUD hide:YES];
                UIAlertView *twitAlert = [[UIAlertView alloc]initWithTitle:@"SharjahExpoCentre" message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"addTwitAcc"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
                [twitAlert show];
            }
        }
            break;
        default:
        break;
            
    }
}

- (IBAction)mapBtnAction:(id)sender {
    
    MapViewControllerr *mpView = [[MapViewControllerr alloc] initWithNibName:@"MapViewControllerr" bundle:nil];
    [mpView setLat:@"25.357522"];
    [mpView setLon:@"55.391865"];
    [self.navigationController pushFadeViewController:mpView];
}

- (IBAction)callBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://+97165770000"]]];
    
    
}

- (void)viewDidUnload {
    [self setHomeLabel:nil];
    [self setEnqLabel:nil];
    [self setShareLabel:nil];
    [self setMapLabel:nil];
    [self setCallLabel:nil];
    [super viewDidUnload];
}
@end
