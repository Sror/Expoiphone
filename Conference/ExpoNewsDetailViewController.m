//
//  ExpoNewsDetailViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 01/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoNewsDetailViewController.h"
#import "ConfMainViewController.h"

@interface ExpoNewsDetailViewController ()

@end

@implementation ExpoNewsDetailViewController

@synthesize newsDetail,fromCommonView,commonDic,imageArray,titleHeaderString,networkGallery;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
        
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.newsTitleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.newsDetailTxtView setFont:[UIFont fontWithName:@"Eagle-Light" size:12.0]];
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    NSString *iconUrl;
    
    if (fromCommonView) {
        
        [self.imageArray removeAllObjects];
        [self.navigationItem setTitleView:[ApplicationDelegate setTitle:titleHeaderString]];
        
        
        if ([titleHeaderString isEqualToString:@"Video-Gallery"]){
            
            [self.playBtn setEnabled:YES];
            
        }
        
        [self.newsTitleLabel setText:[commonDic objectForKey:@"title"]];
        [self.newsDetailTxtView setText:[commonDic objectForKey:@"description"]];
        
        [self.imageArray addObjectsFromArray:[commonDic objectForKey:@"gallery"]];
        
        if ([titleHeaderString isEqualToString:@"Video-Gallery"]){
            
            iconUrl=[commonDic objectForKey:@"thum_image"];
        }
        else if ([titleHeaderString isEqualToString:@"Press-Release"]){
        
        iconUrl=[commonDic objectForKey:@"thumb_image"];
        }else{
        iconUrl=[commonDic objectForKey:@"image"];
        }
        
        self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
            
            
            if([iconUrl isEqualToString:[url absoluteString]]) {
                
                [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                    self.newsImageView.image = fetchedImage;
                } completion:nil];
            }
            
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            
        }];
        
        if (self.imageArray.count>0) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"Gallery" forState:UIControlStateNormal];
            [button.layer setCornerRadius:4.0f];
            [button.layer setMasksToBounds:YES];
            [button.layer setBorderWidth:1.0f];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button.layer setBorderColor: [[UIColor blackColor] CGColor]];
            button.frame=CGRectMake(0.0, 100.0, 60.0, 30.0);
            [button addTarget:self action:@selector(galleryAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem* gallItem = [[UIBarButtonItem alloc] initWithCustomView:button];

            UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            fixed1.width = 40.0f;
            
            [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:fixed1,gallItem, nil]];
        }
    }

    else{
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"News Details"]];

    [self.newsTitleLabel setText:[newsDetail news_title]];
    [self.newsDetailTxtView setText:[newsDetail news_description]];
    
    
    
    NSString *iconUrl=newsDetail.news_image;
    
    self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        
        
        if([iconUrl isEqualToString:[url absoluteString]]) {
            
            [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                self.newsImageView.image = fetchedImage;
            } completion:nil];
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    }
    
}

-(void)galleryAction{
    
    networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    [self.navigationController pushFadeViewController:networkGallery];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnAction:(id)sender {
    
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];
    //[self.navigationController fadePopViewController];
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

/*- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    caption = [[imagesList objectAtIndex:index]valueForKey:@"title"];
	return caption;
}*/


- (void)viewDidUnload {
    [self setPlayBtn:nil];
    [self setHomeLabel:nil];
    [super viewDidUnload];
}


-(BOOL) validateYouTubeUrl: (NSString *) youTubeUrl
{
    
    // NSString *urlRegEx = @"http:\/\/(?:www\.)?youtube.com\/watch\?(?=.*v=\w+)(?:+)?$";
    
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    NSLog(@"O/P is %i",[urlTest evaluateWithObject:youTubeUrl]);
    return [urlTest evaluateWithObject:youTubeUrl];
}

- (IBAction)playBtnAction:(id)sender {
    
   /* NSLog(@"you tube play");
    
    NSString *selectedVideo =[commonDic objectForKey:@"youtube_link"]
    
    NSLog(@" selecte video >>> %@",selectedVideo);
    
    
   // [commonDic objectForKey:@"youtube_link"] 
    
   // NSString *videoID;
    
    
    // youtube.youtubeUrl = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=OUz-5YjXFeg"];
    
    
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
        
        NSArray *videoURLSplit = [selectedVideo componentsSeparatedByString:@"watch?v="];
        
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
        
        
    }*/
    

    
}


@end
