//
//  ConferenceAppDelegate.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 04/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConferenceAppDelegate.h"

#import "ConferenceViewController.h"



@implementation ConferenceAppDelegate

@synthesize appEngine,navController,appHelper,HUD;
@synthesize appdelegateSession,appEventArray,appImageGalleryArray,appFavEventArray,appCurrentEventArray,appSearchEventsArray,appLanguageArray;
@synthesize userNameString,dragView,_dragged,langBool,langCode,imgDragView,confDownloadEngine;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self Initializer];
   // [self TESTData];
    [self checkFacebookAvailability];
    // Override point for customization after application launch.
    self.viewController = [[ConferenceViewController alloc] initWithNibName:@"ConferenceViewController" bundle:nil];
    self.navController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"titlebar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    
    //[labelLang setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"changeLanguage"]];

    
    //[self returnNextDay:[NSDate date]];
    
    NSString *portraitVideoName = @"expoSplash";
    NSString *portraitImageName = @"expoSplash.png";
    
    
    NSURL *portraitUrl = [[NSBundle mainBundle] URLForResource:portraitVideoName withExtension:@"mp4"];
    
    NSLog(@"the path %@",portraitUrl);
    
    XOSplashVideoController *splashVideoController =
    [[XOSplashVideoController alloc] initWithVideoPortraitUrl:portraitUrl
                                            portraitImageName:portraitImageName
                                                 landscapeUrl:nil
                                           landscapeImageName:nil
                                                     delegate:self];
    
    
     self.window.rootViewController = splashVideoController;
    
//    self.window.rootViewController = self.navController;

    self.confDownloadEngine=[[ConferenceAppEngine alloc] initWithHostName:nil];
    
    
    
    
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    return YES;
}

-(void)splashVideoLoaded:(XOSplashVideoController *)splashVideo
{
    
    
    
    NSLog(@"called");
    
    
}
-(void)splashVideoComplete:(XOSplashVideoController *)splashVideo
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent
                                                animated:YES];
    self.HUD = [[MBProgressHUD alloc]initWithView:self.navController.view];
    HUD.delegate = self;
    self.window.rootViewController = self.navController;
    

    //  [self.tabBarController presentModalViewController:splash animated:YES];
    //
    //    [self.tabBarController performSelector:@selector(dismissModalViewControllerAnimated:) withObject:nil  afterDelay:1.0];
    
}



-(void)Initializer{
    
    self.appEngine = [[ConferenceAppEngine alloc] initWithHostName:@"conferenceapp.crisiltech.com"];
 // [ConferenceHelper SharedHelper] getEventsObjectFromDictionary:]
    [self.appEngine useCache];
    
    
    
    self.appEventArray = [[NSMutableArray alloc]init];
    self.appFavEventArray = [[NSMutableArray alloc]init];
    self.appImageGalleryArray = [[NSMutableArray alloc]init];
    self.appCurrentEventArray = [[NSMutableArray alloc]init];
    self.appLatestNewsArray = [[NSMutableArray alloc]init];
    self.appSearchEventsArray = [[NSMutableArray alloc]init];
    self.appLanguageArray = [[NSMutableArray alloc]init];
    
    
    self.appLanguageArray=[[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"lang.plist"];
    
    
    
   /* for (NSDictionary *dic in ApplicationDelegate.appLanguageArray) {
     
        if ([dic objectForKey:@"changeLanguage"]) {
            NSLog(@"lan dic is %@", dic);
        }
    }*/
    
    
    self.dragView = [[UIView alloc]initWithFrame:CGRectMake(2.73, 0, 311, 62)];
    [self.dragView setBackgroundColor:[UIColor clearColor]];
    [self.dragView setAlpha:0.0];
    [self.dragView setTag:DRAGVIEWTAG];
    self.imgDragView = [[UIImageView alloc]initWithFrame:CGRectMake(2.73, 0, 311, 62)];
    [self.imgDragView setBackgroundColor:[UIColor clearColor]];
    if (self.langBool == LANG_ARABIC) {
        [self.imgDragView setImage:[UIImage imageNamed:@"pulldown_arabicbg.png"]];
    }else{
        [self.imgDragView setImage:[UIImage imageNamed:@"pulldown.png"]];
    }
    
    [self.dragView addSubview:self.imgDragView];
    
    labelLang= [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 120, 22)];
    
    labelLang .font = [UIFont fontWithName:@"Eagle-Light" size:12.0];
    [labelLang setBackgroundColor:[UIColor clearColor]];
    [self.dragView addSubview:labelLang];
    
    UIButton *engBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [engBtn setFrame:CGRectMake(130,25,63,22)];
    [engBtn setBackgroundColor:[UIColor clearColor]];
    [engBtn setImage:[UIImage imageNamed:@"english.png"] forState:UIControlStateNormal];
    [engBtn addTarget:self action:@selector(engBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.dragView addSubview:engBtn];
    
    UIButton *arabBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [arabBtn setFrame:CGRectMake(230,25,63,22)];
    [arabBtn setBackgroundColor:[UIColor clearColor]];
    [arabBtn setImage:[UIImage imageNamed:@"arabic.png"] forState:UIControlStateNormal];
    [arabBtn addTarget:self action:@selector(arabBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.dragView addSubview:arabBtn];
    
    
   /* for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"UIFont family  %@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"UIFont >>>  %@", name);
        }
    }*/
    
        self.postParams =
        [[NSMutableDictionary alloc] initWithObjectsAndKeys:
         @"http://www.expo-centre.ae/en/", @"link",
         @"http://www.expo-centre.ae/en/images/logo.jpg", @"picture",
        @"iOS App is now available", @"name",
         @"Expo Centre Sharjah", @"caption",
         @"Expo Centre Sharjah is the centerpiece of a planned Expo City in the emirate of Sharjah, Strategically located and spread across 128,000 square metres; The centre provides state-of-the-art facilities and professional services to the exhibitions industry,It is the first established trade fair centre in the country and is considered a pioneer in its field.", @"description",
         nil];
    
}


-(void)arabBtnAction{
    
    
   // self.navController.view
    if ( self.langBool!=LANG_ARABIC) {
        
    self.langBool=LANG_ARABIC;
    [self setLangCode:ARAB_Code];
        [self emptyAllArrays];
    NSLog(@"Arab clicked");
    [self removeDraggerFromCurrentView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil];
    }else{
        [self removeDraggerFromCurrentView];
    }
    //[self.navController.viewDidLoad];
    
    
}

-(void)engBtnAction{
    
    if ( self.langBool!=LANG_English) {
    NSLog(@"English clicked");
    self.langBool=LANG_English;
         [self emptyAllArrays];
    [self setLangCode:ENG_Code];
    [self removeDraggerFromCurrentView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil];
    }else{
        [self removeDraggerFromCurrentView];
    }
}
-(void)TESTData
{

    
    [self.appEngine eventsList:@"" onCompletion:^(NSMutableArray *eventArray) {
        
        NSMutableArray *eventList=[[NSMutableArray alloc] init];
        
        
        for (NSMutableDictionary *dic in eventArray) {
            
            [eventList addObject:[[ConferenceHelper SharedHelper] getEventsObjectFromDictionary:dic]];
            NSLog(@"Dic is %@", dic);
            
        }

    } onError:^(NSError *error) {
        [UIAlertView showWithError:error];

    }];
    
}

-(UIView *)draggedView{
    
    self.dragView = [[UIView alloc]initWithFrame:CGRectMake(243, 0, 73, 58)];
    [self.dragView setBackgroundColor:[UIColor brownColor]];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(243, 0, 73, 58)];
    [imgView setImage:[UIImage imageNamed:@"pulldown.png"]];
    return  self.dragView;
    
}

-(void)removeDraggerFromCurrentView{
    
    for (UIView *vie in self.navController.view.subviews) {
        if (vie.tag==DRAGVIEWTAG) {
            [UIView animateWithDuration:0.7 animations:^{
                [vie setFrame:CGRectMake(2.73, 0, 311, 62)];
                [vie setAlpha:0.0];
            } completion:^(BOOL finished) {
                [vie removeFromSuperview];
                /*if (ApplicationDelegate.langBool == LANG_ARABIC) {
                    [self.imgDragView setImage:[UIImage imageNamed:@"pulldown-arab.png"]];
                }else{
                    [self.imgDragView setImage:[UIImage imageNamed:@"pulldown-eng.png"]];
                }*/
        
                if (self.langBool == LANG_ARABIC) {
                    [self.imgDragView setImage:[UIImage imageNamed:@"pulldown_arabicbg.png"]];
                }else{
                    [self.imgDragView setImage:[UIImage imageNamed:@"pulldown.png"]];
                }
                
                [ApplicationDelegate set_dragged:NO];
            }];
        }
    }
}


- (void)dragBtnAction:(UIPanGestureRecognizer *)rec
{
    [labelLang setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"changeLanguage"]];
    
    CGPoint vel = [rec velocityInView:self.navController.view];
    if (vel.y > 0)
    {
        if (!_dragged) {
            _dragged=YES;
            [self.navController.view addSubview:self.dragView];
            [UIView animateWithDuration:0.7 animations:^{
                [self.dragView setAlpha:1.0];
                [self.dragView setFrame:CGRectMake(2.73, 54, 311, 62)];
            } completion:^(BOOL finished) {
            }];
        }
    }
    else
    {
        if (_dragged) {
            _dragged=NO;
            [UIView animateWithDuration:0.7 animations:^{
                [self.dragView setFrame:CGRectMake(2.73, 0, 311, 62)];
                [self.dragView setAlpha:0.0];
            } completion:^(BOOL finished) {
                [self.dragView removeFromSuperview];
                [ApplicationDelegate set_dragged:NO];
            }];
        }
    }
}


#pragma mark - Navigation Bar Methods

-(UIButton *)customBackBtn{
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    return backBtn;

    
}


-(UIView *)setTitleForDetailView{
    
    UIView *titleHeaderView = [[UIView alloc]init]; //WithFrame:CGRectMake(0, 20, 320, 44)];
    titleHeaderView.contentMode = UIViewContentModeScaleToFill;
    [titleHeaderView setBackgroundColor:[UIColor greenColor]];
    titleHeaderView.tag =12345;
    
    switch (self.langBool) {
        case LANG_English:{
            [titleHeaderView setFrame:CGRectMake(0, 20, 230, 44)];
            /*[titleView setFrame:CGRectMake(40, 0, 250, 44)];
            [imgView setFrame:CGRectMake(5, 10, 25, 25)];
            [sepImgView setFrame:CGRectMake(33,7,2,29)];
            [dragBtn setFrame:CGRectMake(277, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(272,0,27,44)];
            [titleView setTextAlignment:NSTextAlignmentLeft];*/
        }
            break;
        case LANG_ARABIC:{
            
            [titleHeaderView setFrame:CGRectMake(60, 0, 200, 44)];
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


-(UIView *) setTitleForMainView{
    
   
    
    UIView *titleHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 44)];
    [titleHeaderView setBackgroundColor:[UIColor clearColor]];
    
    titleHeaderView.tag =1234;
    
    
    UILabel *titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] init];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Eagle-Bold" size:17.0];
    }
    
    [titleView setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cevent"]];
    titleView.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    [titleView sizeToFit];
    [titleHeaderView addSubview:titleView];
    
    UIImageView *imgView;
    
    if (!imgView) {
        imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = [UIColor clearColor];
    }
    [imgView setImage:[UIImage imageNamed:@"eventstitle.png"]];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    [titleHeaderView addSubview:imgView];
    
    
    UIImageView *sepImgView;
    
    if (!sepImgView) {
        sepImgView = [[UIImageView alloc] init];
        sepImgView.backgroundColor = [UIColor clearColor];
    }
    [sepImgView setImage:[UIImage imageNamed:@"sep.png"]];
    [sepImgView setContentMode:UIViewContentModeScaleAspectFit];
    [titleHeaderView addSubview:sepImgView];

    UIImageView *ribImgView;
    
    if (!ribImgView) {
        ribImgView = [[UIImageView alloc] init];
        ribImgView.backgroundColor = [UIColor clearColor];
    }
    [ribImgView setImage:[UIImage imageNamed:@"ribbon.png"]];
    [ribImgView setContentMode:UIViewContentModeScaleAspectFit];
    [titleHeaderView addSubview:ribImgView];
    
    
    UIButton *dragBtn;
    if (!dragBtn) {
        dragBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dragBtn.backgroundColor = [UIColor clearColor];
    }
    UIPanGestureRecognizer *panBtn= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBtnAction:)];
    [dragBtn addGestureRecognizer:panBtn];
    [titleHeaderView addSubview:dragBtn];

    
    switch (self.langBool) {
        case LANG_English:{
            [titleView setFrame:CGRectMake(40, 0, 250, 44)];
            [imgView setFrame:CGRectMake(5, 10, 25, 25)];
            [sepImgView setFrame:CGRectMake(33,7,2,29)];
            [dragBtn setFrame:CGRectMake(271.8, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(271.8,0,27,44)];
            [titleView setTextAlignment:NSTextAlignmentLeft];
        }
            break;
        case LANG_ARABIC:{
            
            [titleView setFrame:CGRectMake(10, 0, 258, 44)];
            [imgView setFrame:CGRectMake(280, 10, 25, 25)];
            [sepImgView setFrame:CGRectMake(275,7,2,29)];
            [dragBtn setFrame:CGRectMake(14, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(14,0,27,44)];
            [titleView setTextAlignment:NSTextAlignmentRight];
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
    return  titleHeaderView;

}
- (UIView *)setTitle:(NSString *)title
{
    
    UIView *containerView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [containerView setTag:143];
    [containerView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        
    UIButton *dragBtn;
    dragBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dragBtn.backgroundColor = [UIColor clearColor];
    UIPanGestureRecognizer *panBtn= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBtnAction:)];
    [dragBtn addGestureRecognizer:panBtn];
    
    UILabel *titleView;
    titleView = [[UILabel alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Eagle-Bold" size:17.0];
    titleView.text = title;
    titleView.textAlignment=NSTextAlignmentCenter;
    titleView.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    [titleView setTextAlignment:NSTextAlignmentCenter];
    
    UIImageView *ribImgView;
    ribImgView = [[UIImageView alloc] init];
    ribImgView.backgroundColor = [UIColor clearColor];
    [ribImgView setImage:[UIImage imageNamed:@"ribbon.png"]];
    [ribImgView setContentMode:UIViewContentModeScaleAspectFit];
    
    switch (self.langBool) {
        case LANG_English:{
            [titleView setFrame:CGRectMake(44, 0, 200, 44)];
            [dragBtn setFrame:CGRectMake(271.8, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(271.8,0,27,44)];
            [backBtn setFrame:CGRectMake(0, 0,44, 44)];
        }
            break;
        case LANG_ARABIC:{
            
            [titleView setFrame:CGRectMake(44, 0, 200, 44)];
            [dragBtn setFrame:CGRectMake(14, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(14,0,27,44)];
            [backBtn setFrame:CGRectMake(260, 0,44, 44)];
        }
            break;
        default:
            break;
    }
    [containerView addSubview:titleView];
    [containerView addSubview:backBtn];
    [containerView addSubview:dragBtn];
    [containerView addSubview:ribImgView];
    return containerView;
}


- (UIView *)setTitleForViews:(NSString *)title
{
    
    UIView *containerView= [[UIView alloc]initWithFrame:CGRectMake(44, 0, 270, 44)];
    [containerView setTag:1434];
    [containerView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    
    UIButton *dragBtn;
    dragBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dragBtn.backgroundColor = [UIColor clearColor];
    UIPanGestureRecognizer *panBtn= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBtnAction:)];
    [dragBtn addGestureRecognizer:panBtn];
    UILabel *titleView;
    titleView = [[UILabel alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Eagle-Bold" size:17.0];
    titleView.text = title;
    titleView.textAlignment=NSTextAlignmentCenter;
    titleView.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    [titleView setTextAlignment:NSTextAlignmentCenter];
    
    UIImageView *ribImgView;
    ribImgView = [[UIImageView alloc] init];
    ribImgView.backgroundColor = [UIColor clearColor];
    [ribImgView setImage:[UIImage imageNamed:@"ribbon.png"]];
    [ribImgView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    
    
    switch (self.langBool) {
        case LANG_English:{
            [titleView setFrame:CGRectMake(20, 0, 220, 44)];
            [dragBtn setFrame:CGRectMake(255, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(251,0,27,44)];
        }
            break;
        case LANG_ARABIC:{
            
            [titleView setFrame:CGRectMake(20, 0, 220, 44)];
            [dragBtn setFrame:CGRectMake(-7, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(-7,0,27,44)];
        }
            break;
        default:
            break;
    }
    [containerView addSubview:dragBtn];
    [containerView addSubview:titleView];
    [containerView addSubview:ribImgView];
    return containerView;
}



-(UIView *)titleView:(NSString *)titleText{
 
    UIView *headerView;
    UILabel *titleView1;
    UILabel *titleView2;
    
    if (!titleView1) {
        titleView1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        titleView1.backgroundColor = [UIColor blueColor];
        titleView1.font = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
        titleView1.textAlignment = NSTextAlignmentCenter;
        // titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        // self.navigationItem.titleView = titleView;
    }
    titleView1.text = titleText;
    titleView1.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    
    if (!titleView2) {
        titleView2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
        titleView2.backgroundColor = [UIColor greenColor];
        titleView2.font = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
        titleView2.textAlignment = NSTextAlignmentCenter;
        // titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        // self.navigationItem.titleView = titleView;
    }
    titleView2.text = titleText;
    titleView2.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    if (!headerView) {
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 44)];
        headerView.backgroundColor = [UIColor clearColor];
    }
    [headerView addSubview:titleView1];
    [headerView addSubview:titleView2];
    return headerView;
    
}

-(void)backBtnAction{
    [self.navController fadePopViewController];
}

-(void)showMainHomeView{
    
    ConfMainViewController *mainView = [[ConfMainViewController alloc] initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navController pushFadeViewController:mainView];
    
}

-(void)emptyAllArrays{
    [self.appFavEventArray removeAllObjects];
    [self.appEventArray removeAllObjects];
    [self.appCurrentEventArray removeAllObjects];
    [self.appLatestNewsArray removeAllObjects];
    [self.appImageGalleryArray removeAllObjects];
    [self.appSearchEventsArray removeAllObjects];
    
}

- (void) hideTabBar:(UITabBarController *) tabbarcontroller
{
   /* CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    float fHeight = screenRect.size.height;
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width;
    }
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            view.backgroundColor = [UIColor blackColor];
        }
    }
    [UIView commitAnimations];*/
}



- (void) showTabBar:(UITabBarController *) tabbarcontroller
{
  /*  CGRect screenRect = [[UIScreen mainScreen] bounds];
    float fHeight = screenRect.size.height - 49.0;
    
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width - 49.0;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
        }
    }
    [UIView commitAnimations];*/
}


#pragma mark - Fb methods

- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            
                            @"user_hometown",
                            
                            @"user_birthday",
                            
                            @"user_likes",
                            
                            @"email",
                            
                            @"read_stream",
                            
                            @"publish_actions",
                            
                            nil];
    [FBSession setActiveSession:[[FBSession alloc] initWithPermissions:permissions]];
    [[FBSession activeSession] openWithBehavior:FBSessionLoginBehaviorForcingWebView
                              completionHandler:^(FBSession *session,
                                                  
                                                  FBSessionState state,
                                                  
                                                  NSError *error) {
                                  [self sessionStateChanged:session
                                   
                                                      state:state
                                   
                                                      error:error];
                                  
                              }];
    
}


/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    
    
    switch (state) {
            
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                
                NSLog(@"We have a valid session");
                self.appdelegateSession = session;
                [FBSession setActiveSession:session];
                [FBRequestConnection
                 startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                   id<FBGraphUser> myUser,
                                                   NSError *error) {
                     
                     NSLog(@"my user name is %@", myUser.name);
                    /* [self.mRender setHidden:YES];
                     [self.mAdjustImageView setHidden:NO];
                     [self.cameraBtn setHidden:YES];
                     [self publishPhoto];*/
                     [self publishStory];
                 }];
                
            }
            break;
        case FBSessionStateClosed:{
           // [self.HUD hide:YES];
        }
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
   // [[NSNotificationCenter defaultCenter]
    // postNotificationName:FBSessionStateChangedNotification
   //  object:session];
    if (error) {
        //[self.HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"error"]
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"]
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


-(void)checkFacebookAvailability{
    
    if (![[FBSession activeSession]isOpen]) {
        
        if ([FBSession activeSession].state == FBSessionStateCreatedTokenLoaded) {
            
            [[FBSession activeSession] openWithCompletionHandler:^(FBSession *session,
                                                                   FBSessionState status,
                                                                   NSError *error) {
                // we recurse here, in order to update buttons and labels
            }];
            
        }
        else{
            // No FB session. To be logged in
        }
        
    }
    
}

- (void)publishStory
{
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:self.postParams
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         } else {
             alertText = [NSString stringWithFormat:
                          @"Posted action, id: %@",
                          [result objectForKey:@"id"]];
         }
         // Show the result in an alert
         [[[UIAlertView alloc] initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"fb"]
                                     message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"shareResponse"]
                                    delegate:self
                           cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"]
                           otherButtonTitles:nil]
          show];
     }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}
@end
