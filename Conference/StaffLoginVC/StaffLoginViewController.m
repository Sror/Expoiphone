//
//  StaffLoginViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 17/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "StaffLoginViewController.h"
#import "UIView+bounce.h"
#import "ExpoLocationViewController.h"

@interface StaffLoginViewController ()

@end

@implementation StaffLoginViewController
@synthesize eventId;

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
    
    self.navigationItem.hidesBackButton = YES;
    
    
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    
    [self.bounceView setFrame:CGRectMake(22, 25, self.bounceView.frame.size.width, self.bounceView.frame.size.height)];
    [self.eventBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:16.0]];
    [self.exBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:16.0]];
    [self.bounceHeaderLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:17.0]];
    
     [self.bounceView setFrame:CGRectMake(15, 5, self.bounceView.frame.size.width, self.bounceView.frame.size.height)];
    
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
     [self.bounceView removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];
    
}
-(void)updateUI{
    

    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"staffLogin"]]];
    [self.homeLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"home"]];
   
    [self.bounceHeaderLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"chooseanevent"]];
    
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:{
            [self.arabContainerView setHidden:YES];
            [self.engContainerView setHidden:NO];
            [self.eventBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"eventSurvey"] forState:UIControlStateNormal];
            [self.exBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"exSurvey"] forState:UIControlStateNormal];
            
        }
            break;
        case LANG_ARABIC:{
            
            [self.arabContainerView setHidden:NO];
            [self.engContainerView setHidden:YES];
            
            [self.arabEventBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"eventSurvey"] forState:UIControlStateNormal];
            [self.arabExhbtBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"exSurvey"] forState:UIControlStateNormal];
            
            self.arabEventBtn.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabExhbtBtn.transform = CGAffineTransformMakeRotation(M_PI);
            
            self.arabEventBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);
            self.arabExhbtBtn.titleLabel.transform = CGAffineTransformMakeRotation(M_PI);

            
            self.imgDet1.transform = CGAffineTransformMakeRotation(M_PI);
            self.imgDet2.transform = CGAffineTransformMakeRotation(M_PI);

     
            
        }
            //self.historyBtn.transform = CGAffineTransformMakeRotation(M_PI);
            break;
            
        default:
            break;
    }


    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    
}



- (IBAction)eventVisitorBtnAction:(id)sender {
    
    [self setEventId:@""];
    checkedCell = nil;
    [self setBtnType:1];
    if (ApplicationDelegate.appEventArray.count!=0) {
        [self.view addSubviewWithBounce:self.bounceView];
    }else{
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noEventsFound"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"], nil];
        [al show];    }
    

}

- (IBAction)exhibitorBtnAction:(id)sender {
 
    [self setEventId:@""];
    checkedCell = nil;
    [self setBtnType:2];
    if (ApplicationDelegate.appEventArray.count!=0) {
        [self.view addSubviewWithBounce:self.bounceView];
    }else{
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noEventsFound"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"], nil];
        [al show];
    }
}

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];
}
- (IBAction)closeBtnAction:(id)sender {
    
    [self setEventId:@""];
    [self.bounceView removeSubview:self.bounceView];
}

- (IBAction)goBtnAction:(id)sender {
    
    if (self.eventId) {        
        
        NSString *action;
        ExpoLocationViewController *loc = [[ExpoLocationViewController alloc]initWithNibName:@"ExpoLocationViewController" bundle:nil];
        
        switch (self.btnType) {
            case 1:
                [loc setWebViewType:EVENTVISITOR];
                action = @"survey_form";
                break;
            case 2:
                [loc setWebViewType:EXHIBITORSURVEY];
                action = @"exhibitor_form";
                break;
            default:
                break;
        }
        [loc setViewType:WEBVIEW];
        [loc setTitleStr:action];
        [loc setEventID:eventId];
        
        [self.navigationController pushFadeViewController:loc];
        
        
         
      /*  ConfWebViewController *webView = [[ConfWebViewController alloc]initWithNibName:@"ConfWebViewController" bundle:nil];
        switch (self.btnType) {
            case 1:
                [webView setSelectedIndex:VISITORSURVEY];
                break;
            case 2:
                [webView setSelectedIndex:EXHIBITORSURVEY];
                break;
            default:
                break;
        }
        [webView setEventId:self.eventId];
        [self.navigationController pushFadeViewController:webView];*/
    }else{
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"Events"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectEventFirst"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"], nil];
        [al show];
    }
    
}


-  (NSInteger)tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return [ApplicationDelegate.appEventArray count];
}

-(UITableViewCell *)tableView:(UITableView *)
tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifer = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifer];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:MyIdentifer];
    }
    
    if ([checkedCell isEqual:indexPath])
        
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    Events *event=[[ApplicationDelegate appEventArray] objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
    [cell.textLabel setText:event.name];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    checkedCell = indexPath;
    [tableView reloadData];
    Events *event=[[ApplicationDelegate appEventArray] objectAtIndex:indexPath.row];
    [self setEventId:event.event_id];
    NSLog(@"cell text is%@ and id is %@",cellText,eventId);
    
}



- (void)viewDidUnload {
    [self setHomeLabel:nil];
    [self setEngContainerView:nil];
    [self setArabContainerView:nil];
    [self setArabEventBtn:nil];
    [self setArabExhbtBtn:nil];
    [self setImgDet1:nil];
    [self setImgDet2:nil];
    [super viewDidUnload];
}
@end
