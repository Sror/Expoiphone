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
#import "LBViewController.h"
@interface ExpoCommonViewController ()

@end

@implementation ExpoCommonViewController
@synthesize titleHeaderString,listArray,imageArray,networkGallery,selectedVideo,fromEventDetailView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        listArray = [[NSMutableArray alloc]init];
        imageArray = [[NSMutableArray alloc]init];
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
    
    [cell setDetailsToCell:dic withTitle:titleHeaderString withView:fromEventDetailView];

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([titleHeaderString isEqualToString:@"Video-Gallery"]){
        
         NSMutableDictionary * dic = [listArray objectAtIndex:indexPath.row];
        
        [self setSelectedVideo:[dic objectForKey:@"youtube_link"]];

        NSLog(@"slected video nis %@",selectedVideo);
        
        [self checkAndPlay];
        
           }
    else if ([titleHeaderString isEqualToString:@"Press-Release"]){
        
        ExpoNewsDetailViewController *listDetail = [[ExpoNewsDetailViewController alloc]initWithNibName:@"ExpoNewsDetailViewController" bundle:nil];
        listDetail.commonDic = [listArray objectAtIndex:indexPath.row];
        [listDetail setTitleHeaderString:titleHeaderString];
        [listDetail setFromCommonView:YES];
        [self.navigationController pushFadeViewController:listDetail];
        
        //iconUrl=[commonDic objectForKey:@"thumb_image"];
    }else{
        
        NSMutableDictionary * dic = [listArray objectAtIndex:indexPath.row];
        [self.imageArray removeAllObjects];
        [self.imageArray addObjectsFromArray:[dic objectForKey:@"gallery"]];
        
        networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
        [self.navigationController pushFadeViewController:networkGallery];

               
        
    }
    
    
}

-(BOOL) validateYouTubeUrl: (NSString *) youTubeUrl
{
    
    // NSString *urlRegEx = @"http:\/\/(?:www\.)?youtube.com\/watch\?(?=.*v=\w+)(?:+)?$";
    
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    NSLog(@"O/P is %i",[urlTest evaluateWithObject:youTubeUrl]);
    return [urlTest evaluateWithObject:youTubeUrl];
}



-(void)checkAndPlay{
    
    NSString *videoID;
    
    
    @try {
        if (selectedVideo.length==0) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        
        else if (![self validateYouTubeUrl:selectedVideo])
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            
            
            LBViewController* youtube1=[[LBViewController alloc]initWithNibName:@"LBViewController" bundle:nil];
            [youtube1 setYoutubeUrl:selectedVideo];
            [self presentModalViewController:youtube1 animated:YES];

            
        /*    NSArray *videoURLSplit = [selectedVideo componentsSeparatedByString:@"watch?v="];
            
            NSLog(@"Count is %d",videoURLSplit.count);
            if (videoURLSplit.count!=0) {
                
                @try {
                    videoID = [[videoURLSplit objectAtIndex:1] substringToIndex:11];
                    NSLog(@" videoID >>> %@",videoID);
                    [ApplicationDelegate.HUD show:YES];
                    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
                    [ApplicationDelegate.appEngine checkYoutubeLink:videoID onCompletion:^(NSMutableArray *youtube) {
                        NSLog(@"yioutube array is %@", [youtube description]);
                        [ApplicationDelegate.HUD hide:YES];
                        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                        LBViewController* youtube1=[[LBViewController alloc]initWithNibName:@"LBViewController" bundle:nil];
                        [youtube1 setYoutubeUrl:selectedVideo];
                        [self presentModalViewController:youtube1 animated:YES];
                        
                    } onError:^(NSError *error) {
                        [ApplicationDelegate.HUD hide:YES];
                        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                        [UIAlertView showWithError:error];
                    }];
                    
                }
                @catch (NSException *exception) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                }
                @finally {
                    
                }
                
            }else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            */
            
        }

    }
    @catch (NSException *exception) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Video Unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    @finally {
        
    }
    
    
    
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


#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    
    return [imageArray count];
    
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
    return FGalleryPhotoSourceTypeNetwork;
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    
    NSMutableDictionary *dic;
    dic = [imageArray objectAtIndex:index] ;
    return [dic valueForKey:@"image"];
}
@end
