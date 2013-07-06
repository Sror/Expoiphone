//
//  EventsDetailViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 09/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "ExpoLocationViewController.h"
#import "LBViewController.h"
#import "ExhibitCell.h"
#import "ExpoCommonViewController.h"
#import <EventKit/EventKit.h>

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController

@synthesize eventDetail;
@synthesize fromFavList,networkGallery,selectedVideo,phoneArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        phoneArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Event Details"]];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:backBtn]];
    UIButton *favBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [favBtn addTarget:self action:@selector(favBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [favBtn setImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnAbt = [[UIBarButtonItem alloc] initWithCustomView:favBtn];
    
    UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed1.width = 40.0f;
    
    if (!fromFavList) {
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:fixed1,btnAbt, nil]];
    }
    
    [self.view addSubview:ApplicationDelegate.HUD];
    ApplicationDelegate.HUD.labelText = @"Downloading";
    
    [self.videoGalleryView setFrame:CGRectMake(15, 5, self.videoGalleryView.frame.size.width, self.videoGalleryView.frame.size.height)];
    
    
    [self.eventNameLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:17.0]];
    [self.dateLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:11.0]];
    [self.timeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:10.0]];
    [self.categoryLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
    [self.locationLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:12.0]];
    [self.descriptionTxtView setFont:[UIFont fontWithName:@"Eagle-Light" size:11.0]];
    
    [self.mediaPartnerHeadLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
    [self.sponsorHeadLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
    [self.supporterHeadLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
    self.mainScrollView.contentSize = CGSizeMake(320, 1050);
    
    
    
    [self.homLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.brochureLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.addCalLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.mapLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.callLbabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.shareLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];

}

-(void)favBtnTouched{
    
    
    NSMutableArray *favArray=[[NSMutableArray alloc] init];
    favArray  = [[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"favList.plist"];
    
    
    if ([favArray count]>=10) {
        UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:Nil message:@"Max: Favorite Count Reached" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myAlert show];
    }
    else{
        
        BOOL addbool=YES;
        
        for (NSString *eventId in favArray) {
            
            NSLog(@"event is is %@",eventId);
            
           // NSLog(@"prop id is %@ and to be added is %@",propertyId, prop.PropertyId);
            
            if ([eventDetail.event_id isEqualToString:eventId]) {
                
                addbool=NO;
                break;
                
            }
            
        }
        
        if (addbool) {
            
            NSLog(@"the event id value%@",eventDetail.event_id);
            
            
            [favArray addObject:eventDetail.event_id];
            
            
            [[ConferenceHelper SharedHelper] WriteArrayTothePlistFile:favArray toFile:@"favList.plist"];
            
            UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:Nil message:@"Property added to favourite" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [myAlert show];
            
        }
        
        else
        {
            UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:Nil message:@"Property already in favourite list" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [myAlert show];
            
        }
        
        
        
    }

    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [ApplicationDelegate hideTabBar:self.tabBarController];
    
    [self.eventNameLabel setText:eventDetail.name];
    [self.categoryLabel setText:eventDetail.industry_category];
    [self.locationLabel setText:eventDetail.location];
//    [self.categoryLabel setText:@"Education Technology & Resources"];
//    [self.locationLabel setText:@"Sharjah, UAE"];
    [self.dateLabel setText:[NSString stringWithFormat:@"%@ - %@",[[ConferenceHelper SharedHelper] datefromString:eventDetail.start_date],[[ConferenceHelper SharedHelper] datefromString:eventDetail.end_date]]];
    [self.timeLabel setText:[NSString stringWithFormat:@"%@ - %@",eventDetail.start_time,eventDetail.end_time]];
    [self.descriptionTxtView setText:eventDetail.description];
    NSString *iconUrl=eventDetail.logo ;
    
    self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        if([iconUrl isEqualToString:[url absoluteString]]) {
            [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                self.eventLogoImageView.image = fetchedImage;
            } completion:nil];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
    }];
    
    [self arrangeHorizontaScrollViews];
    
    
}

-(void)arrangeHorizontaScrollViews{
    
   NSMutableArray* sponsorArray = [[NSMutableArray alloc] init];
   NSMutableArray* supporterArray = [[NSMutableArray alloc] init];
   NSMutableArray* mediaArray = [[NSMutableArray alloc] init];
    
    
    for (NSMutableDictionary *dic in eventDetail.sponsors) {
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        [img setContentMode:UIViewContentModeScaleAspectFit];
        [img setBackgroundColor:[UIColor clearColor]];
        NSString *iconUrl=[dic objectForKey:@"location"];
        
        self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            if([iconUrl isEqualToString:[url absoluteString]]) {
                [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                    img.image = fetchedImage;
                } completion:nil];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        }];
		[sponsorArray addObject:img];
    }
    for (NSMutableDictionary *dic in eventDetail.supporters) {
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        [img setBackgroundColor:[UIColor clearColor]];
        [img setContentMode:UIViewContentModeScaleAspectFit];
        NSString *iconUrl=[dic objectForKey:@"location"];
        
        self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            if([iconUrl isEqualToString:[url absoluteString]]) {
                [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                    img.image = fetchedImage;
                } completion:nil];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        }];
		[supporterArray addObject:img];
    }
    for (NSMutableDictionary *dic in eventDetail.media_partners) {
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        [img setContentMode:UIViewContentModeScaleAspectFit];
        [img setBackgroundColor:[UIColor clearColor]];
        NSString *iconUrl=[dic objectForKey:@"location"];
        
        self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            if([iconUrl isEqualToString:[url absoluteString]]) {
                [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                    img.image = fetchedImage;
                } completion:nil];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        }];
		[mediaArray addObject:img];
    }
    
    self.sponsorsView = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(0.0f, 443.0f, 320, 60.0f) backgroundColor:[UIColor clearColor]  buttons:sponsorArray];
    [self.mainScrollView addSubview:self.sponsorsView];
    
    self.supportersView = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(0.0f, 530.0f, 320, 60.0f) backgroundColor:[UIColor clearColor]  buttons:supporterArray];
    [self.mainScrollView addSubview:self.supportersView];
    
    self.mediapartnersVieew = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(0.0f, 615.0f, 320, 60.0f) backgroundColor:[UIColor clearColor]  buttons:mediaArray];
    [self.mainScrollView addSubview:self.mediapartnersVieew];
    
}

-(void)backBtnAction{
    [self.navigationController fadePopViewController];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.videoGalleryView removeFromSuperview];
    [ApplicationDelegate showTabBar:self.tabBarController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageGalleryBtnAction:(id)sender {
    
    NSLog(@"image count is %d", eventDetail.imageGallery.count);
    
    [self setFGalleryType:ImageGallery];
    
    if (eventDetail.imageGallery.count >0) {
        networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
        [self.navigationController pushViewController:networkGallery animated:YES];
    }else{
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No image gallery available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }

    
}

- (IBAction)videoGalleryBtnAction:(id)sender {
    
     NSLog(@"videoGalleryArray count is %d", eventDetail.videoGalleryArray.count);
    
    if (eventDetail.videoGalleryArray.count>0) {
        
        
        ExpoCommonViewController *comView = [[ExpoCommonViewController alloc]initWithNibName:@"ExpoCommonViewController" bundle:nil];
        [comView setTitleHeaderString:@"Video-Gallery"];
        [comView setListArray:eventDetail.videoGalleryArray];
        [comView setFromEventDetailView:YES];
        [self.navigationController pushFadeViewController:comView];
        
        /*[self setBounceInt:10];
        [self.view addSubviewWithBounce:self.videoGalleryView];
        [self.bounceGoBtn setHidden:NO];
        [self.bounceViewHeaderLabel setText:@"Please select a Video"];
        [self.videoGalleryTableView reloadData];*/
    }else{
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Videos available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
}

- (IBAction)exhibitorBtnAction:(id)sender {
    
    if (eventDetail.exhibitorsArray.count>0) {
        [self setBounceInt:20];
        [self.bounceGoBtn setHidden:YES];
        [self.view addSubviewWithBounce:self.videoGalleryView];
        [self.bounceViewHeaderLabel setText:@"Exhibitors List"];
        [self.videoGalleryTableView reloadData];
    }else{
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Exhibitors list available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    

}

- (IBAction)registrationBtnAction:(id)sender {
    
    
     ExpoLocationViewController *loc = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
    [loc setViewType:WEBVIEW];
    [loc setWebViewType:EVENTREGISTRATION];
    [loc setTitleStr:@"media"];
    [loc setEventID:eventDetail.event_id];
    [self.navigationController pushFadeViewController:loc];
    
    
}

- (IBAction)HomeToolBarBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];

    
    
}

- (IBAction)galleryToolBarBtnAction:(id)sender {
    
    
     ExpoLocationViewController * amPdfVieww = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
    
    if ([eventDetail.brochure rangeOfString:@".pdf"].location == NSNotFound) {
        UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Brochures Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myAlert show];
    } else {
        //[self.extrasView setHidden:YES];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Pdf"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
            
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        NSString *pdfFilePath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",eventDetail.event_id]];
        NSLog(@"Dta path is %@", pdfFilePath);
        if (![[NSFileManager defaultManager] fileExistsAtPath:pdfFilePath]){
   
            [ApplicationDelegate.HUD show:YES];
            [self.navigationController.navigationBar setUserInteractionEnabled:NO];
            
            self.downloadOperation=   [ApplicationDelegate.appEngine downloadBrochure:eventDetail.brochure toFile:pdfFilePath];
            
            [self.downloadOperation onDownloadProgressChanged:^(double progress) {
                DLog(@"%.2f", progress*100.0);
            }];
            
           // __weak EventsDetailViewController *self_ = self;
            [self.downloadOperation addCompletionHandler:^(MKNetworkOperation* completedRequest) {
                DLog(@"%@", completedRequest);
                [ApplicationDelegate.HUD hide:YES];
                [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                [amPdfVieww setForPdfView:YES];
                [amPdfVieww setFilePathUrl:[NSURL fileURLWithPath:pdfFilePath]];
                [self.navigationController pushFadeViewController:amPdfVieww];
            }errorHandler:^(MKNetworkOperation *errorOp, NSError* error)
             {
                 [ApplicationDelegate.HUD hide:YES];
                 [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                 [UIAlertView showWithError:error];
             }];
        }
        else{
            
            ExpoLocationViewController * amPdfVieww = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
            [amPdfVieww setForPdfView:YES];
            [amPdfVieww setFilePathUrl:[NSURL fileURLWithPath:pdfFilePath]];
            [self.navigationController pushFadeViewController:amPdfVieww];
        }
        
    }
    
}

- (IBAction)adCalendarToolBarBtnAction:(id)sender {
    
    EKEventStore *eventSotre = [[EKEventStore alloc] init];
    EKEvent *event = [EKEvent eventWithEventStore:eventSotre];

    event.title= eventDetail.name;
    event.startDate =[[ConferenceHelper SharedHelper] dateForEventFromString:eventDetail.start_date];
    event.endDate=[[ConferenceHelper SharedHelper] dateForEventFromString:eventDetail.end_date];

    [event setCalendar:[eventSotre defaultCalendarForNewEvents]];
    NSError *err;
    BOOL isSuceess=[eventSotre saveEvent:event span:EKSpanThisEvent error:&err];
    if(isSuceess){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Event" message:@"Event added in calendar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertview show];
    }
    else{
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Event" message:[err description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertview show];
    }
}

- (IBAction)mapToolBarBtnAction:(id)sender {
    //@try {
       /* if (eventDetail.lattitude.length!=0 || eventDetail.longitude.length!=0) {
            MapViewControllerr *mpView = [[MapViewControllerr alloc]initWithNibName:@"MapViewControllerr" bundle:nil];
            mpView.lat = eventDetail.lattitude;
            mpView.lon = eventDetail.longitude;
            mpView.mtitle=[NSString stringWithFormat:@"%@, %@",eventDetail.name,eventDetail.location];
            
            [self.navigationController pushViewController:mpView animated:YES];
        }
        else{
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                               message:@"Location Unavailable"
                                              delegate:self cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil];
            [alert show];
            
        }*/
        
        
        [self setFGalleryType:LocationGallery];
    
    
    if (eventDetail.locationArray.count >0) {
        networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
        [self.navigationController pushViewController:networkGallery animated:YES];
    }else{
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No locations available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
        
     /*   if (eventDetail.locationArray.count==0) {
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                               message:@"Location Unavailable"
                                              delegate:self cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil];
            [alert show];
        }
        else{
            NSMutableDictionary *dic = [eventDetail.locationArray objectAtIndex:0];
            NSLog(@"loc is %@", [dic objectForKey:@"location"]);
            
            ExpoLocationViewController *loc = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
            [loc setViewType:IMGVIEW];
            [loc setTitleStr:[dic objectForKey:@"location"]];
            [self.navigationController pushFadeViewController:loc];
        
        }
        
        
    }
    @catch (NSException *exception) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                           message:@"Location Unavailable"
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
        [alert show];
    }
    @finally {
        
    }*/
  
}

- (IBAction)callToolBarBtnAction:(id)sender {
    

    [self.phoneArray removeAllObjects];
    
    for (NSMutableDictionary *dic in eventDetail.organizers) {
        [self.phoneArray addObject:[dic objectForKey:@"phone_no"]];
    }
    
    if (phoneArray.count == 0) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:@"No phone numbers available" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [al show];
    }
    
    else if (phoneArray.count == 1) {
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure to call this number ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:phoneArray[0], nil];
        al.tag = 10;
        [al show];
        
    }else if (phoneArray.count == 2){
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select a number to call" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:phoneArray[0],phoneArray[1], nil];
        al.tag = 11;
        [al show];
        
    }
    else{
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select a number to call" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:phoneArray[0],phoneArray[1],phoneArray[2], nil];
        al.tag = 12;
        [al show];
        
    }

    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    NSString *numberToCall;
    
    switch (alertView.tag) {
        case 10:
            
            if (buttonIndex==1) {
                NSLog(@"Phon number 0 to call is %@", phoneArray[0]);
                numberToCall = phoneArray[0];
            }
            break;
        case 11:
            if (buttonIndex==1) {
                NSLog(@"Phon number 0 to call is %@", phoneArray[0]);
                numberToCall = phoneArray[0];
            }else {
                 NSLog(@"Phon number 1 to call is %@", phoneArray[1]);
                numberToCall = phoneArray[1];
            }
            break;
        case 12:
            if (buttonIndex==1) {
                NSLog(@"Phon number 0 to call is %@", phoneArray[0]);
                numberToCall = phoneArray[0];
            }else if (buttonIndex==2) {
                NSLog(@"Phon number 1 to call is %@", phoneArray[1]);
                numberToCall = phoneArray[1];
            }else{
                NSLog(@"Phon number 2 to call is %@", phoneArray[2]);
                numberToCall = phoneArray[2];
            }
            break;
        default:
            break;
    }
    NSLog(@"NUmber to call is %@",[NSString stringWithFormat:@"telprompt://%@",numberToCall]);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",numberToCall]]];
    
    
}

- (IBAction)shareToolBarBtnAction:(id)sender {
    
    
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

    
    /*UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:@"Facebook",
                                        @"Twitter",@"Instagram",@"Linkedin",
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
            
            @try {
                if (eventDetail.facebook_link.length!=0) {
                    
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eventDetail.facebook_link]];
                }
                else {
                    UIAlertView *alert;
                    alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                       message:@"Facebook Account Unavailable"
                                                      delegate:self cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
                    [alert show];
                }
                
            }
            @catch (NSException *exception) {
                
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                   message:@"Facebook Account Unavailable"
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
                
                
            }
            @finally {
                
            }
            break;
		}
		case 1:
		{
            
            @try {
                if (eventDetail.twitter_link.length!=0) {
                    
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eventDetail.twitter_link]];
                }
                else {
                    UIAlertView *alert;
                    alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                       message:@"Twitter Account Unavailable"
                                                      delegate:self cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
                    [alert show];
                }
                
            }
            @catch (NSException *exception) {
                
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                   message:@"Twitter Account Unavailable"
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
                
                
            }
            @finally {
                
            }
            break;
		}
	//}
case 2:
    {
        
        @try {
            if (eventDetail.instagram_link.length!=0) {
                
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eventDetail.instagram_link]];
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                   message:@"Instagram Account Unavailable"
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
            }
            
        }
        @catch (NSException *exception) {
            
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                               message:@"Instagram Account Unavailable"
                                              delegate:self cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil];
            [alert show];
            
            
        }
        @finally {
            
        }
        break;
    }
case 3:
    {
        
        @try {
            if (eventDetail.linked_in_link.length!=0) {
                
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eventDetail.linked_in_link]];
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                   message:@"Linkedin Account Unavailable"
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
            }
            
        }
        @catch (NSException *exception) {
            
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                               message:@"Linkedin Account Unavailable"
                                              delegate:self cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil];
            [alert show];
            
            
        }
        @finally {
            
        }
        break;
    }
}
}
*/

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    
    switch (self.fGalleryType) {
        case ImageGallery:
             return [eventDetail.imageGallery count];
            break;
        case LocationGallery:
            return [eventDetail.locationArray count];
            break;
        default:
            break;
    }
    
    return 1;
    
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
    return FGalleryPhotoSourceTypeNetwork;
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    
    NSMutableDictionary *dic;;
    switch (self.fGalleryType) {
        case ImageGallery:
           
            dic = [eventDetail.imageGallery objectAtIndex:index] ;
            return [dic valueForKey:@"location"];
            break;
        case LocationGallery:
            dic = [eventDetail.locationArray objectAtIndex:index] ;
            return [dic valueForKey:@"location"];
            break;
        default:
            break;
    }
    
    return @"";
   // return 1;
   
}

/*- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    caption = [[imagesList objectAtIndex:index]valueForKey:@"title"];
	return caption;
}*/


- (IBAction)closeVideosBtnAction:(id)sender {
    
    [self.view removeSubview:self.videoGalleryView];
}

-(BOOL) validateYouTubeUrl: (NSString *) youTubeUrl
{
    
    // NSString *urlRegEx = @"http:\/\/(?:www\.)?youtube.com\/watch\?(?=.*v=\w+)(?:+)?$";
    
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    NSLog(@"O/P is %i",[urlTest evaluateWithObject:youTubeUrl]);
    return [urlTest evaluateWithObject:youTubeUrl];
}

- (IBAction)playVideoBtnAction:(id)sender {
    
    
    NSLog(@" selecte video >>> %@",selectedVideo);
    
    
    NSString *videoID;
    
    
    // youtube.youtubeUrl = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=OUz-5YjXFeg"];
    
    
    if (selectedVideo.length==0) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if (![self validateYouTubeUrl:selectedVideo])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else{
        
        NSArray *videoURLSplit = [selectedVideo componentsSeparatedByString:@"watch?v="];
        
        NSLog(@"Count is %d",videoURLSplit.count);
        if (videoURLSplit.count!=0) {
            
            @try {
                videoID = [[videoURLSplit objectAtIndex:1] substringToIndex:11];
                NSLog(@" videoID >>> %@",videoID);
                [ApplicationDelegate.HUD show:YES];
                [self.navigationController.navigationBar setUserInteractionEnabled:NO];
                [ApplicationDelegate.appEngine checkYoutubeLink:videoID onCompletion:^(NSMutableArray *youtube) {
                    NSLog(@"yioutube array is %@", [youtube description]);
                    [ApplicationDelegate.HUD hide:YES];
                    [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                    LBViewController* youtube1=[[LBViewController alloc]initWithNibName:@"LBViewController" bundle:nil];
                    [youtube1 setYoutubeUrl:selectedVideo];
                    [self presentModalViewController:youtube1 animated:YES];
                    
                } onError:^(NSError *error) {
                    [ApplicationDelegate.HUD hide:YES];
                    [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                    [UIAlertView showWithError:error];
                }];
                
            }
            @catch (NSException *exception) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            @finally {
                
            }
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        
        
    }
    
}

#pragma mark - TableView Delegate Methods


-  (NSInteger)tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    switch (self.bounceInt) {
        case 10:
            return [eventDetail.videoGalleryArray count];
            break;
        case 20:
            return [eventDetail.exhibitorsArray count];
            break;
            
        //default:
            //break;
    }
return 1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bounceInt==20) {
        return 53;
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)
tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic;
    
    if(self.bounceInt==20)
    {
        static NSString *CellIdentifier2 = @"ExhibitCell";
        ExhibitCell *cell2 = (ExhibitCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell2 == nil) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:CellIdentifier2 owner:self options:nil];
            for(id currentObject in nibs)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell2 = (ExhibitCell *)currentObject;
                    
                    break;
                }
            }
        }
        dic = [eventDetail.exhibitorsArray objectAtIndex:indexPath.row];
        [cell2 setListToCell:dic];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return  cell2;
    }else{
        static NSString *MyIdentifer = @"MyIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifer];
        
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                          reuseIdentifier:MyIdentifer];
        }
        
        dic = [eventDetail.videoGalleryArray objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:[dic objectForKey:@"title"]];
        if ([checkedCell isEqual:indexPath])
            
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            
        } else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return  cell;
        
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.bounceInt == 10) {
      
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    checkedCell = indexPath;
    [tableView reloadData];
    NSMutableDictionary *dic = [eventDetail.videoGalleryArray objectAtIndex:indexPath.row];
    NSLog(@"cell text is%@ and url  is %@",cellText,[dic objectForKey:@"youtube_link"]);
        [self setSelectedVideo:[dic objectForKey:@"youtube_link"]];
    }
}

- (void)viewDidUnload {
    [self setHomeBtn:nil];
    [self setBrochureBtn:nil];
    [self setAddBtn:nil];
    [self setLocationBtn:nil];
    [self setShareBtn:nil];
    [self setCallBtn:nil];
    [self setHomLabel:nil];
    [self setBrochureLabel:nil];
    [self setAddCalLabel:nil];
    [self setMapLabel:nil];
    [self setShareLabel:nil];
    [self setCallLbabel:nil];
    [super viewDidUnload];
}
@end
