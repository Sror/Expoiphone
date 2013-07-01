//
//  AMSplashViewController.m
//  ArtherM
//
//  Created by EAAM TECHNOLOGIES on 20/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AMSplashViewController.h"

@interface AMSplashViewController ()

@end

@implementation AMSplashViewController

@synthesize homeViewC;

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
    [self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self performSelector:@selector(presentNextView) withObject:nil afterDelay:0.0];
    
}

-(void)presentNextView{
    
   /* homeViewC = [[ArtherMViewController alloc] initWithNibName:@"ArtherMViewController" bundle:nil];
    [self.navigationController pushViewController:homeViewC animated:NO];*/
    
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
