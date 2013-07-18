//
//  ExpoEventsViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoEventsViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface ExpoEventsViewController ()

@end

@implementation ExpoEventsViewController

@synthesize eventsList,fromSearch;

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
    /*[self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Events"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];*/
    self.navigationItem.hidesBackButton = YES;
    
    eventsList = [[NSMutableArray alloc]init];
    
   // [self.searchBtn.titleLabel setText:@"Search"];
    [self.searchBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:12.0]];
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:YES animated:NO];
   // [self.navigationItem setRightBarButtonItem:nil];
    ApplicationDelegate.HUD.labelText = @"Loading";

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];
    
    [self getDataFromServer];
    
    
    NSLog(@"Count in end view is %d",eventsList.count);
    
    
}


-(void)getDataFromServer{
    
    [self.eventsListTableView setHidden:YES];
    [ApplicationDelegate.appEventArray removeAllObjects];
    [self.eventsList removeAllObjects];
    
    if ([ApplicationDelegate.appEventArray count]== 0) {
        
        
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
            [self.eventsListTableView reloadData];
            [self.eventsListTableView setHidden:NO];
            
        } onError:^(NSError *error) {
            [ApplicationDelegate.HUD hide:YES];
            [self.navigationController.navigationBar setUserInteractionEnabled:YES];
            [UIAlertView showWithError:error];
            
        }]; }
    else if (fromSearch){
        [eventsList removeAllObjects];
        [eventsList addObjectsFromArray:ApplicationDelegate.appSearchEventsArray];
        [self.eventsListTableView setHidden:NO];
        [self.eventsListTableView reloadData];
        
        
    }
    else{
        
        [eventsList removeAllObjects];
        [eventsList addObjectsFromArray:ApplicationDelegate.appEventArray];
        [self.eventsListTableView reloadData];
        
    }
}
-(void)updateUI{
    
    
    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"Events"]]];
    
    [self.searchBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"search"] forState:UIControlStateNormal];
    [self.view insertSubview:ApplicationDelegate.HUD aboveSubview:self.eventsListTableView];
    [self getDataFromServer];
}

-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventsList count];
    
    //return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"EventsCell";
    
    
    static NSString *CellIdentifier;
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:
            CellIdentifier = @"EventsCell";
            break;
        case LANG_ARABIC:
            CellIdentifier = @"EventsCell-Arab";
        default:
            break;
    }
    
    EventsCell *cell = (EventsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        for(id currentObject in nibs)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (EventsCell *)currentObject;
                break;
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Events *event=[eventsList objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"PlutoLight" size:16.0]];
    [cell setPropertyToCell:event];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    EventsDetailViewController *listDetail = [[EventsDetailViewController alloc]initWithNibName:@"EventsDetailViewController" bundle:nil];
    listDetail.eventDetail = [eventsList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:listDetail animated:YES];
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBtnAction:(id)sender {
    
    [self setFromSearch:YES];
    
    ConfEventSearchViewController *eveSearch = [[ConfEventSearchViewController alloc] initWithNibName:@"ConfEventSearchViewController" bundle:nil];
    [self.navigationController pushFadeViewController:eveSearch];
    
}
- (void)viewDidUnload {
    [self setSearchBtn:nil];
    [super viewDidUnload];
}
@end
