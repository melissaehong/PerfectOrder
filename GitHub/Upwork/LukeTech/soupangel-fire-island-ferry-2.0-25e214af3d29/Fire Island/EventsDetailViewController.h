//
//  EventsDetailViewController.h
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface EventsDetailViewController : UIViewController

@property (nonatomic, strong) Event* selectedEvent;

@end
