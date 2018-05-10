//
//  FerryFilter.h
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FerryLocation;

@interface FerryFilter : NSObject

@property (nonatomic, strong) FerryLocation* selectedLocation;
@property (nonatomic, strong) NSDate* selectedDate;
@property BOOL isReverse;

- (instancetype)initFromUserDefaults;
- (void)writeToUserDefaults;

@end
