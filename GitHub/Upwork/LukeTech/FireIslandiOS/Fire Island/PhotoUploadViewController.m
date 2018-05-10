//
//  PhotoUploadViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 22/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "PhotoUploadViewController.h"
#import "FerryLocationManager.h"
#import "FerryLocation.h"
#import "HttpManager.h"
#import <Social/Social.h>

@interface PhotoUploadViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView* imageViewPreview;
@property (nonatomic, strong) IBOutlet UITextField* textFieldCaption;
@property (nonatomic, strong) IBOutlet UITextField* textFieldName;
@property (nonatomic, strong) IBOutlet UITextField* textFieldLocation;
@property (nonatomic, strong) IBOutlet UIPickerView* pickerViewLocations;
@property (nonatomic, strong) IBOutlet UISwitch* switchFacebook;
@property (nonatomic, strong) IBOutlet UISwitch* switchTwitter;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityView;

@property (nonatomic, strong) NSArray* locationsList;

@end

@implementation PhotoUploadViewController

- (IBAction)uploadClick:(id)sender{
    
    self.activityView.hidden = NO;
    
    NSString *captionString = [NSString stringWithFormat:@"%@%@%@", self.textFieldCaption.text, self.textFieldName.text.length ? [NSString stringWithFormat:@" by %@", self.textFieldName.text] : @"",  self.textFieldLocation.text.length ? [NSString stringWithFormat:@" from %@", self.textFieldLocation.text] : @""];
    
    [[HttpManager sharedInstance]uploadPicture:self.imageToSend withCaption:captionString completion:^(NSError* error){

        self.activityView.hidden = YES;
        
        if(error){
            [[[UIAlertView alloc]initWithTitle:@"Upload error" message:[NSString stringWithFormat:@"Please try again. Error code %@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
        }
        else {
            
            [[[UIAlertView alloc]initWithTitle:@"Upload successful" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
            
            if(self.switchFacebook.isOn){
                [self postToFB];
            }
            else if(self.switchTwitter.isOn){
                [self postToTwitter];
            }
            else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
    
}

- (void)postToFB{
    SLComposeViewController *sheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeFacebook];
    [sheet setInitialText:@"I've just uploaded a new image to fireisland.com from my iPhone!"];
    [sheet addImage:self.imageToSend];
    sheet.completionHandler = ^(SLComposeViewControllerResult result){
        if(self.switchTwitter.isOn){
            [self performSelector:@selector(postToTwitter) withObject:nil afterDelay:0.2];
        }
        else{
            [self performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:@YES afterDelay:0.2];
        }
    };
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)postToTwitter{
    SLComposeViewController *sheet = [SLComposeViewController
                                      composeViewControllerForServiceType:SLServiceTypeTwitter];
    [sheet setInitialText:@"I've just uploaded a new image to fireisland.com from my iPhone!"];
    [sheet addImage:self.imageToSend];
    sheet.completionHandler = ^(SLComposeViewControllerResult result){
        [self performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:@YES afterDelay:0.2];
    };
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationsList = [FerryLocationManager allFerryLocations];

    self.imageViewPreview.image = self.imageToSend;
    self.textFieldName.text = [[UIDevice currentDevice] name];
    self.textFieldLocation.inputView = self.pickerViewLocations;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.textFieldLocation.text = [self pickerView:pickerView titleForRow:row forComponent:component];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.locationsList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return ((FerryLocation*)self.locationsList[row]).end;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
