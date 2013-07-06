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
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Social Media"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.fbBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.ytBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.twtBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.igBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];

    
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
    [super viewDidUnload];
}
@end
