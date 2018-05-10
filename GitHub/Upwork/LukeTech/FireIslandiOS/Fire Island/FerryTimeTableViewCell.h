//
//  FerryTimeTableViewCell.h
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FerryTimeTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* labelTime;
@property (nonatomic, strong) IBOutlet UILabel* labelNotes;

@end
