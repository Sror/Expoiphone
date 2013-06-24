//
//  ExpoMoreViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoMoreViewController.h"

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
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES animated:NO];
    self.moreScrollView.contentSize = CGSizeMake(320, 568);
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
    
    
}

- (IBAction)staffLoginBtnAction:(id)sender {
    
    
}

- (IBAction)subFormBtnAction:(id)sender {
}

- (IBAction)homeBtnAction:(id)sender {
    
    //ConfMainViewController *mainView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController fadePopViewController];
    
}
@end
