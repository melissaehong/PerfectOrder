//
//  HttpManager.m
//  Fire Island
//
//  Created by Peter Rocker on 17/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "HttpManager.h"
#import <AFNetworking/AFNetworking.h>
#import "FerryFilter.h"
#import "FerryLocation.h"

@interface HttpManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager* requestManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager* imageRequestManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager* rawRequestManager;

@end

@implementation HttpManager

static HttpManager *SINGLETON = nil;

static bool isFirstAccess = YES;

- (void)postNewBusinessListing:(NSDictionary*) params completion:(void (^)(NSError* error))callback{
    [self.rawRequestManager POST:@"wp-content/plugins/business-directory/requests.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(error);
    }];
}


- (void)fetchEventsCompletion:(void (^)(NSArray* results))callback{
    
    [self.rawRequestManager GET:@"http://www.fireisland.com/wp-admin/events.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([responseObject isKindOfClass:[NSData class]]){
            callback([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]);
        }
        else{
            callback(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(nil);
    }];
    
}

- (void)fetchDirectoryForCategory:(NSString*)categoryId completion:(void (^)(NSData* htmlString))callbackBlock{
    
    [self.rawRequestManager POST:@"wp-content/plugins/business-directory/requests.php" parameters:@{@"action":@"SearchListings", @"category" : categoryId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callbackBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)uploadPicture:(UIImage*)picture withCaption:(NSString*)caption completion:(void (^)(NSError* error))callbackBlock{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.fireisland.com/wp-content/plugins/photosmash-galleries/photosmashupload.php"]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:caption forHTTPHeaderField:@"image_caption"];
    [request setHTTPBody: UIImageJPEGRepresentation(picture, 0.9)];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        callbackBlock(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callbackBlock(error);
    }];
    [op start];
}

- (void)requestImagesForGallery:(NSNumber*)category callback:(void (^)(NSDictionary* results))callbackBlock{
    
    [self.requestManager GET:[NSString stringWithFormat:@"/my/images.php?id=%li", [category integerValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callbackBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callbackBlock(nil);
    }];
    
}

- (void)requestImageGalleriesCallback:(void (^)(NSDictionary* results))callbackBlock{
    
    [self.requestManager GET:@"my/galleries.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callbackBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callbackBlock(nil);
    }];
    
}

- (void)downloadImage:(NSString*)imageLoc callback:(void (^)(UIImage* imageData))callbackBlock{
    
    [self.imageRequestManager GET:[NSString stringWithFormat:@"wp-content/uploads/%@", imageLoc] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        callbackBlock(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        callbackBlock(nil);
        
    }];
    
}

- (void)requestTimesForFilter:(FerryFilter*)filter callback:(void (^)(NSDictionary* results))callbackBlock{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    [self.requestManager GET:[NSString stringWithFormat:@"my2/webservice/%@/%@/0", filter.selectedLocation.serverId, [formatter stringFromDate:filter.selectedDate]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        callbackBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        callbackBlock(nil);
        
    }];
    
}

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
        
        SINGLETON.requestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://www.fireisland.com/"]];
        AFHTTPResponseSerializer* serializer = SINGLETON.requestManager.responseSerializer;
        serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain", @"image/jpeg", @"image/jpg", @"image/png"]];
        [SINGLETON.requestManager setResponseSerializer:serializer];
        
        SINGLETON.imageRequestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://www.fireisland.com/"]];
        AFImageResponseSerializer* serializer2 = [AFImageResponseSerializer serializer];
        [SINGLETON.imageRequestManager setResponseSerializer:serializer2];
        
        SINGLETON.rawRequestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://www.fireisland.com/"]];
        AFHTTPResponseSerializer* serializer3 = [AFHTTPResponseSerializer serializer];
        [serializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"text/plain", nil]];
        [SINGLETON.rawRequestManager setResponseSerializer:serializer3];
        
       
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
    return [[HttpManager alloc] init];
}

- (id)mutableCopy
{
    return [[HttpManager alloc] init];
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
