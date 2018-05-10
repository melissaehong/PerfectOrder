//
//  EventsTableViewCell.h
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* labelTitle;
@property (nonatomic, strong) IBOutlet UILabel* labelCity;
@property (nonatomic, strong) IBOutlet UILabel* labelDate;

@end
