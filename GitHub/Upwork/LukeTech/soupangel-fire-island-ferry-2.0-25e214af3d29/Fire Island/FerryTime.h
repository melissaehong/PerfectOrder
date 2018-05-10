//
//  FerryTime.h
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FerryTime : NSManagedObject

@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * isReverse;
@property (nonatomic, retain) NSString * locationId;

@end
