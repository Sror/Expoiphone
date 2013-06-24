//
//  MapViewController.h
//  Map
//
//  http://www.maybelost.com
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ConferenceAppDelegate.h"

@interface MapViewControllerr : UIViewController {

	MKMapView *mapView;

}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property(strong,nonatomic)NSString *lat;
@property(strong,nonatomic)NSString *lon;
@property(strong,nonatomic)NSString *mtitle;


@end

