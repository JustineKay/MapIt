
//
//  ViewController.m
//  MapIt
//
//  Created by Justine Gartner on 9/27/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "ViewController.h"
#import "FourSquareAPIManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) NSMutableArray *searchResults;

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTextField.delegate = self;
    
    //start with map centered at the following coordinates
    //with a span from the center point
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(40.7, -74);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.8, 0.8);
    
    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    };
    
    //[self.locationManager startUpdatingLocation];
    
}

-(void)updateMap{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (NSDictionary *venue in self.searchResults) {
        [self addMapAnnotationForVenue:venue];
    }
}

-(void)addMapAnnotationForVenue: (NSDictionary *)venue{
    
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    
    double lat = [venue[@"location"][@"lat"]doubleValue];
    double lng = [venue[@"location"][@"lng"]doubleValue];
    
    CLLocationCoordinate2D latLng = CLLocationCoordinate2DMake(lat, lng);
    
    mapPin.coordinate = latLng;
    mapPin.title = venue[@"name"];
    mapPin.subtitle = venue[@"location"][@"address"];
    
    [self.mapView addAnnotation:mapPin];
}

-(void)performSearch{
    
     //NSLog(@"%s", __PRETTY_FUNCTION__);
    
    MKUserLocation *userLocation = self.mapView.userLocation;
    
    [FourSquareAPIManager searchFourSquarePlacesForTerm:self.searchTextField.text
                                               location:userLocation.coordinate
                                      completionHandler:^(id response, NSError *error) {
                                          
                                          self.searchResults = response[@"response"][@"venues"];
                                          [self updateMap];
        
    }];
    
    
}


- (IBAction)searchButtonTapped:(UIButton *)sender {
    
    [self performSearch];
    [self.view endEditing:YES];
}

#pragma mark - textfield delegate protocols

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self performSearch];
    [self.view endEditing:YES];
    
    return YES;
}

@end
