//
//  SecondViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 16/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "FerryInfoViewController.h"
#import "FerryLocationManager.h"
#import "FerryOfficeDetails.h"
#import "FerryServiceSelectViewController.h"
#import "MapViewViewController.h"
#import "WebViewViewController.h"

@interface FerryInfoViewController ()

@property NSInteger selectedOffice;
@property (nonatomic, strong) NSArray* officesArray;

@property (nonatomic, strong) IBOutlet UIButton* buttonCompanyName;
@property (nonatomic, strong) IBOutlet UITextView* textViewDetails;

@end

@implementation FerryInfoViewController

- (IBAction)unwindToFerryInfo:(UIStoryboardSegue *)unwindSegue{
    
    if([unwindSegue.identifier isEqualToString:@"serviceInfoSelect"]){
        self.selectedOffice = ((FerryServiceSelectViewController*)unwindSegue.sourceViewController).selectedOffice;
        [self reloadOfficeData];
    }
    
}

- (void)reloadOfficeData{

    FerryOfficeDetails* details = self.officesArray[self.selectedOffice];
    [self.buttonCompanyName setTitle:details.companyName forState:UIControlStateNormal];
    self.textViewDetails.text = nil;
    self.textViewDetails.text = [NSString stringWithFormat:@"%@\n\nTel: %@", details.details, details.phone];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.officesArray = [FerryLocationManager fetchAllOfficeDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadOfficeData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"serviceInfoSelect"]) {
        ((FerryServiceSelectViewController*)segue.destinationViewController).selectedOffice = self.selectedOffice;
    }
    else if([segue.identifier isEqualToString:@"showMap"]){
        ((MapViewViewController*)segue.destinationViewController).location1 = ((FerryOfficeDetails*)self.officesArray[self.selectedOffice]).latLon1;
        ((MapViewViewController*)segue.destinationViewController).location2 = ((FerryOfficeDetails*)self.officesArray[self.selectedOffice]).latLon2;
    }
    else if([segue.identifier isEqualToString:@"showWeb"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = ((FerryOfficeDetails*)self.officesArray[self.selectedOffice]).url;
    }
}

@end
