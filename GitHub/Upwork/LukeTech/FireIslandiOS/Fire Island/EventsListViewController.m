//
//  EventsListViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "EventsListViewController.h"
#import "EventsTableViewCell.h"
#import "DataManager.h"
#import "EventsDetailViewController.h"
#import "Event.h"

@interface EventsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityView;
@property (nonatomic, strong) IBOutlet UITableView* tableView1;

@property (nonatomic, strong) NSArray* eventsArray;

@property (nonatomic, strong) NSDateFormatter* webserviceDateFormatter;
@property (nonatomic, strong) NSDateFormatter* prettyDateFormatter;
@property (nonatomic, strong) NSDateFormatter* prettyTimeFormatter;

@end

@implementation EventsListViewController

- (IBAction)unwindToEvents:(UIStoryboardSegue*)sender{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Event* event = self.eventsArray[indexPath.row];
    
    cell.labelTitle.text = event.eventTitle;
    cell.labelCity.text = event.eventLocation;
    
    cell.labelDate.text = [NSString stringWithFormat:@"%@ - %@", [self.prettyDateFormatter stringFromDate:[self.webserviceDateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", event.eventStartDate, event.eventStartTime]]],
                           
                           [event.eventStartDate isEqualToString:event.eventEndDate] ?
                           [self.prettyTimeFormatter stringFromDate:[self.webserviceDateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", event.eventEndDate, event.eventEndTime]]]
                                                    : [self.prettyDateFormatter stringFromDate:[self.webserviceDateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", event.eventEndDate, event.eventEndTime]]]
                           
                           ];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.eventsArray.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webserviceDateFormatter = [[NSDateFormatter alloc]init];
    [self.webserviceDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.prettyDateFormatter = [[NSDateFormatter alloc]init];
    [self.prettyDateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.prettyDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.prettyTimeFormatter = [[NSDateFormatter alloc]init];
    [self.prettyTimeFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.prettyTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 
    [[DataManager sharedInstance]fetchAllEventsCompletion:^(NSArray* results){
        
        if(results && results.count){
            self.activityView.hidden = YES;
            self.eventsArray = results;
            [self.tableView1 reloadData];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((EventsDetailViewController*)segue.destinationViewController).selectedEvent = self.eventsArray[[self.tableView1 indexPathForSelectedRow].row];
    [self.tableView1 deselectRowAtIndexPath:[self.tableView1 indexPathForSelectedRow] animated:YES];
}


@end
