//
//  SocialViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 24/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "SocialViewController.h"
#import "WebViewViewController.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"website"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = @"http://www.fireisland.com/";
    }
    else if([segue.identifier isEqualToString:@"facebook"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = @"http://www.facebook.com/FireIslandNY?ref=ts";
    }
    else if([segue.identifier isEqualToString:@"twitter"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = @"https://twitter.com/fireisland";
    }
    else if([segue.identifier isEqualToString:@"youtube"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = @"http://www.youtube.com/user/fireislandvideos";
    }
    else if([segue.identifier isEqualToString:@"pinterest"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = @"http://pinterest.com/fireislandny/";
    }
    else if([segue.identifier isEqualToString:@"google"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = @"https://plus.google.com/106670822654573284832";
    }
    else if([segue.identifier isEqualToString:@"maps"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = @"https://www.google.com/maps/place/Fire+Island,+NY,+USA/@40.6499913,-73.1368838,17z/data=!4m2!3m1!1s0x89e81153da534b8f:0x63032a1963b35f70";
    }
}

@end
