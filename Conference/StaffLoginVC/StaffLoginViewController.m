//
//  StaffLoginViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 17/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "StaffLoginViewController.h"
#import "UIView+bounce.h"

@interface StaffLoginViewController ()

@end

@implementation StaffLoginViewController

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
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Staff Login"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    
    
    [self.bounceView setFrame:CGRectMake(22, 25, self.bounceView.frame.size.width, self.bounceView.frame.size.height)];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)eventVisitorBtnAction:(id)sender {
    
    
    [self.view addSubviewWithBounce:self.bounceView];
}

- (IBAction)exhibitorBtnAction:(id)sender {
    
}

- (IBAction)homeBtnAction:(id)sender {
    
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController popToViewController:confView animated:YES];
}
- (IBAction)closeBtnAction:(id)sender {
    
    [self.bounceView removeSubview:self.bounceView];
}

- (IBAction)goBtnAction:(id)sender {
}
@end
