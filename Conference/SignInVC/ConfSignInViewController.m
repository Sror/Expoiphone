//
//  ConfSignInViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 29/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//


#import "ConfSignInViewController.h"
#import "StaffLoginViewController.h"
#import "ConferenceHelper.h"
@interface ConfSignInViewController ()

@end

@implementation ConfSignInViewController

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
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Checking"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)loginBtnAction:(id)sender {
    
    
  /*  [self.usernameTxtField resignFirstResponder];
    [self.passwordTxtField resignFirstResponder];
    
    if ([[ConferenceHelper SharedHelper]isEmptyString:self.usernameTxtField.text] || [[ConferenceHelper SharedHelper]isEmptyString:self.passwordTxtField.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
    else{
        
        [ApplicationDelegate.HUD show:YES];
        [self.navigationController.navigationController.navigationBar setUserInteractionEnabled:NO];
        [ApplicationDelegate.appEngine loginAction:self.usernameTxtField.text withPassword:self.passwordTxtField.text onCompletion:^(NSMutableDictionary *loginResponseDic) {
  
            NSLog(@"loginresp str is %@", loginResponseDic);
            [self.navigationController.navigationController.navigationBar setUserInteractionEnabled:NO];
            [ApplicationDelegate.HUD hide:YES];
            
            if (![loginResponseDic objectForKey:@"result"]) {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Invalid Credentials" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            else{*/
                
                StaffLoginViewController *stafView = [[StaffLoginViewController alloc]initWithNibName:@"StaffLoginViewController" bundle:nil];
                [self.navigationController pushFadeViewController:stafView];
                
           /* }
            
        } onError:^(NSError *error) {
            
            [self.navigationController.navigationController.navigationBar setUserInteractionEnabled:NO];
            [ApplicationDelegate.HUD hide:YES];
            [UIAlertView showWithError:error];

        }];
    }*/
  }

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];

}

@end