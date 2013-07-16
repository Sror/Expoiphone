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
    
    self.navigationItem.hidesBackButton = YES;
    
   // [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Visitor Info"]];
   // [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
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
    
    
    
    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    
    //[self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"visitInfo"]]];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:{
            [self.arabContainerView setHidden:YES];
            [self.engContainerView setHidden:NO];

            [self.hotelBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"hotel_shopping"] forState:UIControlStateNormal];
            [self.abtBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"abSharjah"] forState:UIControlStateNormal];
            [self.travelBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"tvisitInfo"] forState:UIControlStateNormal];
            
        }
            break;
        case LANG_ARABIC:{
            
            [self.arabContainerView setHidden:NO];
            [self.engContainerView setHidden:YES];
            
            [self.arabHSBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"hotel_shopping"] forState:UIControlStateNormal];
            [self.arabASBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"abSharjah"] forState:UIControlStateNormal];
            [self.arabTVBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"tvisitInfo"] forState:UIControlStateNormal];

            self.arabHSBtn.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabASBtn.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabTVBtn.transform = CGAffineTransformMakeRotation(M_PI);
            
            self.arabHSBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabASBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabTVBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            
            self.detImg1.transform = CGAffineTransformMakeRotation(M_PI);
            self.detImg2.transform = CGAffineTransformMakeRotation(M_PI);
            self.detImg3.transform = CGAffineTransformMakeRotation(M_PI);
            
            
            
            
        }
            //self.historyBtn.transform = CGAffineTransformMakeRotation(M_PI);
            break;
            
        default:
            break;
    }
    

    
   /* */
    
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
    [self setArabContainerView:nil];
    [self setEngContainerView:nil];
    [self setArabASBtn:nil];
    [self setArabTVBtn:nil];
    [self setArabHSBtn:nil];
    [self setDetImg1:nil];
    [self setDetImg2:nil];
    [self setDetImg3:nil];
    [super viewDidUnload];
}
@end
