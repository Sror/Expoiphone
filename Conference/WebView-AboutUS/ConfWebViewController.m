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
@synthesize webViewOperation,eventId,titleWeb;

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

    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    self.navigationItem.hidesBackButton = YES;
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"loading"]];

 
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
        
   // NSString *titleWeb;
    
    switch (selectedIndex) {
        case HISTORYVIEW:
            titleHead = @"history";
          // [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"History"]];
            titleWeb = @"history";
            break;
        case MANAGEMENTVIEW:
            titleHead = @"management";
            //[self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Management"]];
            titleWeb = @"management";
            break;
        case SERVICESVIEW:
            titleHead = @"services";
           // [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Services"]];
            titleWeb = @"services";
            break;
        case FACILITYVIEW:
            titleHead = @"facilities";
           // [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Facilities"]];
            titleWeb = @"facility";
            break;
        case PRESSRELEASEVIEW:
            titleHead = @"pRelease";
           // [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Press Release"]];
            titleWeb = @"press_release";
            break;
        case ABOUTSHARJAHVIEW:
            titleHead = @"abSharjah";
            //[self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"About Sharjah"]];
            titleWeb = @"about_sharjah";
            break;
        case TRAVELVIEW:
            titleHead = @"tvisitInfo";
            //[self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Travel & Visa Info"]];
            titleWeb = @"travel_visa";
            break;
        case HOTELVIEW:
            titleHead = @"hotel_shopping";
            //[self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Hotels & Shopping"]];
            titleWeb = @"hotels_shopping";
            break;
            
        default:
            break;
    }
 
    [self updateUI];
    

    //MKNetworkOperation *op2 =
    
}


-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}

-(void)updateUI{
    
    
    
    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    
    NSLog(@"title head is %@", titleHead);
    //[self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:titleHead]]];
    [self loadWebViewWithData];
}

-(void)loadWebViewWithData{
    
    [ApplicationDelegate.HUD show:YES];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    MKNetworkOperation *op = [ApplicationDelegate.appEngine loadWebViewStringforTitle:titleWeb];
    
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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    
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
