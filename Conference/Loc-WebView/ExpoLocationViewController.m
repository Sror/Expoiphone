//
//  ConfLocation-WebViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 30/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoLocationViewController.h"

@interface ExpoLocationViewController ()

@end

@implementation ExpoLocationViewController

@synthesize viewType,titleStr,webViewType,eventID;
@synthesize forPdfView,filePathUrl;

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
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // NSURL *webUrl;
    
    
    
   /* switch (webViewType) {
            
           
            
        case EXHIBITORSURVEY:
            
        {   webUrl = [NSURL URLWithString:DYNAMICWEBVIEWURL(eventID, titleStr)];
            
        }
            
            break;
            
        case EVENTVISITOR:{
            
        }
            
            break;
            
        default:
            break;
    }*/

    
    
    if (viewType==IMGVIEW) {
   
        [ApplicationDelegate.HUD show:YES];
            [self.webviewForForms setHidden:YES];
        [self.viewSegmentControl setHidden:YES];
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Location"]];
            
            self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:titleStr] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                [ApplicationDelegate.HUD hide:YES];
                if([titleStr isEqualToString:[url absoluteString]]) {
                    
                    [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                        self.imageView.image = fetchedImage;
                    } completion:nil];
                }
                
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                
                [ApplicationDelegate.HUD hide:YES];
                [UIAlertView showWithError:error];
                
            }];
    }else{
        [self.imageView setHidden:YES];
        switch (webViewType) {
            case EXHIBITORSURVEY:
            {
                [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Exhibitor Survey"]];
                [self.viewSegmentControl setHidden:YES];
                [self.webviewForForms setFrame:CGRectMake(0, 0, 320, 460)];
                /*NSString *urlAddress = @"http://www.google.com";
                NSURL *url = [NSURL URLWithString:urlAddress];
                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                [self.webviewForForms loadRequest:requestObj];*/
            }
                break;
            case EVENTVISITOR:
            {
                [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Event Visitor Survey"]];
                [self.viewSegmentControl setHidden:YES];
                [self.webviewForForms setFrame:CGRectMake(0, 0, 320, 460)];
                
                /*NSString *urlAddress = DYNAMICWEBVIEWURL(eventID, titleStr);
                NSURL *url = [NSURL URLWithString:urlAddress];
                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                [self.webviewForForms loadRequest:requestObj];
                
                */
            }
                break;
            case EVENTREGISTRATION:
            {
                [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Event Registration"]];
                [self.webviewForForms setFrame:CGRectMake(0, 50, 320, 390)];
                [self.viewSegmentControl setHidden:NO];
                
                
            }
                break;
            
            default:
                break;
        }
        
        if (forPdfView) {
            NSURLRequest *request = [NSURLRequest requestWithURL:filePathUrl];
            [self.webviewForForms loadRequest:request];
        }
        else{
        
        [self.webviewForForms loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DYNAMICWEBVIEWURL(eventID, titleStr,@"chikku")]]];

        NSLog(@"url is %@",DYNAMICWEBVIEWURL(eventID, titleStr,@"chikku"));
        }
    }

    
            
      
          /*  [self.imageView setHidden:YES];
            [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Event-Visitor Survey"]];*/
            
        
    //}
    
}

#pragma mark - Delegate methods


-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
    [ApplicationDelegate.HUD hide:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [ApplicationDelegate.HUD hide:YES];
    NSLog(@"finish");
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [ApplicationDelegate.HUD hide:YES];
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentControlAction:(id)sender {
    
    switch (self.viewSegmentControl.selectedSegmentIndex) {
        case 0:
            NSLog(@"Media");
            [self.webviewForForms loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DYNAMICWEBVIEWURL(eventID, @"media",@"")]]];
            break;
        case 1:
            NSLog(@"Visitor");
            [self.webviewForForms loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DYNAMICWEBVIEWURL(eventID, @"visitor",@"")]]];
            break;
        case 2:
            NSLog(@"Exhibitor");
            [self.webviewForForms loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DYNAMICWEBVIEWURL(eventID, @"event_exihibitor",@"")]]];
            break;
            
        default:
            break;
    }
}
@end
