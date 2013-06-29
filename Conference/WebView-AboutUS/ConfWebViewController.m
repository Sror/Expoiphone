//
//  MMCSInfoViewController.m
//  MMCS
//
//  Created by varun on 22/02/13.
//  Copyright (c) 2013 InApp Inc. All rights reserved.
//

#import "ConfWebViewController.h"

@interface ConfWebViewController ()

@end

@implementation ConfWebViewController

@synthesize selectedIndex;
@synthesize webViewOperation,eventId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];

 
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *titleWeb;
    
    switch (selectedIndex) {
        case HISTORYVIEW:
           [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"History"]];
            titleWeb = @"history";
            break;
        case MANAGEMENTVIEW:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Management"]];
            titleWeb = @"management";
            break;
        case SERVICESVIEW:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Services"]];
            titleWeb = @"services";
            break;
        case FACILITYVIEW:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Facilities"]];
            titleWeb = @"facility";
            break;
        case PRESSRELEASEVIEW:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Press Release"]];
            titleWeb = @"press_release";
            break;
        case ABOUTSHARJAHVIEW:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"About Sharjah"]];
            titleWeb = @"about_sharjah";
            break;
        case TRAVELVIEW:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Travel & Visa Info"]];
            titleWeb = @"travel_visa";
            break;
        case HOTELVIEW:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Hotels & Shopping"]];
            titleWeb = @"hotels_shopping";
            break;
        case VISITORSURVEY:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Event Visitor Survey"]];
            titleWeb = @"survey_form";
            break;
        case EXHIBITORSURVEY:
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Exhibitor Survey"]];
            titleWeb = @"exhibitor_form";
            break;
            
            
        default:
            break;
    }
    
    
    
    [ApplicationDelegate.HUD show:YES];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    MKNetworkOperation *op = [ApplicationDelegate.appEngine loadWebViewStringforTitle:titleWeb forEvent:self.eventId];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        NSLog(@"%i and str is %@", [completedOperation responseString].length,completedOperation.responseString);
        
        [self.InfoWebView loadHTMLString:[completedOperation responseString] baseURL:nil];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        [UIAlertView showWithError:error];

    }];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setInfoWebView:nil];
    [super viewDidUnload];
}
- (IBAction)backBtnAction:(id)sender {
     //[[self navigationController] popToViewController:[[ApplicationDelegate controllerArray] objectAtIndex:HOMEVIEW]  animated:YES];
    [[self navigationController] popViewControllerAnimated:YES];

}
@end
