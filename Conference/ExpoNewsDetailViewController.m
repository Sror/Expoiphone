//
//  ExpoNewsDetailViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 01/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoNewsDetailViewController.h"
#import "ConfMainViewController.h"

@interface ExpoNewsDetailViewController ()

@end

@implementation ExpoNewsDetailViewController

@synthesize newsDetail,fromCommonView,commonDic,imageArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
        
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.newsTitleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.newsDetailTxtView setFont:[UIFont fontWithName:@"Eagle-Light" size:12.0]];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    
    
    if (fromCommonView) {
        
        [self.imageArray removeAllObjects];
        [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Press-Release"]];
        
        [self.newsTitleLabel setText:[commonDic objectForKey:@"title"]];
        [self.newsDetailTxtView setText:[commonDic objectForKey:@"description"]];
        
        [self.imageArray addObjectsFromArray:[commonDic objectForKey:@"gallery"]];
        
        NSString *iconUrl=[commonDic objectForKey:@"thumb_image"];
        
        self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            
            
            if([iconUrl isEqualToString:[url absoluteString]]) {
                
                [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                    self.newsImageView.image = fetchedImage;
                } completion:nil];
            }
            
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            
        }];
        
        if (self.imageArray.count>0) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"Gallery" forState:UIControlStateNormal];
            [button.layer setCornerRadius:4.0f];
            [button.layer setMasksToBounds:YES];
            [button.layer setBorderWidth:1.0f];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button.layer setBorderColor: [[UIColor blackColor] CGColor]];
            button.frame=CGRectMake(0.0, 100.0, 60.0, 30.0);
            [button addTarget:self action:@selector(galleryAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem* gallItem = [[UIBarButtonItem alloc] initWithCustomView:button];

            UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            fixed1.width = 40.0f;
            
            [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:fixed1,gallItem, nil]];
        }
    }

    else{
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"News Details"]];

    [self.newsTitleLabel setText:[newsDetail news_title]];
    [self.newsDetailTxtView setText:[newsDetail news_description]];
    
    
    
    NSString *iconUrl=newsDetail.news_image;
    
    self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        
        
        if([iconUrl isEqualToString:[url absoluteString]]) {
            
            [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                self.newsImageView.image = fetchedImage;
            } completion:nil];
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnAction:(id)sender {
    
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];
    //[self.navigationController fadePopViewController];
}
@end
