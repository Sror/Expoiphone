//
//  MapViewController.m
//  Map
//
//  http://www.maybelost.com
//

#import "MapViewControllerr.h"
#import "MapViewAnnotation.h"

@implementation MapViewControllerr

@synthesize mapView;
@synthesize lat,lon,mtitle;

// When the view loads
- (void)viewDidLoad
{
    
    /*UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25,44, 44)];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:backBtn]];
    [self.navigationItem setRightBarButtonItem:nil];
*/
  //  [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Location"]];
    CLLocationCoordinate2D location;
    //location.latitude = (double) 51.501468;
    //location.longitude = (double) -0.141596;
    
    self.navigationItem.hidesBackButton = YES;
    //
	location.latitude = [lat doubleValue];
	location.longitude =  [lon doubleValue];
	// Add the annotation to our map view
	MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:mtitle andCoordinate:location];
	[self.mapView addAnnotation:newAnnotation];
    
    
	}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // Set some coordinates for our position (Buckingham Palace!)
	
	//[newAnnotation release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];


}

-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}

-(void)updateUI{
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"locationmap"]]];
}
-(void)backBtnAction{
    [self.navigationController fadePopViewController];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
}

// When a map annotation point is added, zoom to it (1500 range)
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
	[mv setRegion:region animated:YES];
	[mv selectAnnotation:mp animated:YES];
}

// Received memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// If the view unloads, release the map view
- (void)viewDidUnload {
	[super viewDidUnload];
	//[mapView release];
	mapView = nil;
}

// Deallocations


@end
