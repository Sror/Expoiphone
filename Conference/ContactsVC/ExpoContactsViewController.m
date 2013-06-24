//
//  ExpoContactsViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoContactsViewController.h"

@interface ExpoContactsViewController ()

@end

@implementation ExpoContactsViewController

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
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Contact Us"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnAction:(id)sender {
    [self.navigationController fadePopViewController];
}

- (IBAction)enquiryBtnAction:(id)sender {
    
    
    
}

- (IBAction)shareBtnAction:(id)sender {
    
    
    
}

- (IBAction)mapBtnAction:(id)sender {
    
    MapViewControllerr *mpView = [[MapViewControllerr alloc] initWithNibName:@"MapViewControllerr" bundle:nil];
    [self.navigationController pushFadeViewController:mpView];
}

- (IBAction)callBtnAction:(id)sender {
}

@end
