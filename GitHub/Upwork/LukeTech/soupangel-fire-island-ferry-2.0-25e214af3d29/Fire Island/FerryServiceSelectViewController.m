//
//  FerryServiceSelectViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 18/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "FerryServiceSelectViewController.h"
#import "FerryOfficeDetails.h"
#import "FerryLocationManager.h"

@interface FerryServiceSelectViewController ()

@property (nonatomic, strong) IBOutlet UIImageView* tick1;
@property (nonatomic, strong) IBOutlet UIImageView* tick2;
@property (nonatomic, strong) IBOutlet UIImageView* tick3;

@property (nonatomic, strong) IBOutlet UILabel* labelTitle1;
@property (nonatomic, strong) IBOutlet UILabel* labelTitle2;
@property (nonatomic, strong) IBOutlet UILabel* labelTitle3;
@property (nonatomic, strong) IBOutlet UILabel* labelDetails1;
@property (nonatomic, strong) IBOutlet UILabel* labelDetails2;
@property (nonatomic, strong) IBOutlet UILabel* labelDetails3;

@end

@implementation FerryServiceSelectViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self showHideButtons];

    NSArray* allArray = [FerryLocationManager fetchAllOfficeDetails];
    
    self.labelTitle1.text = ((FerryOfficeDetails*)allArray[0]).title;
    self.labelDetails1.text = ((FerryOfficeDetails*)allArray[0]).subtitle;
    self.labelTitle2.text = ((FerryOfficeDetails*)allArray[1]).title;
    self.labelDetails2.text = ((FerryOfficeDetails*)allArray[1]).subtitle;
    self.labelTitle3.text = ((FerryOfficeDetails*)allArray[2]).title;
    self.labelDetails3.text = ((FerryOfficeDetails*)allArray[2]).subtitle;
    
}

- (void)showHideButtons {
    
    self.tick1.hidden = YES;
    self.tick2.hidden = YES;
    self.tick3.hidden = YES;
    
    switch (self.selectedOffice) {
        case 0:
            self.tick1.hidden = NO;
            break;
        case 1:
            self.tick2.hidden = NO;
            break;
        case 2:
            self.tick3.hidden = NO;
            break;
            
        default:
            break;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"serviceInfoSelect"]){
        [self showHideButtons];
        self.selectedOffice = ((UIView*)sender).tag - 1;
    }
}
@end
