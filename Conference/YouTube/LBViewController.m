//
//  LBViewController.m
//  LBYouTubeView
//
//  Created by Laurin Brandner on 27.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBViewController.h"
#import "LBYouTubePlayerViewController.h"

//@implementation UINavigationBar (CustomImage)
////- (void)drawRect:(CGRect)rect {
////    UIImage *image = [UIImage imageNamed: @"titlebar.png"];
////    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
////}
//@end


@implementation LBViewController


@synthesize youtubeNavigator,navigationItem;
//@synthesize navigationItem,type,event;
//@synthesize pro;

//@synthesize car;
@synthesize controller,youtubeUrl;

- (void)dealloc {
    self.controller.delegate = nil;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
   // [self.navigationController.navigationBar setHidden:YES];
   /*
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:1];
    label.textColor=[UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text=@"Video";
    self.navigationItem.titleView = label;
    [label sizeToFit];*/
   
    
    self.navigationItem.titleView = [ApplicationDelegate setTitle:@"Video"];

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(Backbuton) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];

     //UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:backBtn]];
    
    /*UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back_button.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];  
    [backBtn addTarget:self action:@selector(Backbuton) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 52, 33);  
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem =cancelButton;*/
    
    
    NSLog(@"%@",youtubeUrl);
    
   // youtubeUrl = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=OUz-5YjXFeg"];
    
    NSLog(@"youtubeUrl -- %@",youtubeUrl);

   /* self.youTubeHeadLabel.backgroundColor = [UIColor clearColor];
    self.youTubeHeadLabel.font = [UIFont fontWithName:@"AdelleBasic-Bold" size:20.0];
    // titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    // self.navigationItem.titleView = titleView;
//}
self.youTubeHeadLabel.text = @"YouTube Player";
self.youTubeHeadLabel.textColor = [UIColor colorWithRed:(218.0f/255.0f) green:(107.0f/255.0f) blue:(17.0f/255.0f) alpha:1];
[self.youTubeHeadLabel sizeToFit];
    [self.youTubeHeadLabel setFrame:CGRectMake(55, 8, 210, 34)];*/
    
    
    
    //UILabel *titleView;
   // if (!titleView) {
        self.youTubeHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 8, 210, 34)];
        self.youTubeHeadLabel.backgroundColor = [UIColor clearColor];
        self.youTubeHeadLabel.font = [UIFont fontWithName:@"Eagle-Bold" size:17.0];
    //}
    self.youTubeHeadLabel.text =@"YouTube Player";

    self.youTubeHeadLabel.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    [self.youTubeHeadLabel sizeToFit];
    
   // return titleView;
    
    
  /*  UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:backBtn]];*/

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.controller = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:youtubeUrl]];
    self.controller.delegate = self;
    self.controller.quality = LBYouTubePlayerQualityLarge;
    self.controller.view.frame = CGRectMake(10.0f,70.0f, 300, 325.0f);
    //  self.controller.view.center = self.view.;
    [self.view addSubview:self.controller.view];
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return  NO;
}

#pragma mark - 
#pragma mark LBYouTubePlayerViewControllerDelegate

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    NSLog(@"Did extract video source:%@", videoURL);
}

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller failedExtractingYouTubeURLWithError:(NSError *)error {
    NSLog(@"Failed loading video due to error:%@", error);
}

-(void)Backbuton
{
    [self.controller stopper2];
 
    [self.navigationController popViewControllerAnimated:YES];
  //  [self dismissModalViewControllerAnimated:YES];
    
}
-(void)backBtnAction
{
    [self.controller stopper2];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)viewDidUnload {
    [self setYoutubeNavigator:nil];
    [self setNavigationItem:nil];
    [self setYouTubeHeadLabel:nil];
    [super viewDidUnload];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    
    
}
- (IBAction)shareButtonPressed:(id)sender {
    
//    
//    if ([type isEqualToString:@"car"]) {
//        // NSURL *url = [NSURL URLWithString:car.carShareUrl];   
//        SHKItem *item = [SHKItem URL:[NSURL URLWithString:youtubeUrl] title:[NSString  stringWithFormat:@" From AMM Iphone app,%@ %@ %@",car.carYearRange,car.carMake ,car.carModel] contentType:SHKURLContentTypeVideo];
//        //    
//        //SHKItem *item = [SHKItem URL:url title: contentType:(SHKShareTypeURL)];
//        
//        
//        item.facebookURLShareDescription = [NSString  stringWithFormat:@"%@ %@ %@",car.carYearRange,car.carMake ,car.carModel];
//        
//        SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
//        [SHK setRootViewController:self];
//        // [actionSheet showFromToolbar:self.navigationController.toolbar];
//        [actionSheet showInView:self.view];
//    }
//    else if([type isEqualToString:@"event"])
//    {
//        // NSURL *url = [NSURL URLWithString:car.carShareUrl];   
//        SHKItem *item = [SHKItem URL:[NSURL URLWithString:youtubeUrl] title:[NSString  stringWithFormat:@" From AMM Iphone app,%@ %@ %@",event.eventName, event.eventLocation ,event.eventStartDate] contentType:SHKURLContentTypeVideo];
//        //    
//        //SHKItem *item = [SHKItem URL:url title: contentType:(SHKShareTypeURL)];
//        
//        
//        item.facebookURLShareDescription = [NSString  stringWithFormat:@" From AMM Iphone app,%@ %@ %@",event.eventName, event.eventLocation ,event.eventStartDate];
//        
//        SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
//        [SHK setRootViewController:self];
//        // [actionSheet showFromToolbar:self.navigationController.toolbar];
//        [actionSheet showInView:self.view]; 
//    }
  
}
- (IBAction)backBtnACtion:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
