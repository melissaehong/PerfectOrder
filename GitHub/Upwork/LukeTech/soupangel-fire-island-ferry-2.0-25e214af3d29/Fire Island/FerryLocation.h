//
//  FerryLocation.h
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FerryLocation : NSObject

+ (FerryLocation*)locationWithStartPoint:(NSString*)start finishPoint:(NSString*)end serverId:(NSString*)serverId;

@property (nonatomic, strong) NSString* start;
@property (nonatomic, strong) NSString* end;
@property (nonatomic, strong) NSString* serverId;

@end
