//
//  ExpoFavoritesViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoFavoritesViewController.h"
#import "EventsCell.h"
#import "EventsDetailViewController.h"

@interface ExpoFavoritesViewController ()

@end

@implementation ExpoFavoritesViewController
@synthesize favEventsArray,favTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        favEventsArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Favourites"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES animated:NO];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Edit" forState:UIControlStateNormal];
    [button.layer setCornerRadius:4.0f];
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1.0f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setBorderColor: [[UIColor blackColor] CGColor]];
    button.frame=CGRectMake(0.0, 100.0, 60.0, 30.0);
    [button addTarget:self action:@selector(EditTable:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* deleteItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    if ([[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"favList.plist"].count ==0) {
        //[self.HUD hide:YES];
        [self.navigationItem setRightBarButtonItem:nil];
    }else{
        
        UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixed1.width = 40.0f;
        
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:fixed1,deleteItem, nil]];
      //  [self.navigationItem setRightBarButtonItem:deleteItem];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.favTableView setHidden:YES];
    if (ApplicationDelegate.appFavEventArray.count == 0) {
        
        if ([[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"favList.plist"].count ==0) {
            
            UIAlertView *aert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Favorites Found. Please mark some events as favorites" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aert show];
        }else{
            
            [ApplicationDelegate.HUD show:YES];
            [self.navigationController.navigationBar setUserInteractionEnabled:NO];
            
            [ApplicationDelegate.appEngine favList:@"" onCompletion:^(NSMutableArray *favEventArray) {
                for (NSMutableDictionary *dic in favEventArray) {
                    [favEventsArray addObject:[[ConferenceHelper SharedHelper] getEventsObjectFromDictionary:dic] ];
                }
                NSLog(@"Fav Evnt array is %d",favEventsArray.count);
                [ApplicationDelegate.appFavEventArray removeAllObjects];
                [ApplicationDelegate.appFavEventArray addObjectsFromArray:favEventsArray];
                [ApplicationDelegate.HUD hide:YES];
                [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                [self.favTableView setHidden:NO];
                [self.favTableView reloadData];
            } onError:^(NSError *error) {
                [ApplicationDelegate.HUD hide:YES];
                [self.navigationController.navigationBar setUserInteractionEnabled:YES];
                [UIAlertView showWithError:error];
            }];
           }
    }else{
        [favEventsArray removeAllObjects];
        [favEventsArray addObjectsFromArray:ApplicationDelegate.appFavEventArray];
        [self.favTableView setHidden:NO];
        [self.favTableView reloadData];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [favEventsArray count];
    
    
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
                break;
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Events *event=[favEventsArray objectAtIndex:indexPath.row];
    NSLog(@"event is %@",event.name);
    //[cell.textLabel setFont:[UIFont fontWithName:@"PlutoLight" size:16.0]];
    [cell setPropertyToCell:event];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    EventsDetailViewController *listDetail = [[EventsDetailViewController alloc]initWithNibName:@"EventsDetailViewController" bundle:nil];
    listDetail.eventDetail = [favEventsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:listDetail animated:YES];
    
    
}


#pragma mark Row reordering
// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
	  toIndexPath:(NSIndexPath *)toIndexPath
{
	NSArray *item = [favEventsArray objectAtIndex:fromIndexPath.row] ;
	[favEventsArray removeObject:item];
	[favEventsArray insertObject:item atIndex:toIndexPath.row];
	
}


// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
        [favEventsArray removeObjectAtIndex:indexPath.row];
		[self.favTableView reloadData];
        
        NSMutableArray *carData=[[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"favList.plist"];
        
        
        
        [carData removeAllObjects];
        
        
        for (int i=0; i<[favEventsArray count]; i++) {
            
            Events *ev=[favEventsArray objectAtIndex:i];
            
            [carData addObject:ev.event_id];
        }
        
        [[ConferenceHelper SharedHelper] WriteArrayTothePlistFile:carData toFile:@"favList.plist"];
        
        if (favEventsArray.count == 0) {
            NSLog(@"00000");
            [self.favTableView setHidden:YES];
            [self.navigationItem setRightBarButtonItems:nil];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
    // Determine the editing style based on whether the cell is a placeholder for adding content or already
    // existing content. Existing content can be deleted.
    if (self.editing && indexPath.row == ([favEventsArray count]))
	{
		return UITableViewCellEditingStyleInsert;
	} else
	{
		return UITableViewCellEditingStyleDelete;
	}
    return UITableViewCellEditingStyleNone;
}

- (IBAction) EditTable:(id)sender
{
	if(self.editing)
	{
		[super setEditing:NO animated:NO];
		[self.favTableView setEditing:NO animated:NO];
		[ self.favTableView reloadData];
        UIButton *buton=(UIButton *)sender;
        [buton setTitle:@"Edit" forState:UIButtonTypeCustom];
        [buton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
	}
	else
	{
		[super setEditing:YES animated:YES];
		[self.favTableView setEditing:YES animated:YES];
		[self.favTableView reloadData];
        UIButton *buton=(UIButton *)sender;
        [buton setTitle:@"Done" forState:UIButtonTypeCustom];
        [buton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[self.navigationItem.rightBarButtonItem setTitle:@"Done"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
	}
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *cfMainView= [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:cfMainView];
    
}
@end
