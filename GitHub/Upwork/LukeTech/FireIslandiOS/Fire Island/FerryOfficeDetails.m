//
//  FerryOfficeDetails.m
//  Fire Island
//
//  Created by Peter Rocker on 18/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "FerryOfficeDetails.h"

@implementation FerryOfficeDetails

- (instancetype)initWithTitle:(NSString*)title companyName:(NSString*)companyName subtitle:(NSString*)subtitle details:(NSString*)details phone:(NSString*)phone url:(NSString*)url latLon1:(CLLocationCoordinate2D)latLon1 latLon2:(CLLocationCoordinate2D)latLon2{
    
    self = [super init];
    if(self){
        
        self.title = title;
        self.companyName = companyName;
        self.subtitle = subtitle;
        self.details = details;
        self.phone = phone;
        self.url = url;
        self.latLon1 = latLon1;
        self.latLon2 = latLon2;
        
    }
    
    return self;
}


@end
