//
//  FerryFilter.m
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "FerryFilter.h"
#import "FerryLocation.h"
#import "FerryLocationManager.h"

#define kUserDefaultsDefaultFerryLocation @"userDefaultsFerryLocation"
#define kUserDefaultsDefaultFerryDirection @"userDefaultsFerryDirection"

@implementation FerryFilter

- (void)setSelectedDate:(NSDate *)selectedDate{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selectedDate];
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    
    _selectedDate = beginningOfDay;
}

- (instancetype)initFromUserDefaults{
    
    FerryFilter* filter = [super init];
    if(filter){
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        [dateComps setHour:0];
        [dateComps setMinute:0];
        [dateComps setSecond:0];
        NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
        
        filter.selectedDate = beginningOfDay;
        filter.selectedLocation = [FerryLocationManager ferryLocationForId:[[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsDefaultFerryLocation]];
        if(!filter.selectedLocation){
            filter.selectedLocation = [FerryLocationManager ferryLocationForId:@"21"];
        }
        filter.isReverse = [[NSUserDefaults standardUserDefaults]boolForKey:kUserDefaultsDefaultFerryDirection];
    }
    return filter;
    
}

- (void)writeToUserDefaults{
    
    [[NSUserDefaults standardUserDefaults]setValue:self.selectedLocation.serverId forKey:kUserDefaultsDefaultFerryLocation];
    [[NSUserDefaults standardUserDefaults]setBool:self.isReverse forKey:kUserDefaultsDefaultFerryDirection];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

@end
