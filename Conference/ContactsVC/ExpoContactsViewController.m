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
                                        [[ConferenceHelper SharedHelper] getLanguageForAKey:@"email"],
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
        case 2:{
            Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
            
            if (mailClass != nil)
                
            {
                
                // We must always check whether the current device is configured for sending emails
                
                if ([mailClass canSendMail])
                    
                {
                    
                    [self displayComposerSheet];
                    
                }
                
                else
                    
                {
                    
                    [self launchMailAppOnDevice];
                    
                }
                
            }
            
            else
                
            {
                
                [self launchMailAppOnDevice];
                
            }
            
        }
            break;

        default:
        break;
            
    }
}

#pragma mark -

#pragma mark Compose Mail



// Displays an email composition interface inside the application. Populates all the Mail fields.

-(void)displayComposerSheet

{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate = self;
    
    
    
    [picker setSubject:@"Sharjah Expo App"];
    
    // Set up recipients
    
    NSArray *toRecipients = [NSArray arrayWithObject:@""];
    
    /*NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
     
     NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];*/
    
    
    
    [picker setToRecipients:toRecipients];
    
    /*[picker setCcRecipients:ccRecipients];
     
     [picker setBccRecipients:bccRecipients];*/
    
    
    
    // Attach an image to the email
    
    /* NSString *path = [[NSBundle mainBundle] pathForResource:@”rainy” ofType:@”png”];
     
     NSData *myData = [NSData dataWithContentsOfFile:path];
     
     [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
     */
    
    
    // Fill out the email body text
    
    NSString *emailBody = @"";
    
    [picker setMessageBody:emailBody isHTML:NO];
    
    
    
    [self presentModalViewController:picker animated:YES];
    
    // [picker release];
    
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    NSString *message;
    
    // message.hidden = NO;
    
    // Notifies users about errors associated with the interface
    
    switch (result)
    
    {
            
        case MFMailComposeResultCancelled:
            
            //  message.text =
            
            message = @"Message canceled";
            
            break;
            
        case MFMailComposeResultSaved:
            
            //message.text = @”Result: saved”;
            message = @"Message saved";
            
            break;
            
        case MFMailComposeResultSent:
            
            // message.text = @”Result: sent”;
            message = @"Message sent";
            
            break;
            
        case MFMailComposeResultFailed:
            
            // message.text = @”Result: cancelled”;
            message = @"Message canceled";
            
            break;
            
        default:
            
            message = @"Message not sent";
            // message.text = @”Result: not sent”;
            
            break;
            
    }
    
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    al .tag = 10001;
    [al show];
    
    //[self dismissModalViewControllerAnimated:YES];
    
}

#pragma mark -

#pragma mark Workaround

// Launches the Mail application on the device.

-(void)launchMailAppOnDevice

{
    
    /* NSString *recipients = @”mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!”;
     
     NSString *body = @”&body=It is raining in sunny California!”;
     
     
     
     NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
     
     email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     
     
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];*/
    
}

- (IBAction)mapBtnAction:(id)sender {
    
    MapViewControllerr *mpView = [[MapViewControllerr alloc] initWithNibName:@"MapViewControllerr" bundle:nil]; //25.311248, 55.370275
    [mpView setLat:@"25.311248"];
    [mpView setLon:@"55.370275"];
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
