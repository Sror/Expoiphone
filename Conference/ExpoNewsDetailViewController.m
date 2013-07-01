//
//  ExpoNewsDetailViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 01/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoNewsDetailViewController.h"

@interface ExpoNewsDetailViewController ()

@end

@implementation ExpoNewsDetailViewController

@synthesize newsDetail;

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
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"News Details"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnAction:(id)sender {
    
    [self.navigationController fadePopViewController];
}
@end
