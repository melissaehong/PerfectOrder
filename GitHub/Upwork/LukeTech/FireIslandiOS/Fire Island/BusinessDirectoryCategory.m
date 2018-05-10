//
//  BusinessDirectoryCategory.m
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "BusinessDirectoryCategory.h"

@implementation BusinessDirectoryCategory

+ (NSArray*)fetchAllBusinessDirectories{
    return @[
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Art & Culture" categoryId:@"3"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Beauty" categoryId:@"4"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Beer, Wine and Spirits" categoryId:@"24"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Boating and Marina Services" categoryId:@"26"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Businesses" categoryId:@"2"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Construction" categoryId:@"7"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Dining and Restaurants" categoryId:@"8"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Education" categoryId: @"9"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Emergency Services" categoryId: @"15"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Event Planning/Entertainment" categoryId:@"10"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Food Market" categoryId:@"11"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Government" categoryId:@"12"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Health & Wellness" categoryId:@"13"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Home and Garden" categoryId:@"6"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Local Organizations" categoryId:@"14"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Lodging" categoryId: @"16"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Misc. Services" categoryId:@"1"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"News & Media" categoryId:@"17"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Pets" categoryId:@"25"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName: @"Professional Services" categoryId:@"18"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Real Estate" categoryId:@"19"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Recreation" categoryId:@"5"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Religious & Spiritual" categoryId:@"20"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Shopping" categoryId:@"21"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Technology Services" categoryId:@"22"],
             [[BusinessDirectoryCategory alloc]initWithCategoryName:@"Transportation" categoryId:@"23"]
             ];
}

- (instancetype)initWithCategoryName:(NSString*)categoryName categoryId:(NSString*)categoryId{
    
    self = [super init];
    
    if(self){
        self.categoryName = categoryName;
        self.categoryId = categoryId;
    }
    
    return self;
}

@end
