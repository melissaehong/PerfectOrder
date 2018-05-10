//
//  BusinessDirectoryCategory.h
//  Fire Island
//
//  Created by Peter Rocker on 23/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessDirectoryCategory : NSObject

@property (nonatomic, strong) NSString* categoryName;
@property (nonatomic, strong) NSString* categoryId;

+ (NSArray*)fetchAllBusinessDirectories;

- (instancetype)initWithCategoryName:(NSString*)categoryName categoryId:(NSString*)categoryId;

@end
