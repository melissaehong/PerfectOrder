//
//  EventsDetailViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "Event.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "WebViewViewController.h"

@interface EventsDetailViewController () <EKEventEditViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel* labelTitle;
@property (nonatomic, strong) IBOutlet UILabel* labelLocation;
@property (nonatomic, strong) IBOutlet UILabel* labelStartDate;
@property (nonatomic, strong) IBOutlet UITextView* textViewDetails;

@property (nonatomic, strong) EKEventStore* eventStore;
@property (nonatomic, strong) EKCalendar *defaultCalendar;

@end

@implementation EventsDetailViewController

- (IBAction)unwindToEventsDetail:(UIStoryboardSegue*)sender{
    
}

- (IBAction)websiteClick:(id)sender{
    [self performSegueWithIdentifier:@"showWeb" sender:self.selectedEvent.eventLinkout];
}

- (IBAction)addToCalendarClick:(id)sender{
    
    EKEventStore *es = [[EKEventStore alloc] init];
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    BOOL needsToRequestAccessToEventStore = (authorizationStatus == EKAuthorizationStatusNotDetermined);
    
    if (needsToRequestAccessToEventStore) {
        [es requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted) {
                [self addNewCalendarItem];
            } else {
                // Denied
            }
        }];
    } else {
        BOOL granted = (authorizationStatus == EKAuthorizationStatusAuthorized);
        if (granted) {
            [self addNewCalendarItem];
        } else {
            // Denied
        }
    }
}

- (void)addNewCalendarItem{
    
    NSDateFormatter* dateTimeDateFormatter = [[NSDateFormatter alloc]init];
    [dateTimeDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    EKEvent *newEvent = [EKEvent eventWithEventStore:self.eventStore];
    newEvent.title = self.selectedEvent.eventTitle;
    newEvent.location = self.selectedEvent.eventLocation;
    newEvent.startDate = [dateTimeDateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", self.selectedEvent.eventStartDate, self.selectedEvent.eventStartTime]];
    newEvent.endDate = [dateTimeDateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", self.selectedEvent.eventEndDate, self.selectedEvent.eventEndTime]];
    newEvent.URL = [NSURL URLWithString:self.selectedEvent.eventLinkout];
    newEvent.notes = self.selectedEvent.eventDescription;
    EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
    addController.event = newEvent;
    addController.eventStore = self.eventStore;
    [self presentViewController:addController animated:YES completion:nil];
    
    addController.editViewDelegate = self;

}

#pragma mark EKEventEditViewDelegate

- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action {
    NSError *error = nil;
    
    switch (action) {
        case EKEventEditViewActionCanceled:
            break;
        case EKEventEditViewActionSaved:
            [controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller {
    EKCalendar *calendarForEdit = self.defaultCalendar;
    return calendarForEdit;
}


- (IBAction)shareClick:(id)sender{
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[[NSString stringWithFormat:@"Fire Island event - %@!\n\n%@", self.selectedEvent.eventTitle, self.selectedEvent.eventDescription], self.selectedEvent.eventLinkout]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *presentationController =
    [controller popoverPresentationController];
    
    presentationController.sourceView = self.view;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labelTitle.text = self.selectedEvent.eventTitle;
    self.labelLocation.text = self.selectedEvent.eventLocation;
    self.labelStartDate.text = [NSString stringWithFormat:@"Starts %@ at %@", self.selectedEvent.eventStartDate, self.selectedEvent.eventStartTime];
    
    self.textViewDetails.text = self.selectedEvent.eventDescription;
    
    self.eventStore = [[EKEventStore alloc] init];
    self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showWeb"]){
        ((WebViewViewController*)segue.destinationViewController).targetUrl = sender;
    }
}

@end
