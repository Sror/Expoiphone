//
//  ConfMainViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 15/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConfMainViewController.h"
#import "EventsDetailViewController.h"
#import "NewsCell.h"
#import "ExpoNewsDetailViewController.h"

@interface ConfMainViewController ()

@end

@implementation ConfMainViewController

@synthesize scrollView;
@synthesize latestNewsTableView,latestNewsList;
@synthesize currentEventArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        currentEventArr = [[NSMutableArray alloc]init];
        latestNewsList = [[NSMutableArray alloc]init];

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
    

    
   /* UIButton *abtBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [abtBtn addTarget:self action:@selector(btnAbtTouched) forControlEvents:UIControlEventTouchUpInside];
    [abtBtn setImage:[UIImage imageNamed:@"aboutus-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnAbt = [[UIBarButtonItem alloc] initWithCustomView:abtBtn];
    
    UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed1.width = 20.0f;
    
    
    
    UIButton *eventsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [eventsBtn addTarget:self action:@selector(btnEventsTouched) forControlEvents:UIControlEventTouchUpInside];
    [eventsBtn setImage:[UIImage imageNamed:@"events-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnEvents = [[UIBarButtonItem alloc] initWithCustomView:eventsBtn];*/
    
   /* UIBarButtonItem *fixed2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed2.width = 20.0f;*/
    
  /*  UIButton *favBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [favBtn addTarget:self action:@selector(btnFavTouched) forControlEvents:UIControlEventTouchUpInside];
    [favBtn setImage:[UIImage imageNamed:@"fav-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnFav = [[UIBarButtonItem alloc] initWithCustomView:favBtn];
    */
   /* UIBarButtonItem *fixed3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed3.width = 20.0f;*/
    
   /* UIButton *contactBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [contactBtn addTarget:self action:@selector(btnContactTouched) forControlEvents:UIControlEventTouchUpInside];
    [contactBtn setImage:[UIImage imageNamed:@"call-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnContact = [[UIBarButtonItem alloc] initWithCustomView:contactBtn];*/
    
   /* UIBarButtonItem *fixed4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixed4.width = 20.0f;*/
    
  /*  UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,35, 35)];
    [moreBtn addTarget:self action:@selector(btnMoreTouched) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:[UIImage imageNamed:@"list-tb.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnMore = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    
    self.toolbarItems = [NSArray arrayWithObjects:btnAbt,fixed1, btnEvents,fixed1, btnFav,fixed1, btnContact,fixed1,btnMore, nil];*/

}

-(void)refreshView:(NSNotification *) notification{
    
    NSLog(@"Notification");
        [ApplicationDelegate.appCurrentEventArray removeAllObjects];
    [ApplicationDelegate.appLatestNewsArray removeAllObjects];
    [self.scrollView setHidden:YES];
    [self.currentEventArr removeAllObjects];
    [self.latestNewsList removeAllObjects];
    [self.latestNewsTableView reloadData];
    //[self arrangeHorizontalScrollView];
    
    [self GetDataForTheView];
    [self updateUI];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.navigationItem.hidesBackButton = YES;

    [self.navigationItem setTitleView:[ApplicationDelegate setTitleForMainView]];
    
    [self.navigationController setToolbarHidden:YES animated:NO];

   
    UIView *newsLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 165, 320, 48)];
    [newsLabelView setBackgroundColor:[UIColor clearColor]];
    
      if (!titleView2) {
        titleView2 = [[UILabel alloc] initWithFrame:CGRectMake(47, 12, 280, 44)];
        titleView2.backgroundColor = [UIColor clearColor];
        titleView2.font = [UIFont fontWithName:@"Eagle-Bold" size:17.0];
    }
    
    [titleView2 setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"lnews"]];
   // titleView2.text = @"Latest News";
    titleView2.textColor = [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1];
    [titleView2 sizeToFit];
    
    [newsLabelView addSubview:titleView2];
    
    UIImageView *imgView2;
    if (!imgView2) {
        imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 10, 25, 25)];
        imgView2.backgroundColor = [UIColor clearColor];
    }
    [imgView2 setImage:[UIImage imageNamed:@"newstitle.png"]];
    [imgView2 setContentMode:UIViewContentModeScaleAspectFit];
    [newsLabelView addSubview:imgView2];
    
    UIImageView *sepImgView;
    
    if (!sepImgView) {
        sepImgView = [[UIImageView alloc] initWithFrame:CGRectMake(37,7,2,29)];
        sepImgView.backgroundColor = [UIColor clearColor];
    }
    [sepImgView setImage:[UIImage imageNamed:@"sep.png"]];
    [sepImgView setContentMode:UIViewContentModeScaleAspectFit];
    [newsLabelView addSubview:sepImgView];
    
    [self.view addSubview:newsLabelView];
    [self.navigationController.navigationBar setHidden:NO];
   // [self setUpTabBar];
    [self  updateUI];
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];
    
    [self applyFonts];
    
}

-(void)applyFonts{
    [self.latestNewsHeaderLabel setFont:[UIFont fontWithName:@"Eagle-Bold" size:17.0]];
    [self.aboutUsBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.eventsBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.favBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.callBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.moreBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
}

-(void)updateUI{
    
    [titleView2 setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"lnews"]];
    [self.navigationItem setTitleView:[ApplicationDelegate setTitleForMainView]];

    [self.aboutUsBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"aUs"] forState:UIControlStateNormal];
    [self.eventsBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"Events"] forState:UIControlStateNormal];
    [self.favBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"Favourites"] forState:UIControlStateNormal];
    [self.callBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cUs"] forState:UIControlStateNormal];
    [self.moreBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"more"] forState:UIControlStateNormal];

}


-(void)arrangeHorizontalScrollView{
    

    pageControlBeingUsed = NO;
    
    
    for (int i = 0; i <self.currentEventArr.count; i++)
    {
        CGFloat y = i * scrollView.frame.size.width;
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(y, 0,scrollView.frame.size.width, scrollView.frame.size.height)];
        contentView.backgroundColor = [UIColor clearColor];
        

        Events *event = [self.currentEventArr objectAtIndex:i];
        NSLog(@"dic is %@",event.event_id);
       
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 11,contentView.frame.size.width-40, contentView.frame.size.height - 23)];
        imgView.backgroundColor = [UIColor clearColor];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
     
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"events_bg.png"]];
        [contentView addSubview:imgView];
        
        
        UIImageView *imgViewborder = [[UIImageView alloc] initWithFrame:CGRectMake(40,39,80,58)];
        imgViewborder.backgroundColor = [UIColor clearColor];
       // [imgViewborder setContentMode:UIViewContentModeScaleAspectFit];
        
        
        imgViewborder.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_bg.png"]];
        [contentView addSubview:imgViewborder];
        
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(42,41,76,54)];
        //[imgView2 setContentMode:UIViewContentModeScaleAspectFit];
        
       //NSLog(@"url is %@",event.logo);
        
        NSString *iconUrl = event.logo;
        
        self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            
            
            if([iconUrl isEqualToString:[url absoluteString]]) {
                
                [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                    imgView2.image = fetchedImage;
                } completion:nil];
            }
            
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            
            
            
        }];

        [contentView addSubview:imgView2];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 32, 170, 25)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        //[titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [titleLabel setTextColor:[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setText:event.name];
        [titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
        [contentView addSubview:titleLabel];
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 49, 150, 15)];
        [dateLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:10.0]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor blackColor]];
        [dateLabel setText:[NSString stringWithFormat:@"%@-%@",[[ConferenceHelper SharedHelper] datefromString:event.start_date],[[ConferenceHelper SharedHelper] datefromString:event.end_date]]];
        [contentView addSubview:dateLabel];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 59, 150, 15)];
        [timeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [timeLabel setTextColor:[UIColor blackColor]];
        [timeLabel setText:[NSString stringWithFormat:@"%@-%@",event.start_time,event.end_time]];
        [contentView addSubview:timeLabel];
        
        UILabel *cateLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 65, 150, 30)];
        [cateLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:11.0]];
        [cateLabel setBackgroundColor:[UIColor clearColor]];
        [cateLabel setTextColor:[UIColor blackColor]];
        [cateLabel setText:event.industry_category];
        [cateLabel setNumberOfLines:0];
        [contentView addSubview:cateLabel];
        
        UILabel *locLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 77, 150, 30)];
        [locLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:11.0]];
        [locLabel setBackgroundColor:[UIColor clearColor]];
        [locLabel setTextColor:[UIColor blackColor]];
        [locLabel setText:event.location];
        [locLabel setNumberOfLines:0];
        [contentView addSubview:locLabel];
        
        UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(280,61,16,18)];
        [imgView3 setImage:[UIImage imageNamed:@"detdiscl-hom.png"]];
        [contentView addSubview:imgView3];
        
        
        UIButton *myBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [myBtn setFrame:CGRectMake(22, 11,imgView.frame.size.width, imgView.frame.size.height)];
        myBtn.tag = i;
        [myBtn setBackgroundColor:[UIColor clearColor]];
        [myBtn addTarget:self action:@selector(butonaction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:myBtn];
        
        
        [scrollView addSubview:contentView];
        
    }
//    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width *self.currentEventArr.count, scrollView.frame.size.height);
//    self.pageControl.currentPage = 0;
//	self.pageControl.numberOfPages = self.currentEventArr.count;
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width *self.currentEventArr.count, scrollView.frame.size.height);
    self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = self.currentEventArr.count;
    
 
}


-(void)GetDataForTheView{
    
    if (ApplicationDelegate.appCurrentEventArray.count ==0 || ApplicationDelegate.appLatestNewsArray.count ==0) {
        [ApplicationDelegate.HUD show:YES];
        //[self.navigationController.toolbar setUserInteractionEnabled:NO];
        
        [ApplicationDelegate.appEngine currentEventList:@"" onCompletion:^(NSMutableArray *CurrentEventArray) {
            
            [self.currentEventArr removeAllObjects];
            for (NSMutableDictionary *dic in CurrentEventArray) {
                [self.currentEventArr addObject:[[ConferenceHelper SharedHelper] getEventsObjectFromDictionary:dic]];
            }
            [ApplicationDelegate.appCurrentEventArray removeAllObjects];
            [ApplicationDelegate.appCurrentEventArray addObjectsFromArray:self.currentEventArr];
            [self arrangeHorizontalScrollView];
            [self getAllNewsListFromServer];
            
        } onError:^(NSError *error) {
            [ApplicationDelegate.HUD hide:YES];
            //[self.navigationController.toolbar setUserInteractionEnabled:YES];
            [UIAlertView showWithError:error];
        }];
        
    }else{
        
        [self.currentEventArr removeAllObjects];
        [self.currentEventArr addObjectsFromArray:ApplicationDelegate.appCurrentEventArray];
        [self arrangeHorizontalScrollView];
        
        [self.latestNewsList removeAllObjects];
        [self.latestNewsList addObjectsFromArray:ApplicationDelegate.appLatestNewsArray];
        [self.latestNewsTableView setHidden:NO];
        [self.latestNewsTableView reloadData];
        
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self.latestNewsTableView setHidden:YES];

    [self updateUI];
    [self GetDataForTheView];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   //  
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
    
}


-(void)getAllNewsListFromServer{
    [ApplicationDelegate .appEngine newsList:@"" onCompletion:^(NSMutableArray *newsListArray) {
        
        [ApplicationDelegate.HUD hide:YES];
        //[self.navigationController.toolbar setUserInteractionEnabled:YES];
        
        [[self latestNewsList]removeAllObjects];
    for (NSMutableDictionary *dic in newsListArray) {
            //NSLog(@"the newsListDIc = %@",dic);
        
        [self.latestNewsList addObject:[[ConferenceHelper SharedHelper] getNewsObjectFromDictionary:dic]];
        }
        
       // NSLog(@"Current event array count is %d",latestNewsList.count);
        [ApplicationDelegate.appLatestNewsArray removeAllObjects];
        [ApplicationDelegate.appLatestNewsArray addObjectsFromArray:self.latestNewsList];
        [self.latestNewsTableView setHidden:NO];
        [self.scrollView setHidden:NO];
        [self.latestNewsTableView reloadData];

    } onError:^(NSError *error) {
        [ApplicationDelegate.HUD hide:YES];
       // [self.navigationController.toolbar setUserInteractionEnabled:YES];
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
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    NewsCell *cell = (NewsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        for(id currentObject in nibs)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (NewsCell *)currentObject;

                break;
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    News *new = [latestNewsList objectAtIndex:indexPath.row];
    [cell setNewsListToCell:new];
   /* Events *event=[eventsList objectAtIndex:indexPath.row];
    
    //   NSLog(@"Nearby aray in list is %@", [prop.NearBy description]);
    [cell.textLabel setFont:[UIFont fontWithName:@"PlutoLight" size:16.0]];
    [cell setPropertyToCell:event];*/
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ExpoNewsDetailViewController *listDetail = [[ExpoNewsDetailViewController alloc]initWithNibName:@"ExpoNewsDetailViewController" bundle:nil];
    listDetail.newsDetail = [latestNewsList objectAtIndex:indexPath.row];
    [self.navigationController pushFadeViewController:listDetail];
    
}










-(void)butonaction:(UIButton *)sender{
    
    EventsDetailViewController *listDetail = [[EventsDetailViewController alloc]initWithNibName:@"EventsDetailViewController" bundle:nil];
    listDetail.eventDetail = [currentEventArr objectAtIndex:sender.tag];
    [self.navigationController pushViewController:listDetail animated:YES];
    
}




- (IBAction)btnAbtTouched:(id)sender
{
    ExpoAboutViewController *abtUsVC = [[ExpoAboutViewController alloc]initWithNibName:@"ExpoAboutViewController" bundle:nil];
    [ApplicationDelegate.navController pushFadeViewController:abtUsVC];
}
- (IBAction)btnEventsTouched:(id)sender
{
    ExpoEventsViewController *eventsVC = [[ExpoEventsViewController alloc]initWithNibName:@"ExpoEventsViewController" bundle:nil];
    [self.navigationController pushFadeViewController:eventsVC];
}
- (IBAction)btnFavTouched:(id)sender
{
    ExpoFavoritesViewController *favVC = [[ExpoFavoritesViewController alloc]initWithNibName:@"ExpoFavoritesViewController" bundle:nil];
    [self.navigationController pushFadeViewController:favVC];

}
- (IBAction)btnContactTouched:(id)sender
{
    ExpoContactsViewController *contactVC = [[ExpoContactsViewController alloc]initWithNibName:@"ExpoContactsViewController" bundle:nil];
    [self.navigationController pushFadeViewController:contactVC];
}
- (IBAction)btnMoreTouched:(id)sender
{
    ExpoMoreViewController *moreVC = [[ExpoMoreViewController alloc]initWithNibName:@"ExpoMoreViewController" bundle:nil];
    [self.navigationController pushFadeViewController:moreVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setToolBarView:nil];
    [self setAboutUsBtn:nil];
    [self setEventsBtn:nil];
    [self setFavBtn:nil];
    [self setCallBtn:nil];
    [self setMoreBtn:nil];
    [super viewDidUnload];
}
@end
