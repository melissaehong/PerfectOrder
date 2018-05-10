//
//  GalleryImage.h
//  Fire Island
//
//  Created by Peter Rocker on 19/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GalleryImage : NSManagedObject

@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) NSNumber * imageId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * miniUrl;
@property (nonatomic, retain) NSString * imageUrl;

@end
