//
//  ExpoSocialViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 29/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoSocialViewController.h"

@interface ExpoSocialViewController ()

@end

@implementation ExpoSocialViewController

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
    
     self.scrollView.contentSize = CGSizeMake(320, 568);
    self.arabContainerView.contentSize = CGSizeMake(320, 568);
    self.navigationItem.hidesBackButton = YES;
    
    //[self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Social Media"]];
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.fbBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.ytBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.twtBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.igBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"sMedia"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];
    
}

-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}
-(void)updateUI{
    
   /* [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sMedia"]]];
    
    [self.fbBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"fb"] forState:UIControlStateNormal];
    [self.ytBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"youTube"] forState:UIControlStateNormal];
    [self.twtBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"twitter"] forState:UIControlStateNormal];
    [self.igBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"instagram"] forState:UIControlStateNormal];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];*/
    
    
    
    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sMedia"]]];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:{
            [self.arabContainerView setHidden:YES];
            [self.scrollView setHidden:NO];
            [self.fbBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"fb"] forState:UIControlStateNormal];
            [self.ytBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"youTube"] forState:UIControlStateNormal];
            [self.twtBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"instagram"] forState:UIControlStateNormal];
            [self.igBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"twitter"] forState:UIControlStateNormal];
        }
            break;
        case LANG_ARABIC:{
            
            [self.arabContainerView setHidden:NO];
            [self.scrollView setHidden:YES];
            
            [self.arabfbBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"fb"] forState:UIControlStateNormal];
            [self.arabytBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"youTube"] forState:UIControlStateNormal];
            [self.arabigBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"instagram"] forState:UIControlStateNormal];
            [self.arabTwtBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"twitter"] forState:UIControlStateNormal];
            
            self.arabfbBtn.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabytBtn.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabigBtn.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabTwtBtn.transform = CGAffineTransformMakeRotation(M_PI);
            
            self.arabfbBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabytBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabigBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabTwtBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            
            self.detImg1.transform = CGAffineTransformMakeRotation(M_PI);
            self.detImg2.transform = CGAffineTransformMakeRotation(M_PI);
            self.detImg3.transform = CGAffineTransformMakeRotation(M_PI);
            self.detImg4.transform = CGAffineTransformMakeRotation(M_PI);
            
            
            
            
        }
            //self.historyBtn.transform = CGAffineTransformMakeRotation(M_PI);
            break;
            
        default:
            break;
    }

    
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

- (IBAction)fbBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com/ExpoCentreShj"]]];
}

- (IBAction)youTubeBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/user/TheExpocentresharjah"]]];
    
}

- (IBAction)instBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://instagram.com/expocentreshj"]]];
    
    /*UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Instagram not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];*/
}

- (IBAction)twitBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/ExpoCentreShj"]]];
    
}



// http://ae.linkedin.com/pub/expo-centre-sharjah/39/695/82b


- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];
}
- (void)viewDidUnload {
    [self setHomeLabel:nil];
    [self setArabContainerView:nil];
    [self setArabfbBtn:nil];
    [self setArabytBtn:nil];
    [self setArabigBtn:nil];
    [self setArabTwtBtn:nil];
    [self setDetImg1:nil];
    [self setDetImg2:nil];
    [self setDetImg3:nil];
    [self setDetImg4:nil];
    [super viewDidUnload];
}
@end
