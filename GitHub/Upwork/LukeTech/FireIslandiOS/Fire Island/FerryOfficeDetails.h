//
//  FerryOfficeDetails.h
//  Fire Island
//
//  Created by Peter Rocker on 18/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FerryOfficeDetails : NSObject

- (instancetype)initWithTitle:(NSString*)title companyName:(NSString*)companyName subtitle:(NSString*)subtitle details:(NSString*)details phone:(NSString*)phone url:(NSString*)url latLon1:(CLLocationCoordinate2D)latLon1 latLon2:(CLLocationCoordinate2D)latLon2;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* companyName;
@property (nonatomic, strong) NSString* subtitle;
@property (nonatomic, strong) NSString* details;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* url;
@property CLLocationCoordinate2D latLon1;
@property CLLocationCoordinate2D latLon2;

@end
