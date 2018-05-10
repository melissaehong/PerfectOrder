//
//  FerryLocationManager.h
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FerryLocation;

@interface FerryLocationManager : NSObject

/**
 *  Returns all ferry locations. This used to load from sqlite, but the data never changes and there are only a few rows.
 *  Therefore much better performance to use a static array
 *
 *  @return an array of {@link FerryLocation} ferryLocation objects
 */
+ (NSArray*)allFerryLocations;

+ (FerryLocation*)ferryLocationForId:(NSString*)locationId;

+ (NSArray*)fetchAllOfficeDetails;

@end
