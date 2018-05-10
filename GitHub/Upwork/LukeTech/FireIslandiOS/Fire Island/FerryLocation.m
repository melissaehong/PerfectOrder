//
//  FerryLocation.m
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "FerryLocation.h"

@implementation FerryLocation

+ (FerryLocation*)locationWithStartPoint:(NSString*)start finishPoint:(NSString*)end serverId:(NSString*)serverId{
    
    FerryLocation* newLoc = [[FerryLocation alloc]init];
    newLoc.start = start;
    newLoc.end = end;
    newLoc.serverId = serverId;
    return newLoc;
    
}

@end
