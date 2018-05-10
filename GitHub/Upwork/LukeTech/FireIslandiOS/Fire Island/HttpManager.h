//
//  HttpManager.h
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FerryFilter;

@interface HttpManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (HttpManager*)sharedInstance;

- (void)requestTimesForFilter:(FerryFilter*)filter callback:(void (^)(NSDictionary* results))callbackBlock;

- (void)downloadImage:(NSString*)imageLoc callback:(void (^)(UIImage* imageData))callbackBlock;

- (void)requestImageGalleriesCallback:(void (^)(NSDictionary* results))callbackBlock;

- (void)requestImagesForGallery:(NSNumber*)category callback:(void (^)(NSDictionary* results))callbackBlock;

- (void)uploadPicture:(UIImage*)picture withCaption:(NSString*)caption completion:(void (^)(NSError* error))callbackBlock;

- (void)fetchDirectoryForCategory:(NSString*)categoryId completion:(void (^)(NSData* htmlString))callbackBlock;

- (void)fetchEventsCompletion:(void (^)(NSArray* results))callback;

- (void)postNewBusinessListing:(NSDictionary*) params completion:(void (^)(NSError* error))callback;

@end
