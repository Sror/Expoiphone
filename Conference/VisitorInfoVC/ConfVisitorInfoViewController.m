//
//  ConfVisitorInfoViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 17/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConfVisitorInfoViewController.h"

@interface ConfVisitorInfoViewController ()

@end

@implementation ConfVisitorInfoViewController

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
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Visitor Info"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    [self.hotelBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.abtBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.travelBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
}


-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];
    
}
-(void)updateUI{
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"visitInfo"]]];
    [self.hotelBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"hotel_shopping"] forState:UIControlStateNormal];
    [self.abtBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"abSharjah"] forState:UIControlStateNormal];
    [self.travelBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"tvisitInfo"] forState:UIControlStateNormal];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)abtSharjahBtnAction:(id)sender {
    
    ConfWebViewController *confWebView = [[ConfWebViewController alloc]initWithNibName:@"ConfWebViewController" bundle:nil];
    [confWebView setSelectedIndex:[sender tag]];
    [self.navigationController pushFadeViewController:confWebView];
    
    
}

- (IBAction)travelBtnAction:(id)sender {
    
    ConfWebViewController *confWebView = [[ConfWebViewController alloc]initWithNibName:@"ConfWebViewController" bundle:nil];
    [confWebView setSelectedIndex:[sender tag]];
    [self.navigationController pushFadeViewController:confWebView];
}

- (IBAction)hotelBtnAction:(id)sender {
    
    ConfWebViewController *confWebView = [[ConfWebViewController alloc]initWithNibName:@"ConfWebViewController" bundle:nil];
    [confWebView setSelectedIndex:[sender tag]];
    [self.navigationController pushFadeViewController:confWebView];
    
}

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *cfMainView= [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:cfMainView];

}
- (void)viewDidUnload {
    [self setHomeLabel:nil];
    [super viewDidUnload];
}
@end
