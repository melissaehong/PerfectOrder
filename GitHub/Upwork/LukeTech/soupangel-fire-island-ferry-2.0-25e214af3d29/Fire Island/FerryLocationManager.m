//
//  FerryLocationManager.m
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "FerryLocationManager.h"
#import "FerryLocation.h"
#import "FerryOfficeDetails.h"

@implementation FerryLocationManager

+ (NSArray*)fetchAllOfficeDetails{
    
    return @[
    [[FerryOfficeDetails alloc]initWithTitle:@"Bay Shore" companyName:@"Fire Island Ferries Inc" subtitle:@"Servicing: Ocean Beach, Ocean Bay Park, Seaview, Kismet, Fair Harbor, Saltaire, Dunewood, Atlantique" details:@"99 Maple Avenue Bay Shore, NY 11706-0224\n\nThis terminal services:\nAtlantique | Dunewood | Fair Harbor | Kismet | Ocean Beach | Ocean Bay Park | Seaview" phone:@"(631) 665-8885" url:@"http://www.fireisland.com/visit/ferry-schedule" latLon1:CLLocationCoordinate2DMake(40.717281, -73.241092) latLon2:CLLocationCoordinate2DMake(40.717281, -73.241092)],
    [[FerryOfficeDetails alloc]initWithTitle:@"Patchogue" companyName:@"Davis Park Ferry Co., Inc." subtitle:@"Servicing: Davis Park, Watch Hill." details:@"80 Brightwood Street Patchogue, NY 11772\n\nThis terminal services:\nDavis Park | Watch Hill" phone:@"(631) 475-1665" url:@"http://www.fireisland.com/visit/ferry-schedule" latLon1:CLLocationCoordinate2DMake(40.750752, -73.016918) latLon2:CLLocationCoordinate2DMake(40.750752, -73.016918)],
    [[FerryOfficeDetails alloc]initWithTitle:@"Sayville" companyName:@"Sayville" subtitle:@"Servicing: Cherry Grove, Fire Island Pines, Sailors Haven, Water Island" details:@"41 River Road Sayville, NY 11782-3211\n\nThis terminal services:\nCherry Grove | Fire Island Pines | Sunken Forest | Water Island" phone:@"(631) 589-0810" url:@"http://www.fireisland.com/visit/ferry-schedule" latLon1:CLLocationCoordinate2DMake(40.727379, -73.071943) latLon2:CLLocationCoordinate2DMake(40.727379, -73.071943)]
     ];
    
}

+ (NSArray*)allFerryLocations{
    
    return @[
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Atlantique" serverId:@"16"],
             [FerryLocation locationWithStartPoint:@"Sayville"	finishPoint:@"Cherry Grove" serverId:@"27"],
             [FerryLocation locationWithStartPoint:@"Patchogue"	finishPoint:@"Davis Park" serverId:@"25"],
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Dunewood"	serverId:@"17"],
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Fair Harbor" serverId:@"18"],
             [FerryLocation locationWithStartPoint:@"Sayville"	finishPoint:@"Fire Island Pines" serverId:@"28"],
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Kismet" serverId:@"19"],
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Ocean Bay Park" serverId:@"20"],
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Ocean Beach" serverId:@"21"],
             [FerryLocation locationWithStartPoint:@"Sayville"	finishPoint:@"Sailor’s Haven" serverId:@"29"],
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Saltaire" serverId:@"23"],
             [FerryLocation locationWithStartPoint:@"Bay Shore"	finishPoint:@"Seaview" serverId:@"24"],
             [FerryLocation locationWithStartPoint:@"Sayville"	finishPoint:@"Sunken Forest"serverId:@"30"],
             [FerryLocation locationWithStartPoint:@"Patchogue"	finishPoint:@"Watch Hill" serverId:@"26"],
             [FerryLocation locationWithStartPoint:@"Sayville"	finishPoint:@"Water Island"	serverId:@"31"]
             ];
}

+ (FerryLocation*)ferryLocationForId:(NSString *)locationId{
    
    NSArray* allLocations = [self allFerryLocations];
    for(FerryLocation* loc in allLocations){
        if([loc.serverId isEqualToString:locationId]){
            return loc;
        }
    }
    return nil;
}

@end
