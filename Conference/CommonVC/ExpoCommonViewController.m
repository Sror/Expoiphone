//
//  ExpoCommonViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 06/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoCommonViewController.h"
#import "NewsCell.h"
#import "ExpoNewsDetailViewController.h"
#import "ConfMainViewController.h"

@interface ExpoCommonViewController ()

@end

@implementation ExpoCommonViewController
@synthesize titleHeaderString,listArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        listArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:titleHeaderString]];
    
    [self.listTableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [latestNewsList count];
    
    return [listArray count];
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
    
    NSMutableDictionary *dic = [listArray objectAtIndex:indexPath.row];
    
    [cell setDetailsToCell:dic];
    
   /* News *new = [latestNewsList objectAtIndex:indexPath.row];
    [cell setNewsListToCell:new];*/
    /* Events *event=[eventsList objectAtIndex:indexPath.row];
     
     //   NSLog(@"Nearby aray in list is %@", [prop.NearBy description]);
     [cell.textLabel setFont:[UIFont fontWithName:@"PlutoLight" size:16.0]];
     [cell setPropertyToCell:event];*/
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ExpoNewsDetailViewController *listDetail = [[ExpoNewsDetailViewController alloc]initWithNibName:@"ExpoNewsDetailViewController" bundle:nil];
    listDetail.commonDic = [listArray objectAtIndex:indexPath.row];
    [listDetail setFromCommonView:YES];
    [self.navigationController pushFadeViewController:listDetail];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setListTableView:nil];
    [self setHomeLabel:nil];
    [super viewDidUnload];
}
- (IBAction)homBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];
}
@end
