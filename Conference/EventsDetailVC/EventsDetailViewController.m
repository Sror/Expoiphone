//
//  EventsDetailViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 09/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "ExpoLocationViewController.h"

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController

@synthesize eventDetail;
@synthesize fromFavList;

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
    
    if (fromFavList) {
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:fixed1,btnAbt, nil]];
    }
    

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
    [self.dateLabel setText:eventDetail.date];
    [self.timeLabel setText:eventDetail.event_timing];
    
    NSString *iconUrl=eventDetail.logo ;
    
    self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        if([iconUrl isEqualToString:[url absoluteString]]) {
            [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                self.eventLogoImageView.image = fetchedImage;
            } completion:nil];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
    }];
    
}


-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [ApplicationDelegate showTabBar:self.tabBarController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageGalleryBtnAction:(id)sender {
    
}

- (IBAction)videoGalleryBtnAction:(id)sender {
    
}

- (IBAction)exhibitorBtnAction:(id)sender {

}

- (IBAction)registrationBtnAction:(id)sender {
    
}

- (IBAction)HomeToolBarBtnAction:(id)sender {
    
}

- (IBAction)galleryToolBarBtnAction:(id)sender {
    
}

- (IBAction)adCalendarToolBarBtnAction:(id)sender {
    
}

- (IBAction)mapToolBarBtnAction:(id)sender {
    @try {
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
        
        if (eventDetail.locationArray.count==0) {
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
           // self.navigationController
            //[self.navigationController]
          // [self.nav]
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
        
    }
  
}

- (IBAction)shareToolBarBtnAction:(id)sender {
    
    UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:@"Facebook",
                                        @"Twitter",@"Instagram",@"Linkedin",
                                        nil,
                                        nil];
    
    [photoSourcePicker showInView:self.view];
    
    
    
}

- (IBAction)callToolBarBtnAction:(id)sender {
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://+97142689090"]]];
    
    
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



@end
