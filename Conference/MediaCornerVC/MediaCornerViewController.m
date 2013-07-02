//
//  MediaCornerViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 17/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "MediaCornerViewController.h"

@interface MediaCornerViewController ()

@end

@implementation MediaCornerViewController

@synthesize networkGallery,imagesList,videosList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imagesList = [[NSMutableArray alloc]init];
        videosList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Media Corner"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];

    
    self.mcScrollView.contentSize = CGSizeMake(320, 568);
    
    [self.videoGalleryView setFrame:CGRectMake(22, 25, self.videoGalleryView.frame.size.width, self.videoGalleryView.frame.size.height)];
    
    [self.videoGalleryBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.imgGalleryBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];
    [self.pressBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:19.0]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)videoGalleryCloseBtnAction:(id)sender {
    
    
    [self.view removeSubview:self.videoGalleryView];
}

- (IBAction)playVideoBtnAction:(id)sender {
    
    
    
}

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *confView = [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:confView];
    
    
}

- (IBAction)pressReleaseBtnAction:(id)sender {
    
    ConfWebViewController *confWebView = [[ConfWebViewController alloc]initWithNibName:@"ConfWebViewController" bundle:nil];
    [confWebView setSelectedIndex:[sender tag]];
    [self.navigationController pushFadeViewController:confWebView];

}


- (IBAction)videoGalleryBtnAction:(id)sender {
    
    [ApplicationDelegate.HUD show:YES];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
   [ApplicationDelegate.appEngine videoGalleryList:@"" onCompletion:^(NSMutableArray *videoGaleryArray) {
       
       [ApplicationDelegate.HUD hide:YES];
       [self.navigationController.navigationBar setUserInteractionEnabled:YES];
       NSLog(@"videoGaleryArray.count is %i",videoGaleryArray.count);
       [videosList removeAllObjects];
       [videosList addObjectsFromArray:videoGaleryArray];
       [self.view addSubviewWithBounce:self.videoGalleryView];

   } onError:^(NSError *error) {
       [ApplicationDelegate.HUD hide:YES];
       [self.navigationController.navigationBar setUserInteractionEnabled:YES];
       [UIAlertView showWithError:error];
   }];
    
    
}

- (IBAction)imageGalleryBtnAction:(id)sender {
    
    [ApplicationDelegate.HUD show:YES];
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    [ApplicationDelegate.appEngine imageGalleryList:@"" onCompletion:^(NSMutableArray *imageGaleryArray) {
        
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        
        NSLog(@"imageGaleryArray.count is %i",imageGaleryArray.count);
         [imagesList removeAllObjects];
         [imagesList addObjectsFromArray:imageGaleryArray];
        /*[ApplicationDelegate.appImageGalleryArray removeAllObjects];
        [ApplicationDelegate.appImageGalleryArray addObjectsFromArray:imageGaleryArray];*/
        
        if (imagesList.count >0) {
            networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
            [self.navigationController pushViewController:networkGallery animated:YES];
        }else{
            UIAlertView *al =[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No image gallery available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [al show];
        }
        
        
    } onError:^(NSError *error) {
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        [UIAlertView showWithError:error];
    }];
  
}

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{

    return [imagesList count];

}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
        return FGalleryPhotoSourceTypeNetwork;
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    
    NSMutableDictionary *dic;
    dic = [imagesList objectAtIndex:index] ;
    return [dic valueForKey:@"image"];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    caption = [[imagesList objectAtIndex:index]valueForKey:@"title"];
	return caption;
}


#pragma mark - TableView Delegate Methods


-  (NSInteger)tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return [videosList count];
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
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    NSMutableDictionary *dic = [videosList objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[dic objectForKey:@"title"]];
   // Events *event=[[ApplicationDelegate appEventArray] objectAtIndex:indexPath.row];
    //[cell setText:event.name];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    checkedCell = indexPath;
    [tableView reloadData];
   /* Events *event=[[ApplicationDelegate appEventArray] objectAtIndex:indexPath.row];
    [self setEventId:event.event_id];
    NSLog(@"cell text is%@ and id is %@",cellText,eventId);*/
    
    NSMutableDictionary *dic = [videosList objectAtIndex:indexPath.row];
    
    NSLog(@"cell text is%@ and url  is %@",cellText,[dic objectForKey:@"youtube_link"]);
    
   // [cell.textLabel setText:[dic objectForKey:@"title"]];
    
}

@end
