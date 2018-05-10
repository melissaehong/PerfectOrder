//
//  DataManager.m
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "DataManager.h"
#import "HttpManager.h"
#import "FerryFilter.h"
#import "FerryLocation.h"
#import "FerryTime.h"
#import <Coredata/Coredata.h>
#import "GalleryImage.h"
#import "GalleryCategory.h"
#import "Event.h"

@interface DataManager()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DataManager

static DataManager *SINGLETON = nil;

static bool isFirstAccess = YES;

- (NSString*)cachedBusDirectoryPath:(NSString*)categoryId{
    
    return [self cachedImagePath:[NSString stringWithFormat:@"directory-%@.html", categoryId]];
    
}

- (NSString*)cachedImagePath:(NSString*)filename{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    
    return [cacheDir stringByAppendingPathComponent:[filename stringByReplacingOccurrencesOfString:@"/" withString:@"."]];
}

- (UIImage*)cachedMainImageFor:(GalleryImage*)galleryImage{
    return [[UIImage alloc]initWithContentsOfFile:[self cachedImagePath:galleryImage.imageUrl]];
}

- (UIImage*)cachedThumbnailImageFor:(GalleryImage*)galleryImage{
    return [[UIImage alloc]initWithContentsOfFile:[self cachedImagePath:galleryImage.miniUrl]];
}

- (void)downloadThumbnailImageFor:(GalleryImage*)galleryImage callback:(void (^)(GalleryImage* retImage))callbackBlock{
    [[HttpManager sharedInstance]downloadImage:galleryImage.miniUrl callback:^(UIImage* imageData) {
        [UIImageJPEGRepresentation(imageData, 0.9) writeToFile:[self cachedImagePath:galleryImage.miniUrl] atomically:YES];
        callbackBlock(galleryImage);
    }];
}

- (void)downloadMainImageFor:(GalleryImage*)galleryImage callback:(void (^)(GalleryImage* retImage))callbackBlock{
    [[HttpManager sharedInstance]downloadImage:galleryImage.imageUrl callback:^(UIImage* imageData) {
        [UIImageJPEGRepresentation(imageData, 0.9) writeToFile:[self cachedImagePath:galleryImage.imageUrl] atomically:YES];
        callbackBlock(galleryImage);
    }];
}

- (void)fetchAllEventsCompletion:(void (^)(NSArray* results))callbackBlock{
    
    callbackBlock([self fetchAllEntitiesWithName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"eventId != %@", @"127"] andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"eventStartDate" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"eventStartTime" ascending:YES]]]);
    
    [[HttpManager sharedInstance]fetchEventsCompletion:^(NSArray* results){
        
        for(NSDictionary* jsonDict in results){
            
            NSArray* existingObjects = [self fetchAllEntitiesWithName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"eventId == %@", jsonDict[@"id"]] andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"eventId" ascending:YES]]];

            Event* newEvent;
            
            if(existingObjects && existingObjects.count){
                newEvent = existingObjects[0];
            }
            else{
                newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
            }
            
            newEvent.eventId = jsonDict[@"id"];
            newEvent.eventTitle = jsonDict[@"eventTitle"];
            newEvent.eventDescription = jsonDict[@"eventDescription"];
            newEvent.eventLocation = jsonDict[@"eventLocation"];
            newEvent.eventLinkout = jsonDict[@"eventLinkout"];
            newEvent.eventStartDate = jsonDict[@"eventStartDate"];
            if([newEvent.eventStartDate isEqualToString:@"0000-00-00"]){
                newEvent.eventStartDate = @"1970-01-01";
            }
            newEvent.eventStartTime = jsonDict[@"eventStartTime"];
            newEvent.eventEndDate = jsonDict[@"eventEndDate"];
            if([newEvent.eventEndDate isEqualToString:@"0000-00-00"]){
                newEvent.eventEndDate = @"1970-01-01";
            }
            newEvent.eventEndTime = jsonDict[@"eventEndTime"];
            
            [self saveContext];
        }
        
        callbackBlock([self fetchAllEntitiesWithName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"eventId != %@", @"127"] andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"eventStartDate" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"eventStartTime" ascending:YES]]]);
        
    }];
    
    
}

- (void)fetchDirectoryForCategory:(NSString*)categoryId completion:(void (^)(NSString* categoryId, NSString* htmlString))callbackBlock{
    
    NSString* directoryString = [NSString stringWithContentsOfFile:[self cachedBusDirectoryPath:categoryId] encoding:NSUTF8StringEncoding error:nil];
    
    if(directoryString && directoryString.length){
        callbackBlock(categoryId, directoryString);
    }

    [[HttpManager sharedInstance]fetchDirectoryForCategory:(NSString*)categoryId completion:^(NSData* htmlString){
        
        NSString* formattedHtml = [self businessDirectoryFormat:[[NSString alloc]initWithData:htmlString encoding:NSUTF8StringEncoding]];
        if(![formattedHtml isEqualToString:directoryString]){
            [formattedHtml writeToFile:[self cachedBusDirectoryPath:categoryId] atomically:YES encoding:NSUTF8StringEncoding error:nil];
            callbackBlock(categoryId, formattedHtml);
        }
        
    }];
    
}

- (NSString*)businessDirectoryFormat:(NSString*)htmlString{
    
    NSMutableString * text = [NSMutableString stringWithString:@"<html><head><style>a {color:#BF1619;}</style></head><body style=\"background-color: transparent;\"><br><font face=\"helvetica neue\" style=\"font-weight:200;color:#000000;\">"];
    
    NSArray * components = [[NSArray alloc] initWithArray:[htmlString componentsSeparatedByString:@"<tr>"]];
    
    for(int i = 0; i < components.count; i++){
        if(i != 0){
            if(i != components.count - 1){
                [text appendString:[components objectAtIndex:i]];
                [text appendString:@"<br><br>"];
            }
            else{
                
                NSString *str1 = [components objectAtIndex:i];
                NSRange range = [str1 rangeOfString:@"';"];
                
                NSString *newString = [str1 substringToIndex:range.location];
                
                [text appendString:newString];
                [text appendString:@"<br><br>"];
                
            }
        }
    }
    
    NSString * newText = [text stringByReplacingOccurrencesOfString:@"target=\\'_blank\\'" withString:@""];
    
    newText = [newText stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
    
    newText = [newText stringByAppendingString:@"<br><br><br><br><br><br></font></body></html>"];
    
    return [NSString stringWithString:newText];
}

- (void)fetchImagesForGallery:(GalleryCategory*)category callback:(void (^)(NSArray* fetchedImages))callbackBlock{
    
    callbackBlock([self fetchAllEntitiesWithName:@"GalleryImage" withPredicate:[NSPredicate predicateWithFormat:@"category == %i", [category.galleryId integerValue]] andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"imageId" ascending:YES]]]);
    
    [[HttpManager sharedInstance]requestImagesForGallery:category.galleryId callback:^(NSDictionary* results) {

        if(results && results[@"images"]){
            for(NSDictionary* imageDict in results[@"images"]){
                
                GalleryImage* newImage;
                
                NSArray* existing = [self fetchAllEntitiesWithName:@"GalleryImage" withPredicate:[NSPredicate predicateWithFormat:@"imageId == %i", [imageDict[@"id"] integerValue]] andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"imageId" ascending:YES]]];
                if(existing && existing.count){
                    newImage = [existing firstObject];
                }
                else{
                    newImage = [NSEntityDescription insertNewObjectForEntityForName:@"GalleryImage" inManagedObjectContext:self.managedObjectContext];
                }
                
                newImage.imageId = imageDict[@"id"];
                newImage.name = imageDict[@"name"];
                newImage.miniUrl = imageDict[@"mini_url"];
                newImage.imageUrl = imageDict[@"image_url"];
                newImage.category = category.galleryId;
                
            }
            [self saveContext];
            
             callbackBlock([self fetchAllEntitiesWithName:@"GalleryImage" withPredicate:[NSPredicate predicateWithFormat:@"category == %i", [category.galleryId integerValue]] andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"imageId" ascending:YES]]]);
        }
    
    }];
    
}


- (void)fetchImageGalleriesLocalCallback:(void (^)(NSArray* results))callbackBlock {
    
    callbackBlock([self fetchAllEntitiesWithName:@"GalleryCategory" withPredicate:nil andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"galleryId" ascending:YES]]]);
    
}

- (void)fetchImageGalleriesCallback:(void (^)(NSArray* results))callbackBlock{
    
    [[HttpManager sharedInstance]requestImageGalleriesCallback:^(NSDictionary* results) {
        
        if(results && results[@"galleries"]){
            [self deleteAllEntitiesWithName:@"GalleryCategory" andPredicate:nil];
            for(NSDictionary* category in results[@"galleries"]){
                GalleryCategory* gc = [NSEntityDescription insertNewObjectForEntityForName:@"GalleryCategory" inManagedObjectContext:self.managedObjectContext];
                gc.galleryId = category[@"id"];
                gc.name = category[@"name"];
            }
            [self saveContext];
        }
        if(callbackBlock){
            callbackBlock([self fetchAllEntitiesWithName:@"GalleryCategory" withPredicate:nil andSortDesriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"galleryId" ascending:YES]]]);
        }
    }];
    
}

- (void)requestFerryScheduleForFilter:(FerryFilter*)filter callback:(void (^)(NSArray* results, bool fromWebservice))callbackBlock{
    
    callbackBlock([self fetchScheduleTimesForFilter:filter], NO);
    [[HttpManager sharedInstance]requestTimesForFilter:filter callback:^(NSDictionary *results) {

        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"date == %@ AND isReverse == %i AND locationId == %@", filter.selectedDate, 0, filter.selectedLocation.serverId];
        [self deleteAllEntitiesWithName:@"FerryTime" andPredicate:predicate];
        predicate = [NSPredicate predicateWithFormat:@"date == %@ AND isReverse == %i AND locationId == %@", filter.selectedDate, 1, filter.selectedLocation.serverId];
        [self deleteAllEntitiesWithName:@"FerryTime" andPredicate:predicate];
        
        for(NSDictionary* dict in results[@"from_to"]){
           [self insertFerryTimesFromJSON:dict fromFilter:filter isReverse:NO];
        }
        for(NSDictionary* dict in results[@"to_from"]){
            [self insertFerryTimesFromJSON:dict fromFilter:filter isReverse:YES];
        }
        
        callbackBlock([self fetchScheduleTimesForFilter:filter], YES);
        
    }];
    
}

- (NSArray*)fetchScheduleTimesForFilter:(FerryFilter*)filter{
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"date == %@ AND isReverse == %i AND locationId == %@", filter.selectedDate, filter.isReverse ? 1 : 0, filter.selectedLocation.serverId];
    return [self fetchAllEntitiesWithName:@"FerryTime" withPredicate:predicate andSortDesriptors:@[[[NSSortDescriptor alloc]initWithKey:@"date" ascending:YES]]];
    
}

- (void)insertFerryTimesFromJSON:(NSDictionary*)dict fromFilter:(FerryFilter*)filter isReverse:(BOOL)isReverse{

    FerryTime* time = [NSEntityDescription insertNewObjectForEntityForName:@"FerryTime" inManagedObjectContext:self.managedObjectContext];
    
    time.time = dict[@"time"];
    time.note = dict[@"note"];
    time.date = filter.selectedDate;
    time.isReverse = [NSNumber numberWithBool:isReverse];
    time.locationId = filter.selectedLocation.serverId;
    
    [self saveContext];
    
}


#pragma mark - coredata stack

- (void)deleteAllEntitiesWithName:(NSString*)entityName andPredicate:(NSPredicate*)predicate{
    
    NSFetchRequest * allEntities = [[NSFetchRequest alloc] init];
    [allEntities setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext]];
    [allEntities setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    [allEntities setPredicate:predicate];
    
    NSError * error = nil;
    NSArray * entities = [self.managedObjectContext executeFetchRequest:allEntities error:&error];
    
    //error handling goes here
    for (NSManagedObject * entity in entities) {
        [self.managedObjectContext deleteObject:entity];
    }
    
    [self saveContext];
    
}



- (NSArray*)fetchAllEntitiesWithName:(NSString*)entityName withPredicate:(NSPredicate*)predicate andSortDesriptors:(NSArray*)sortDescriptors{

    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    if(predicate){
        [request setPredicate:predicate];
    }
    
    if(sortDescriptors){
        [request setSortDescriptors:sortDescriptors];
    }
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(array){
        
        return array;
    }
    
    NSLog(@"error in fetchAllEntitiesWithName: %@", [error localizedDescription]);
    return [NSArray array];
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}




#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[DataManager alloc] init];
}

- (id)mutableCopy
{
    return [[DataManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
