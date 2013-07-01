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
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Contact Us"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES animated:NO];
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
    
    
    
}

- (IBAction)shareBtnAction:(id)sender {
    
    
    UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:@"Facebook",
                                        @"Twitter",
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
                UIAlertView *twitAlert = [[UIAlertView alloc]initWithTitle:@"SharjahExpoCentre" message:@"Please add one Twitter account to your settings and try again" delegate:self cancelButtonTitle:@"oK" otherButtonTitles:nil, nil];
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

@end
