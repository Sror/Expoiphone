//
//  ConfMainViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 15/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConfMainViewController.h"

@interface ConfMainViewController ()

@end

@implementation ConfMainViewController

@synthesize scrollView;
@synthesize latestNewsTableView,latestNewsList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

            }
    return self;
}

/*-(UIButton *)customButton{
    
    UIButton *customBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [customBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [customBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    return backBtn;
}*/



-(void)setUpTabBar{
    
    UIButton *abtBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [abtBtn addTarget:self action:@selector(btnAbtTouched) forControlEvents:UIControlEventTouchUpInside];
    [abtBtn setImage:[UIImage imageNamed:@"aboutus-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnAbt = [[UIBarButtonItem alloc] initWithCustomView:abtBtn];
    
    UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed1.width = 20.0f;
    
    
    
    UIButton *eventsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [eventsBtn addTarget:self action:@selector(btnEventsTouched) forControlEvents:UIControlEventTouchUpInside];
    [eventsBtn setImage:[UIImage imageNamed:@"events-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnEvents = [[UIBarButtonItem alloc] initWithCustomView:eventsBtn];
    
   /* UIBarButtonItem *fixed2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed2.width = 20.0f;*/
    
    UIButton *favBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [favBtn addTarget:self action:@selector(btnFavTouched) forControlEvents:UIControlEventTouchUpInside];
    [favBtn setImage:[UIImage imageNamed:@"fav-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnFav = [[UIBarButtonItem alloc] initWithCustomView:favBtn];
    
   /* UIBarButtonItem *fixed3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed3.width = 20.0f;*/
    
    UIButton *contactBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [contactBtn addTarget:self action:@selector(btnContactTouched) forControlEvents:UIControlEventTouchUpInside];
    [contactBtn setImage:[UIImage imageNamed:@"call-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnContact = [[UIBarButtonItem alloc] initWithCustomView:contactBtn];
    
   /* UIBarButtonItem *fixed4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed4.width = 20.0f;*/
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [moreBtn addTarget:self action:@selector(btnMoreTouched) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:[UIImage imageNamed:@"list-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnMore = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    
    self.toolbarItems = [NSArray arrayWithObjects:btnAbt,fixed1, btnEvents,fixed1, btnFav,fixed1, btnContact,fixed1,btnMore, nil];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar_bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
  //  self.navigationController.navigationBar hid
    self.navigationItem.hidesBackButton = YES;
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Current Event"]];
    
    [self.navigationController.navigationBar setHidden:NO];
    //[self.navigationController.navigationBar setHidden:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
    [self setUpTabBar];
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"add1.png",@"add1.png",@"add1.png",@"add1.png", nil];
    
    NSInteger viewcount= 4; // Setting count for scrollview elements..
    
    
    pageControlBeingUsed = NO;
    
    for (int i = 0; i <viewcount; i++)
    {
        CGFloat y = i * scrollView.frame.size.width;
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(y, 0,scrollView.frame.size.width, scrollView.frame.size.height)];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20,contentView.frame.size.width-80, contentView.frame.size.height - 40)];
        imgView.backgroundColor = [UIColor clearColor];
        contentView.backgroundColor = [UIColor clearColor];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[arr objectAtIndex:i]]];
        [contentView addSubview:imgView];
        
        
        UIButton *myBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [myBtn setFrame:CGRectMake(40, 20,contentView.frame.size.width-80, contentView.frame.size.height - 40)];
        myBtn.tag = i;
        [myBtn setBackgroundColor:[UIColor clearColor]];
        [myBtn addTarget:self action:@selector(butonaction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:myBtn];
        
        
        [scrollView addSubview:contentView];
        
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width *viewcount, scrollView.frame.size.height);
    self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = viewcount;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
    
   // [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar_bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    //[ApplicationDelegate.HUD show:YES];
    
    [ApplicationDelegate.appEngine currentEventList:@"" onCompletion:^(NSMutableArray *CurrentEventArray) {
        for (NSMutableDictionary *dic in CurrentEventArray) {
            NSLog(@"the CurrentEventArray dic=%@",dic);
        }
        [self getAllNewsListFromServer];
        
    } onError:^(NSError *error) {
        [ApplicationDelegate.HUD hide:YES];
        [UIAlertView showWithError:error];
    }];
    
//    [self getAllNewsListFromServer];
    
   
    
}

-(void)getAllNewsListFromServer{
    [ApplicationDelegate .appEngine newsList:@"" onCompletion:^(NSMutableDictionary *newsListDIc) {
        
        [ApplicationDelegate.HUD hide:YES];
        //for (NSMutableDictionary *dic in new) {
            NSLog(@"the newsListDIc = %@",newsListDIc);
        //}
    } onError:^(NSError *error) {
        [ApplicationDelegate.HUD hide:YES];
        [UIAlertView showWithError:error];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrolllView
{
    if (scrolllView == self.scrollView)
    {
        offset = [scrolllView contentOffset];
        [self setContentOffset:offset animated:YES];
    }
    if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.scrollView.frame.size.width;
		int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
	}
    
    /*if (scrollView == self.label_scroll)
     {
     offset = [label_scroll contentOffset];
     [self setContentOffset:offset animated:YES];
     }*/
}
- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
{
    scrollView.contentOffset = offset;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [latestNewsList count];
    
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
    static NSString *CellIdentifier = @"EventsCell";
    EventsCell *cell = (EventsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        for(id currentObject in nibs)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (EventsCell *)currentObject;
                /* CALayer * l = [cell.buildingBgImgView layer];
                 [l setMasksToBounds:YES];
                 [l setCornerRadius:8.0];*/
                break;
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   /* Events *event=[eventsList objectAtIndex:indexPath.row];
    
    //   NSLog(@"Nearby aray in list is %@", [prop.NearBy description]);
    [cell.textLabel setFont:[UIFont fontWithName:@"PlutoLight" size:16.0]];
    [cell setPropertyToCell:event];*/
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
   /* EventsDetailViewController *listDetail = [[EventsDetailViewController alloc]initWithNibName:@"EventsDetailViewController" bundle:nil];
    listDetail.eventDetail = [eventsList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:listDetail animated:YES];*/
    
    
}










-(void)butonaction:(UIButton *)sender{
    
    NSLog( @" %i button clicked", sender.tag);
}






- (void)btnAbtTouched
{
    ExpoAboutViewController *abtUsVC = [[ExpoAboutViewController alloc]initWithNibName:@"ExpoAboutViewController" bundle:nil];
    [self.navigationController pushFadeViewController:abtUsVC];
}
- (void)btnEventsTouched
{
    ExpoEventsViewController *eventsVC = [[ExpoEventsViewController alloc]initWithNibName:@"ExpoEventsViewController" bundle:nil];
    [self.navigationController pushFadeViewController:eventsVC];
}
- (void)btnFavTouched
{
    ExpoFavoritesViewController *favVC = [[ExpoFavoritesViewController alloc]initWithNibName:@"ExpoFavoritesViewController" bundle:nil];
    [self.navigationController pushFadeViewController:favVC];

}
- (void)btnContactTouched
{
    ExpoContactsViewController *contactVC = [[ExpoContactsViewController alloc]initWithNibName:@"ExpoContactsViewController" bundle:nil];
    [self.navigationController pushFadeViewController:contactVC];
}
- (void)btnMoreTouched
{
    ExpoMoreViewController *moreVC = [[ExpoMoreViewController alloc]initWithNibName:@"ExpoMoreViewController" bundle:nil];
    [self.navigationController pushFadeViewController:moreVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
