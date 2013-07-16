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
    
    
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    self.navigationItem.hidesBackButton = YES;
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Checking"];
    [self.usernameTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.passwordTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.loginBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"signIn"]]];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    
    
    
    [self.usernameTxtField setText:@""];
    [self.passwordTxtField setText:@""];
    [self.loginBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"signIn"] forState:UIControlStateNormal];
    [self.usernameTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"username"]];
    [self.passwordTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"password"]];
    //[self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    [self.usernameTxtField setText:@""];
    [self.passwordTxtField setText:@""];
}


- (IBAction)loginBtnAction:(id)sender {
    
    
    [self.usernameTxtField resignFirstResponder];
    [self.passwordTxtField resignFirstResponder];
    
    if ([[ConferenceHelper SharedHelper]isEmptyString:self.usernameTxtField.text] || [[ConferenceHelper SharedHelper]isEmptyString:self.passwordTxtField.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
    else{
        
        
        [ApplicationDelegate.HUD show:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
        [ApplicationDelegate.appEngine loginAction:self.usernameTxtField.text withPassword:self.passwordTxtField.text onCompletion:^(NSMutableDictionary *loginResponseDic) {
  
            [self.navigationController.navigationBar setUserInteractionEnabled:YES];
            [ApplicationDelegate.HUD hide:YES];
            
            if ([[loginResponseDic objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithBool:0]]) {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Invalid Credentials" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            else{
                
                [ApplicationDelegate setUserNameString:self.usernameTxtField.text];
                
                StaffLoginViewController *stafView = [[StaffLoginViewController alloc]initWithNibName:@"StaffLoginViewController" bundle:nil];
                [self.navigationController pushFadeViewController:stafView];
                
            }
            
        } onError:^(NSError *error) {
            
            [self.navigationController.navigationBar setUserInteractionEnabled:YES];
            [ApplicationDelegate.HUD hide:YES];
            [UIAlertView showWithError:error];

        }];
    }
  }

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];

}

- (void)viewDidUnload {
    [self setHomeLabel:nil];
    [self setLoginBtn:nil];
    [super viewDidUnload];
}
@end
