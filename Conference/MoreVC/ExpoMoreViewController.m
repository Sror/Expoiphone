//
//  ExpoMoreViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoMoreViewController.h"
#import "ExpoRegViewController.h"

@interface ExpoMoreViewController ()

@end

@implementation ExpoMoreViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        CGRect frame = self.navigationItem.titleView.frame;
        frame.origin.x = 10;
        self.navigationItem.titleView.frame = frame;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"More"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.mediaBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:17.0]];
    [self.socialMediaBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:17.0]];
    [self.subFormBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:17.0]];
    [self.signInBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:17.0]];
    [self.visitorBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:17.0]];
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES animated:NO];
    self.moreScrollView.contentSize = CGSizeMake(320, 568);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    
}


-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}

-(void)updateUI{
    
    [self.mediaBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"mCentre"] forState:UIControlStateNormal];
    [self.socialMediaBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sMedia"] forState:UIControlStateNormal];
    [self.subFormBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sForm"] forState:UIControlStateNormal];
    [self.signInBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"signIn"] forState:UIControlStateNormal];
    [self.visitorBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"visitInfo"] forState:UIControlStateNormal];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mediaCornerBtnAction:(id)sender {
    
    MediaCornerViewController* mcview = [[MediaCornerViewController alloc]initWithNibName:@"MediaCornerViewController" bundle:nil];
    [self.navigationController pushFadeViewController:mcview];
    
}

- (IBAction)visitorInfoBtnAction:(id)sender {
    
    ConfVisitorInfoViewController* mcview = [[ConfVisitorInfoViewController alloc]initWithNibName:@"ConfVisitorInfoViewController" bundle:nil];
    [self.navigationController pushFadeViewController:mcview];
    
}

- (IBAction)socialMediaBtnAction:(id)sender {
    
    ExpoSocialViewController* socView = [[ExpoSocialViewController alloc]initWithNibName:@"ExpoSocialViewController" bundle:nil];
    [self.navigationController pushFadeViewController:socView];
    
    
}

- (IBAction)staffLoginBtnAction:(id)sender {
    
    ConfSignInViewController *signIvew = [[ConfSignInViewController alloc]initWithNibName:@"ConfSignInViewController" bundle:nil];
    [self.navigationController pushFadeViewController:signIvew];
}

- (IBAction)subFormBtnAction:(id)sender {
    
    ExpoRegViewController *signIvew = [[ExpoRegViewController alloc]initWithNibName:@"ExpoRegViewController" bundle:nil];
    [signIvew setFromView:YES];
    [self.navigationController pushFadeViewController:signIvew];
    
}

- (IBAction)homeBtnAction:(id)sender {
    
    //ConfMainViewController *mainView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController fadePopViewController];
    
}
- (void)viewDidUnload {
    [self setHomeBtn:nil];
    [self setHomeLabel:nil];
    [super viewDidUnload];
}
@end
