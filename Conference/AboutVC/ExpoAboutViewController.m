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
    
    //[self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Registration"]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.historyBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.servicesBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.faciltiesBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.mgmntBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[aboutUsScrollView reloadInputViews];
    //[aboutUsScrollView setNeedsDisplay];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self applyLanguage];
}


-(void)refreshView:(NSNotification *) notification{
    
    NSLog(@"Notification");
    
    [self applyLanguage];
    
}

-(void)applyLanguage{
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"aUs-title"]]];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    [self.historyBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"history"] forState:UIControlStateNormal];
    [self.mgmntBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"management"] forState:UIControlStateNormal];
    [self.faciltiesBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"facilities"] forState:UIControlStateNormal];
    [self.servicesBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"services"] forState:UIControlStateNormal];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
 
}

- (IBAction)buttonClickAction:(id)sender {
    
    ConfWebViewController *confWebView = [[ConfWebViewController alloc]initWithNibName:@"ConfWebViewController" bundle:nil];
    [confWebView setSelectedIndex:[sender tag]];
    [self.navigationController pushFadeViewController:confWebView];
}

- (IBAction)homeBtnAction:(id)sender {
    
    [self.navigationController fadePopViewController];
}
- (void)viewDidUnload {
    [self setHomeLabel:nil];
    [super viewDidUnload];
}
@end
