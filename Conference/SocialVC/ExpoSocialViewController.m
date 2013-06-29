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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fbBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com"]]];
}

- (IBAction)youTubeBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com"]]];
    
}

- (IBAction)instBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com"]]];
    
}

- (IBAction)twitBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com"]]];
    
}

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];
}
@end
