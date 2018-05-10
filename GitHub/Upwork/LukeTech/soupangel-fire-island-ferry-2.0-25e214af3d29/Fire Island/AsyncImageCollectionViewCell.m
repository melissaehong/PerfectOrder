//
//  AsyncImageCollectionViewCell.m
//  Fire Island
//
//  Created by Peter Rocker on 19/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "AsyncImageCollectionViewCell.h"
#import "DataManager.h"
#import "GalleryImage.h"

@implementation AsyncImageCollectionViewCell

- (void)setSelectedImage:(GalleryImage *)selectedImage{
    
    _selectedImage = selectedImage;
    
    self.notesLabel.text = _selectedImage.name;
    
    UIImage* cachedImage;
    
    if(self.isThumbnail){
        cachedImage = [[DataManager sharedInstance]cachedThumbnailImageFor:selectedImage];
    }
    else{
        cachedImage = [[DataManager sharedInstance]cachedMainImageFor:selectedImage];
    }
    
    if(cachedImage){
        self.imageViewThumbnail.image = cachedImage;
        self.activityIndicator.hidden = YES;
    }
    else{
        self.imageViewThumbnail.image = nil;
        self.activityIndicator.hidden = NO;
        
        if(self.isThumbnail){
            [[DataManager sharedInstance]downloadThumbnailImageFor:selectedImage callback:^(GalleryImage *retImage) {
                if([retImage.imageId integerValue] == [self.selectedImage.imageId integerValue]){
                    UIImage* cachedImage = [[DataManager sharedInstance]cachedThumbnailImageFor:selectedImage];
                    if(cachedImage){
                        self.imageViewThumbnail.image = cachedImage;
                    }
                    self.activityIndicator.hidden = YES;
                }
            }];
        }
        else{
            
            self.imageViewThumbnail.image = [[DataManager sharedInstance]cachedThumbnailImageFor:selectedImage];
            
            [[DataManager sharedInstance]downloadMainImageFor:selectedImage callback:^(GalleryImage *retImage) {
                if([retImage.imageId integerValue] == [self.selectedImage.imageId integerValue]){
                    UIImage* cachedImage = [[DataManager sharedInstance]cachedMainImageFor:selectedImage];
                    if(cachedImage){
                        self.imageViewThumbnail.image = cachedImage;
                    }
                    self.activityIndicator.hidden = YES;
                }
            }];
            

        }
       
    }
    
}

@end
