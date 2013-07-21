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
#import "ConferenceHelper.h"
#import "ExpoCommonViewController.h"
#import <EventKit/EventKit.h>

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController

@synthesize eventDetail;
@synthesize fromFavList,networkGallery,selectedVideo,phoneArray;
@synthesize supporterArray,sponsorArray,mediaArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        phoneArray = [[NSMutableArray alloc]init];
        
        sponsorArray = [[NSMutableArray alloc] init];
        supporterArray = [[NSMutableArray alloc] init];
        mediaArray = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.arabExhibitBtn setHidden:YES];
    [self.arabImgBtn setHidden:YES];
    [self.arabRegBtn setHidden:YES];
    [self.arabVideoBtn setHidden:YES];
    
      /* UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:backBtn]];*/
    /*UIButton *favBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [favBtn addTarget:self action:@selector(favBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [favBtn setImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnAbt = [[UIBarButtonItem alloc] initWithCustomView:favBtn];
    
    UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed1.width = 40.0f;
    
    if (!fromFavList) {
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:fixed1,btnAbt, nil]];
    }*/
    self.navigationItem.hidesBackButton = YES;
    [self.view addSubview:ApplicationDelegate.HUD];
    
    
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
    
    [self.imagGalleryBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.videoGalleryBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.regBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.exhitBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    
    [self.arabImgBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.arabVideoBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.arabRegBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.arabExhibitBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];

}



-(void)sethidden:(BOOL)key{
    
    [self.arabExhibitBtn setHidden:key];
    [self.arabImgBtn setHidden:key];
    [self.arabVideoBtn setHidden:key];
    [self.arabRegBtn setHidden:key];
    
    [self.exhitBtn setHidden:!key];
    [self.imagGalleryBtn setHidden:!key];
    [self.videoGalleryBtn setHidden:!key];
    [self.regBtn setHidden:!key];
}

-(void)updateUI{
    
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:
            [self sethidden:YES];
            [self.imagGalleryBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"imgGallery"] forState:UIControlStateNormal];
            [self.videoGalleryBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"videoGallery"] forState:UIControlStateNormal];
            [self.exhitBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"exList"] forState:UIControlStateNormal];
            [self.regBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"regForm"] forState:UIControlStateNormal];
            
            [self.borderImgView setFrame:CGRectMake(15, 16, 96, 70)];
            [self.eventLogoImageView setFrame:CGRectMake(17, 17, 92, 67)];
            [self.eventNameLabel setFrame:CGRectMake(117, 13, 190, 21)];
            [self.dateLabel setFrame:CGRectMake(117, 32, 190, 16)];
            [self.timeLabel setFrame:CGRectMake(117, 44, 190, 16)];
            [self.categoryLabel setFrame:CGRectMake(117, 57, 190, 16)];
            [self.locationLabel setFrame:CGRectMake(117, 68, 190, 21)];
            
            
            [self.eventNameLabel setTextAlignment:NSTextAlignmentLeft];
            [self.dateLabel setTextAlignment:NSTextAlignmentLeft];
            [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
            [self.categoryLabel setTextAlignment:NSTextAlignmentLeft];
            [self.locationLabel setTextAlignment:NSTextAlignmentLeft];
            [self.mediaPartnerHeadLabel setTextAlignment:NSTextAlignmentLeft];
            [self.supporterHeadLabel setTextAlignment:NSTextAlignmentLeft];
            [self.sponsorHeadLabel setTextAlignment:NSTextAlignmentLeft];
            
            break;
        case LANG_ARABIC:
            [self sethidden:NO];
            
            [self.arabImgBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"imgGallery"] forState:UIControlStateNormal];
            [self.arabVideoBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"videoGallery"] forState:UIControlStateNormal];
            [self.arabExhibitBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"exList"] forState:UIControlStateNormal];
            [self.arabRegBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"regForm"] forState:UIControlStateNormal];
            
            [self.borderImgView setFrame:CGRectMake(205, 16, 96, 70)];
            [self.eventLogoImageView setFrame:CGRectMake(207, 17, 92, 67)];
            [self.eventNameLabel setFrame:CGRectMake(10, 13, 190, 21)];
            [self.dateLabel setFrame:CGRectMake(10, 32, 190, 16)];
            [self.timeLabel setFrame:CGRectMake(10, 44, 190, 16)];
            [self.categoryLabel setFrame:CGRectMake(10, 57, 190, 16)];
            [self.locationLabel setFrame:CGRectMake(10, 68, 190, 21)];
            
            [self.eventNameLabel setTextAlignment:NSTextAlignmentRight];
            [self.dateLabel setTextAlignment:NSTextAlignmentRight];
            [self.timeLabel setTextAlignment:NSTextAlignmentRight];
            [self.categoryLabel setTextAlignment:NSTextAlignmentRight];
            [self.locationLabel setTextAlignment:NSTextAlignmentRight];
            [self.mediaPartnerHeadLabel setTextAlignment:NSTextAlignmentRight];
            [self.supporterHeadLabel setTextAlignment:NSTextAlignmentRight];
            [self.sponsorHeadLabel setTextAlignment:NSTextAlignmentRight];
            
       
            break;
            
            
          
            
        default:
            break;
    }
    
    
    [self.navigationItem setTitleView:[self titleForDetailView]];
  //  [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"event_details"]]];
    
    
    [self.eventDescLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"event_Description"]];
    
    [self.homLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    [self.brochureLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"brochure"]];
    [self.addCalLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"addtoCal"]];
    [self.mapLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"floormap"]];
    [self.callLbabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"call"]];
    [self.shareLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"share"]];
    
    
    
  [self.mediaPartnerHeadLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"mPartners"]];
  [self.supporterHeadLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"supporters"]];
  [self.sponsorHeadLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sponsors"]];
    
}


-(UIView*)titleForDetailView{
    
    
    for (UIView *vi in self.navigationController.navigationBar.subviews) {
        if (vi.tag == 12345) {
            [vi removeFromSuperview];
        }
    }
    UIView *titleHeaderView = [[UIView alloc]init]; //WithFrame:CGRectMake(0, 20, 320, 44)];
    titleHeaderView.contentMode = UIViewContentModeScaleToFill;
    [titleHeaderView setBackgroundColor:[UIColor clearColor]];
    titleHeaderView.tag =12345;
    
    UILabel *titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] init];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Eagle-Bold" size:17.0];
    }
    
    [titleView setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"event_details"]];
    titleView.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    //[titleView sizeToFit];
    [titleHeaderView addSubview:titleView];
    
    
    UIImageView *ribImgView;
    ribImgView = [[UIImageView alloc] init];
    ribImgView.backgroundColor = [UIColor clearColor];
    [ribImgView setImage:[UIImage imageNamed:@"ribbon.png"]];
    [ribImgView setContentMode:UIViewContentModeScaleAspectFit];
    [titleHeaderView addSubview:ribImgView];

    UIButton *favBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;//]WithFrame:CGRectMake(0, 25,35, 35)];
    [favBtn addTarget:self action:@selector(favBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [favBtn setImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
    [favBtn setBackgroundColor:[UIColor clearColor]];
    [titleHeaderView addSubview:favBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;//]WithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [titleHeaderView addSubview:backBtn];
    
    
    UIButton *dragBtn;
    dragBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dragBtn.backgroundColor = [UIColor clearColor];
    UIPanGestureRecognizer *panBtn= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBtnAction:)];
    [dragBtn addGestureRecognizer:panBtn];
    [titleHeaderView addSubview:dragBtn];
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:{
            [titleHeaderView setFrame:CGRectMake(0, 20, 295, 44)];
            [titleView setFrame:CGRectMake(50, 0, 170, 44)];
            [ribImgView setFrame:CGRectMake(265,0,27,44)];
            [dragBtn setFrame:CGRectMake(265, 0, 40, 44)];
            [favBtn setFrame:CGRectMake(225, 5, 35, 35)];
            [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
            
             /*[imgView setFrame:CGRectMake(5, 10, 25, 25)];
             [sepImgView setFrame:CGRectMake(33,7,2,29)];
             
             
             [titleView setTextAlignment:NSTextAlignmentLeft];*/
        }
            break;
        case LANG_ARABIC:{
            
            [titleHeaderView setFrame:CGRectMake(0, 20, 295, 44)];
            [titleView setFrame:CGRectMake(90, 0, 170, 44)];
            [dragBtn setFrame:CGRectMake(7, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(7,0,27,44)];
            [favBtn setFrame:CGRectMake(35, 5, 35, 35)];
            [backBtn setFrame:CGRectMake(250, 0, 44, 44)];
            /*[imgView setFrame:CGRectMake(280, 10, 25, 25)];
             [sepImgView setFrame:CGRectMake(275,7,2,29)];
             [dragBtn setFrame:CGRectMake(10, 0, 40, 44)];
             [ribImgView setFrame:CGRectMake(10,0,27,44)];
             [titleView setTextAlignment:NSTextAlignmentRight];*/
        }
            break;
            
        default:
            break;
    }

    return titleHeaderView;
}

- (void)dragBtnAction:(UIPanGestureRecognizer *)rec
{
    [ApplicationDelegate dragBtnAction:rec];

}


-(void)favBtnTouched{
    
    
    NSMutableArray *favArray=[[NSMutableArray alloc] init];
    favArray  = [[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"favList.plist"];
    
    //@"maxCountReached"
    if ([favArray count]>=10) {
        UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:Nil message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"maxCountReached"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
        [myAlert show];
    }
    else{
        
        BOOL addbool=YES;
        
        for (NSString *eventId in favArray) {
            
            NSLog(@"event is is %@",eventId);
            
            if ([eventDetail.event_id isEqualToString:eventId]) {
                addbool=NO;
                break;
            }
        }
        if (addbool) {
            
            NSLog(@"the event id value%@",eventDetail.event_id);
            [favArray addObject:eventDetail.event_id];
            [[ConferenceHelper SharedHelper] WriteArrayTothePlistFile:favArray toFile:@"favList.plist"];
            UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:Nil message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"addedToFav"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
            [myAlert show];
        }
        
        else
        {
            UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:Nil message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"alreadyExists"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
            [myAlert show];
            
        }
        
        
        
    }

    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];

    
    [ApplicationDelegate hideTabBar:self.tabBarController];
    
    [self.eventNameLabel setText:eventDetail.name];
    [self.categoryLabel setText:eventDetail.industry_category];
    [self.locationLabel setText:eventDetail.location];
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
    [self updateUI];
    
    
}

-(void)arrangeHorizontaScrollViews{
    
      
    
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
    
    
    self.sponsorsView = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(15.0f, 413.0f, 290, 60.0f) backgroundColor:[UIColor clearColor]  buttons:sponsorArray];
    [self.mainScrollView addSubview:self.sponsorsView];
    
    self.supportersView = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(15.0f, 500.0f, 290, 60.0f) backgroundColor:[UIColor clearColor]  buttons:supporterArray];
    [self.mainScrollView addSubview:self.supportersView];
    
    self.mediapartnersVieew = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(15.0f, 585.0f, 290, 60.0f) backgroundColor:[UIColor clearColor]  buttons:mediaArray];
    [self.mainScrollView addSubview:self.mediapartnersVieew];
    
}

-(void)refreshView:(NSNotification *) notification{
    
    ApplicationDelegate.HUD.labelText = [[ConferenceHelper SharedHelper] getLanguageForAKey:@"loading"];
    [ApplicationDelegate.HUD show:YES];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    [ApplicationDelegate.appEngine getEventDetails:eventDetail.event_id onCompletion:^(NSMutableDictionary *detailsDic) {
        
        NSLog(@"detail dic is %@",detailsDic);
        
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];

        Events *ev = [[ConferenceHelper SharedHelper] getEventsObjectFromDictionary:detailsDic];
        [self setEventDetail:ev];
        
        [self.eventNameLabel setText:eventDetail.name];
        [self.categoryLabel setText:eventDetail.industry_category];
        [self.locationLabel setText:eventDetail.location];
        [self.dateLabel setText:[NSString stringWithFormat:@"%@ - %@",[[ConferenceHelper SharedHelper] datefromString:eventDetail.start_date],[[ConferenceHelper SharedHelper] datefromString:eventDetail.end_date]]];
        [self.timeLabel setText:[NSString stringWithFormat:@"%@ - %@",eventDetail.start_time,eventDetail.end_time]];
        [self.descriptionTxtView setText:eventDetail.description];
        
    } onError:^(NSError *error) {
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        
        
    }];
    
    [self updateUI];
}

-(void)backBtnAction{
    [self.navigationController fadePopViewController];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
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
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noImages"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
        [al show];
    }

    
}

- (IBAction)videoGalleryBtnAction:(id)sender {
    
     NSLog(@"videoGalleryArray count is %d", eventDetail.videoGalleryArray.count);
    
    if (eventDetail.videoGalleryArray.count>0) {
        
        
        ExpoCommonViewController *comView = [[ExpoCommonViewController alloc]initWithNibName:@"ExpoCommonViewController" bundle:nil];
        [comView setTitleHeaderString:@"videoGallery"];
        [comView setListArray:eventDetail.videoGalleryArray];
        [comView setFromEventDetailView:YES];
        [self.navigationController pushFadeViewController:comView];
        
        /*[self setBounceInt:10];
        [self.view addSubviewWithBounce:self.videoGalleryView];
        [self.bounceGoBtn setHidden:NO];
        [self.bounceViewHeaderLabel setText:@"Please select a Video"];
        [self.videoGalleryTableView reloadData];*/
    }else{
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noVideos"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
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
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noexhibitlist"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
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
    
    ApplicationDelegate.HUD.labelText = @"Downloading";
    
     ExpoLocationViewController * amPdfVieww = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
    
    if ([eventDetail.brochure rangeOfString:@".pdf"].location == NSNotFound) {
        UIAlertView *myAlert =[[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"nobrochures"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
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
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"Events"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"addedToCalendar"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil];
        [alertview show];
    }
    else{
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"Events"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"addingCalendarFailed"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil];
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
        UIAlertView *al =[[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noMapAvailable"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
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
        if (![[ConferenceHelper SharedHelper]isEmptyString:[dic objectForKey:@"phone_no"]])
        [self.phoneArray addObject:[dic objectForKey:@"phone_no"]];
    }
    
    NSLog(@"phone array count is %d, and phone arrat desc is %@",phoneArray.count, [phoneArray description]);
    
    if (phoneArray.count == 0) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noContactsAvailable"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
        [al show];
    }
    
    else if (phoneArray.count == 1) {
    
       /*if ([[ConferenceHelper SharedHelper]isEmptyString:phoneArray[0]]) {
            [phoneArray removeObjectAtIndex:0];
        }*/
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sureToCall"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:phoneArray[0], nil];
        al.tag = 10;
        [al show];
        
    }else if (phoneArray.count == 2){
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectNumber"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:phoneArray[0],phoneArray[1], nil];
        al.tag = 11;
        [al show];
        
    }
    else{
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"" message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectNumber"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:phoneArray[0],phoneArray[1],phoneArray[2], nil];
        al.tag = 12;
        [al show];
        
    }

    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag == 10 || alertView.tag == 11 ||alertView.tag ==12) {
       
    NSString *numberToCall;
        BOOL theCallEnable=NO;
    switch (alertView.tag) {
        case 10:
            
            if (buttonIndex==1) {
                NSLog(@"Phon number 0 to call is %@", phoneArray[0]);
                numberToCall = phoneArray[0];
                  theCallEnable=YES;
            }
            break;
        case 11:
            if (buttonIndex==1) {
                NSLog(@"Phon number 0 to call is %@", phoneArray[0]);
                numberToCall = phoneArray[0];
                  theCallEnable=YES;
            }else if (buttonIndex==2) {
                 NSLog(@"Phon number 1 to call is %@", phoneArray[1]);
                numberToCall = phoneArray[1];
                  theCallEnable=YES;
            }
            break;
        case 12:
            if (buttonIndex==1) {
                NSLog(@"Phon number 0 to call is %@", phoneArray[0]);
                numberToCall = phoneArray[0];
                  theCallEnable=YES;
            }else if (buttonIndex==2) {
                NSLog(@"Phon number 1 to call is %@", phoneArray[1]);
                numberToCall = phoneArray[1];
                  theCallEnable=YES;
            }else if (buttonIndex==3){
                NSLog(@"Phon number 2 to call is %@", phoneArray[2]);
                numberToCall = phoneArray[2];
                theCallEnable=YES;
            }
            
            
            break;
        default:
            break;
    }
   
        if (theCallEnable) {
            NSLog(@"NUmber to call is %@",[NSString stringWithFormat:@"telprompt://%@",numberToCall]);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",numberToCall]]];
        }
    
    }
    
}

- (IBAction)shareToolBarBtnAction:(id)sender {
    
    
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
                UIAlertView *twitAlert = [[UIAlertView alloc]initWithTitle:@"SharjahExpoCentre" message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"addTwitAcc"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
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
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"videoUnavailable"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if (![self validateYouTubeUrl:selectedVideo])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"videoUnavailable"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
        
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
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"videoUnavailable"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
                
                [alert show];
            }
            @finally {
                
            }
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"videoUnavailable"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
            
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
    [self setImagGalleryBtn:nil];
    [self setVideoGalleryBtn:nil];
    [self setExhitBtn:nil];
    [self setRegBtn:nil];
    [self setArabImgBtn:nil];
    [self setArabVideoBtn:nil];
    [self setArabExhibitBtn:nil];
    [self setArabRegBtn:nil];
    [self setBorderImgView:nil];
    [self setEventDescLabel:nil];
    [super viewDidUnload];
}
@end
