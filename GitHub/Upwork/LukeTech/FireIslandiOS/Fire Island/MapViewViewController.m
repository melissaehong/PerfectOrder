//
//  MapViewViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 18/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "MapViewViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewViewController ()

@property (nonatomic, strong) IBOutlet MKMapView* mapView1;

@end

@implementation MapViewViewController

- (IBAction)directionsClick:(id)sender{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&ll=%f,%f", self.location1.latitude, self.location1.longitude, self.location2.latitude, self.location2.longitude]]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = self.location1;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = {self.location1, span};
    
    MKPointAnnotation* annotation2 = [[MKPointAnnotation alloc] init];
    annotation2.coordinate = self.location2;
    
    [self.mapView1 setRegion:region];
    [self.mapView1 addAnnotations:@[annotation, annotation2]];
    [self.mapView1 setShowsUserLocation:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
