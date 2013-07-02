//
//  ExpoAboutViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoAboutViewController.h"

@interface ExpoAboutViewController ()

@end

@implementation ExpoAboutViewController
@synthesize aboutUsScrollView;

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
    aboutUsScrollView.contentSize = CGSizeMake(320, 568);
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"About Us"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.historyBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.servicesBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.faciltiesBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.mgmntBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[aboutUsScrollView reloadInputViews];
    //[aboutUsScrollView setNeedsDisplay];
    [self.navigationController setToolbarHidden:YES animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClickAction:(id)sender {
    
    ConfWebViewController *confWebView = [[ConfWebViewController alloc]initWithNibName:@"ConfWebViewController" bundle:nil];
    [confWebView setSelectedIndex:[sender tag]];
    [self.navigationController pushFadeViewController:confWebView];
}

- (IBAction)homeBtnAction:(id)sender {
    
    [self.navigationController fadePopViewController];
}
@end
