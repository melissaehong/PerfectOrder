//
//  Event.h
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * eventId;
@property (nonatomic, retain) NSString * eventTitle;
@property (nonatomic, retain) NSString * eventDescription;
@property (nonatomic, retain) NSString * eventLocation;
@property (nonatomic, retain) NSString * eventLinkout;
@property (nonatomic, retain) NSString * eventStartDate;
@property (nonatomic, retain) NSString * eventStartTime;
@property (nonatomic, retain) NSString * eventEndDate;
@property (nonatomic, retain) NSString * eventEndTime;

@end
