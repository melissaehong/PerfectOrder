//
//  AsyncImageCollectionViewCell.h
//  Fire Island
//
//  Created by Peter Rocker on 19/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GalleryImage;

@interface AsyncImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView* imageViewThumbnail;
@property (nonatomic, strong) IBOutlet UILabel* notesLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) GalleryImage* selectedImage;
@property BOOL isThumbnail;

@end
