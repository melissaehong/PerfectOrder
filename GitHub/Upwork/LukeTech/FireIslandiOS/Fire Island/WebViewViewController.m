//
//  WebViewViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 18/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController () <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView* webView1;
@property (nonatomic, strong) IBOutlet UIButton* printButton;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityIndicator;

@end

@implementation WebViewViewController

- (IBAction)printClick:(id)sender{
    UIPrintInfo *pi = [UIPrintInfo printInfo];
    pi.outputType = UIPrintInfoOutputGeneral;
    pi.jobName = self.webView1.request.URL.absoluteString;
    pi.orientation = UIPrintInfoOrientationPortrait;
    pi.duplex = UIPrintInfoDuplexLongEdge;
    
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.printInfo = pi;
    pic.showsPageRange = YES;
    pic.printFormatter = self.webView1.viewPrintFormatter;
    [pic presentAnimated:YES completionHandler:^(UIPrintInteractionController *pic2, BOOL completed, NSError *error) {
        // indicate done or error
    }];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.activityIndicator.hidden = YES;
    self.printButton.hidden = NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.printButton.hidden = YES;
    self.activityIndicator.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.activityIndicator.hidden = NO;
    [self.webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.targetUrl]]];
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
