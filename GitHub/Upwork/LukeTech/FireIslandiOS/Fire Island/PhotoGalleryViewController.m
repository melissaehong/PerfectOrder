//
//  PhotoGalleryViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 19/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "PhotoGalleryViewController.h"
#import "DataManager.h"
#import "GalleryCategory.h"
#import "GalleryImage.h"
#import "AsyncImageCollectionViewCell.h"
#import "PhotoUploadViewController.h"

@interface PhotoGalleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView* collectionViewThumbnails;
@property (nonatomic, strong) IBOutlet UICollectionView* collectionViewDetail;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) IBOutlet UIButton* buttonShare;
@property (nonatomic, strong) IBOutlet UIButton* buttonUpload;
@property (nonatomic, strong) NSArray* galleries;
@property (nonatomic, strong) NSMutableArray* images;

@end

@implementation PhotoGalleryViewController

- (IBAction)unwindToPhotos:(UIStoryboardSegue*)sender{
    
}

- (IBAction)shareClick:(id)sender{
    
    GalleryImage* imageToShare = self.images[[[self.collectionViewDetail indexPathsForVisibleItems][0] row]];
    
    UIImage* detailImage = [[DataManager sharedInstance]cachedMainImageFor:imageToShare];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[@"Check out this Fire Island picture from the Fire Island iPhone App", imageToShare.name,detailImage]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *presentationController =
    [controller popoverPresentationController];
    
    presentationController.sourceView = self.view;

}

- (IBAction)uploadClick:(id)sender{
    [[[UIActionSheet alloc]initWithTitle:@"Choose Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Roll", @"Camera", nil]showFromTabBar:self.tabBarController.tabBar];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex != actionSheet.cancelButtonIndex){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        if([[actionSheet buttonTitleAtIndex:buttonIndex] containsString:@"Camera"]){
            
            if(!([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])){
                return;
            }
            
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else{
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
       
        imagePickerController.delegate = self;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"photoUploader" sender:[info valueForKey:UIImagePickerControllerOriginalImage]];
    }];

    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.images = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[DataManager sharedInstance] fetchImageGalleriesLocalCallback:^(NSArray *galleries) {
        
        if(!galleries || !galleries.count){
            
            [[DataManager sharedInstance] fetchImageGalleriesCallback:^(NSArray *galleries) {
                self.galleries = galleries;
                
                [self fetchImages];
            }];
            
            return;
        }
        
        self.galleries = galleries;
        
        [self fetchImages];
    }];

}

- (void)fetchImages{
    for(GalleryCategory* gc in self.galleries){
        [[DataManager sharedInstance]fetchImagesForGallery:gc callback:^(NSArray *fetchedImages) {
            
            for(GalleryImage* gi in fetchedImages){
                
                if(![self.images containsObject:gi]){
                    
                    [self.images addObject:gi];
                    
                }
                
            }
            
            [self.images sortUsingComparator:^NSComparisonResult(GalleryImage* obj1, GalleryImage* obj2) {
                return [obj1.imageId integerValue] < [obj2.imageId integerValue];
            }];
            
            [self.collectionViewThumbnails reloadData];
            [self.collectionViewDetail reloadData];
            
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView == self.collectionViewDetail){
        return collectionView.frame.size;
    }
    return CGSizeMake(100, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AsyncImageCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    if(collectionView == self.collectionViewThumbnails){
        cell.isThumbnail = YES;
    }
    else{
        cell.isThumbnail = NO;
    }

    cell.selectedImage = self.images[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(collectionView == self.collectionViewThumbnails){
        
        self.collectionViewDetail.alpha = 0.0;
        self.collectionViewDetail.hidden = NO;
        [self.collectionViewDetail scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        [UIView animateWithDuration:0.3 animations:^{
            self.collectionViewDetail.alpha = 1.0;
        }];
 
        self.buttonShare.hidden = NO;
        self.buttonUpload.hidden = YES;
        
    }
    else if(collectionView == self.collectionViewDetail){
        
        [UIView animateWithDuration:0.3 animations:^{
            self.collectionViewDetail.alpha = 0.0;
        }completion:^(BOOL finished) {
            self.collectionViewDetail.hidden = YES;
        }];
        
        self.buttonShare.hidden = YES;
        self.buttonUpload.hidden = NO;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.images.count < 1){
        self.activityIndicator.hidden = NO;
    }
    else{
        self.activityIndicator.hidden = YES;
    }
    
    return self.images.count;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"photoUploader"]){
        ((PhotoUploadViewController*) segue.destinationViewController).imageToSend = sender;
    }
}


@end
