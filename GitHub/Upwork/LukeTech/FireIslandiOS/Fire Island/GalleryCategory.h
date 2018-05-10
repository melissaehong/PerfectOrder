//
//  GalleryCategory.h
//  Fire Island
//
//  Created by Peter Rocker on 19/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GalleryCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * galleryId;
@property (nonatomic, retain) NSString * name;

@end
