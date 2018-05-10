//
//  DataManager.h
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FerryFilter;
@class GalleryImage;
@class GalleryCategory;
@class BusinessDirectoryCategory;

@interface DataManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (DataManager*)sharedInstance;

- (void)requestFerryScheduleForFilter:(FerryFilter*)filter callback:(void (^)(NSArray* results, bool fromWebservice))callbackBlock;

- (UIImage*)cachedThumbnailImageFor:(GalleryImage*)galleryImage;
- (UIImage*)cachedMainImageFor:(GalleryImage*)galleryImage;

- (void)downloadThumbnailImageFor:(GalleryImage*)galleryImage callback:(void (^)(GalleryImage* retImage))callbackBlock;
- (void)downloadMainImageFor:(GalleryImage*)galleryImage callback:(void (^)(GalleryImage* retImage))callbackBlock;
- (void)fetchImageGalleriesLocalCallback:(void (^)(NSArray* results))callbackBlock;
- (void)fetchImageGalleriesCallback:(void (^)(NSArray* results))callbackBlock;
- (void)fetchImagesForGallery:(GalleryCategory*)category callback:(void (^)(NSArray* fetchedImages))callbackBlock;
- (void)fetchDirectoryForCategory:(NSString*)categoryId completion:(void (^)(NSString* categoryId, NSString* htmlString))callbackBlock;
- (void)fetchAllEventsCompletion:(void (^)(NSArray* results))callbackBlock;

@end
