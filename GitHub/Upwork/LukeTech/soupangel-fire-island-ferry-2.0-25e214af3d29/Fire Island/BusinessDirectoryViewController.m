//
//  BusinessDirectoryViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "BusinessDirectoryViewController.h"
#import "BusinessDirectoryCategory.h"
#import "DataManager.h"
#import "WebViewViewController.h"

@interface BusinessDirectoryViewController () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UITextField* textFieldCategory;
@property (nonatomic, strong) IBOutlet UIWebView* webView1;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityIndicator;

@property (nonatomic, strong) IBOutlet UITableView* tableViewCategories;

@property (nonatomic, strong) NSArray* categories;
@property (nonatomic, strong) BusinessDirectoryCategory* selectedCategory;

@end

@implementation BusinessDirectoryViewController

- (IBAction)unwindToDirectory:(UIStoryboardSegue*)sender{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if([request.URL.absoluteString rangeOfString:@"http"].location == 0){
        [self performSegueWithIdentifier:@"showWeb" sender:request.URL.absoluteString];
        return NO;
    }
    if([request.URL.absoluteString rangeOfString:@"tel"].location == 0 || [request.URL.absoluteString rangeOfString:@"mailto"].location == 0){
        [[UIApplication sharedApplication]openURL:request.URL];
        return NO;
    }

    return YES;
}

- (void)loadSelectedCategory{
    
    self.activityIndicator.hidden = NO;
    self.textFieldCategory.text = self.selectedCategory.categoryName;
    self.webView1.hidden = YES;
    
    [[DataManager sharedInstance]fetchDirectoryForCategory:self.selectedCategory.categoryId completion:^(NSString* category, NSString* htmlString){
        
        if([category isEqualToString:self.selectedCategory.categoryId]){
            self.webView1.hidden = NO;
            [self.webView1 loadHTMLString:htmlString baseURL:nil];
            self.activityIndicator.hidden = YES;
        }
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedCategory = self.categories[indexPath.row];
    [self.view endEditing:YES];
    [self loadSelectedCategory];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categories.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = ((BusinessDirectoryCategory*)self.categories[indexPath.row]).categoryName;
    return cell;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.categories = [BusinessDirectoryCategory fetchAllBusinessDirectories];
    
    self.textFieldCategory.inputView = self.tableViewCategories;
    [self.tableViewCategories reloadData];
    
    [self.webView1 loadHTMLString:@"<font face=\"helvetica\" >Select a category to load directory info</font>"baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showWeb"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = sender;
    }
}


@end
