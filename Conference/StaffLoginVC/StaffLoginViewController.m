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
@synthesize eventId,eventsList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        eventsList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.hidesBackButton = YES;
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"loading"]];

    
    
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

-(void)logoutAction{
    [self.navigationController fadePopViewController];
}
- (void)dragBtnAction:(UIPanGestureRecognizer *)rec
{
    [ApplicationDelegate dragBtnAction:rec];
    
}


- (UIView *)setHeaderTitle:(NSString *)title
{
    
    UIView *containerView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [containerView setTag:143];
    [containerView setBackgroundColor:[UIColor clearColor]];
    
    /* UIButton *backBtn = [[UIButton alloc]init];
     [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
     [backBtn setBackgroundColor:[UIColor clearColor]];
     [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];*/
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setBackgroundColor:[UIColor clearColor]];
    [bt setTitle:@"Logout" forState:UIControlStateNormal];
    [bt.layer setCornerRadius:4.0f];
    [bt.layer setMasksToBounds:YES];
    [bt.layer setBorderWidth:1.0f];
    [bt setTitleColor:[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1]forState:UIControlStateNormal];
    [bt.layer setBorderColor: [[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
    [bt addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *dragBtn;
    dragBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dragBtn.backgroundColor = [UIColor clearColor];
    UIPanGestureRecognizer *panBtn= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBtnAction:)];
    [dragBtn addGestureRecognizer:panBtn];
    
    UILabel *titleView;
    titleView = [[UILabel alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Eagle-Bold" size:17.0];
    titleView.text = title;
    titleView.textAlignment=NSTextAlignmentCenter;
    titleView.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    [titleView setTextAlignment:NSTextAlignmentCenter];
    
    UIImageView *ribImgView;
    ribImgView = [[UIImageView alloc] init];
    ribImgView.backgroundColor = [UIColor clearColor];
    [ribImgView setImage:[UIImage imageNamed:@"ribbon.png"]];
    [ribImgView setContentMode:UIViewContentModeScaleAspectFit];
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:{
            [titleView setFrame:CGRectMake(44, 0, 200, 44)];
            [dragBtn setFrame:CGRectMake(271.8, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(271.8,0,27,44)];
            //[bt setFrame:CGRectMake(0, 0,44, 44)];
            [bt setFrame:CGRectMake(10, 7, 60, 30)];
        }
            break;
        case LANG_ARABIC:{
            
            [titleView setFrame:CGRectMake(44, 0, 200, 44)];
            [dragBtn setFrame:CGRectMake(14, 0, 40, 44)];
            [ribImgView setFrame:CGRectMake(14,0,27,44)];
            //[bt setFrame:CGRectMake(260, 0,44, 44)];
            [bt setFrame:CGRectMake(240,6,60, 30)];
        }
            break;
        default:
            break;
    }
    [containerView addSubview:titleView];
    [containerView addSubview:bt];
    [containerView addSubview:dragBtn];
    [containerView addSubview:ribImgView];
    return containerView;
}

-(void)updateUI{
    

    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    [ApplicationDelegate.HUD setLabelText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"loading"]];
    [ApplicationDelegate.appEventArray removeAllObjects];
    
    [self.navigationItem setTitleView:[self setHeaderTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"signIn"]]];
    //[self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"signIn"]]];
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


-(void)getEventData{
    
    
    [self.view addSubview:ApplicationDelegate.HUD];
    
    [self.eventsList removeAllObjects];
    [ApplicationDelegate.HUD show:YES];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    [ApplicationDelegate.appEngine eventsList:@"" onCompletion:^(NSMutableArray *eventArray) {
        
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        
        for (NSMutableDictionary *dic in eventArray) {
            
            [eventsList addObject:[[ConferenceHelper SharedHelper] getEventsObjectFromDictionary:dic]];
            
        }
        [ApplicationDelegate.appEventArray removeAllObjects];
        [ApplicationDelegate.appEventArray addObjectsFromArray:eventsList];
        [self.eventTableView reloadData];
        [self.eventTableView setHidden:NO];
         [self.view addSubviewWithBounce:self.bounceView];
       
        
        
    } onError:^(NSError *error) {
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        [UIAlertView showWithError:error];
        
    }];
}

- (IBAction)eventVisitorBtnAction:(id)sender {
    
    [self setEventId:@""];
    checkedCell = nil;
    [self setBtnType:1];
    if (ApplicationDelegate.appEventArray.count!=0) {
        [self.view addSubviewWithBounce:self.bounceView];
    }else{
        
        [self getEventData];
        
        /*UIAlertView *al = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noEventsFound"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"], nil];
        [al show];  */
    
    
    }
    

}

- (IBAction)exhibitorBtnAction:(id)sender {
 
    [self setEventId:@""];
    checkedCell = nil;
    [self setBtnType:2];
    if (ApplicationDelegate.appEventArray.count!=0) {
        [self.view addSubviewWithBounce:self.bounceView];
    }else{
        [self getEventData];
       // [self.view addSubviewWithBounce:self.bounceView];
       /* UIAlertView *al = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sorry"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noEventsFound"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"], nil];
        [al show];*/
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
    
    if (self.eventId.length!=0) {
        
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
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"Events"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectEventFirst"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:nil, nil];
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
