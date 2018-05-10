//
//  SubmitBusinessListingViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 24/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "SubmitBusinessListingViewController.h"
#import "BusinessDirectoryCategory.h"
#import "HttpManager.h"

@interface SubmitBusinessListingViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) IBOutlet UIPickerView* pickerCategory;
@property (nonatomic, strong) IBOutlet UIButton* buttonSelectCategory;
@property (nonatomic, strong) IBOutlet UITextField* textFieldCategory;
@property (nonatomic, strong) IBOutlet UITextField* textFieldYourName;
@property (nonatomic, strong) IBOutlet UITextField* textFieldYourEmail;
@property (nonatomic, strong) IBOutlet UITextField* textFieldOrgName;
@property (nonatomic, strong) IBOutlet UITextView* textViewOrgDescription;
@property (nonatomic, strong) IBOutlet UITextField* textFieldKeywords;
@property (nonatomic, strong) IBOutlet UITextField* textFieldOrgWebsite;
@property (nonatomic, strong) IBOutlet UITextField* textFieldOrgPhone;
@property (nonatomic, strong) IBOutlet UITextField* textFieldOrgEmail;
@property (nonatomic, strong) IBOutlet UITextField* textFieldOrgAddress1;
@property (nonatomic, strong) IBOutlet UITextField* textFieldOrgAddress2;
@property (nonatomic, strong) IBOutlet UITextField* textFieldCity;
@property (nonatomic, strong) IBOutlet UITextField* textFieldState;
@property (nonatomic, strong) IBOutlet UITextField* textFieldZipCode;

@property (nonatomic, strong) NSArray* categories;
@property (nonatomic, strong) BusinessDirectoryCategory* selectedCategory;

@end

@implementation SubmitBusinessListingViewController

- (IBAction)submitClick:(id)sender{
    
    if(self.selectedCategory){
    
    self.activityIndicator.hidden = NO;
    [[HttpManager sharedInstance]postNewBusinessListing:@{
                                                          @"action" : @"AddListing",
                                                          @"category_id" : self.selectedCategory.categoryId,
                                                          @"name" : self.textFieldYourName.text,
                                                          @"email" : self.textFieldYourEmail.text,
                                                          @"cName" : self.textFieldOrgName.text,
                                                          @"description" : self.textViewOrgDescription.text,
                                                          @"keywords" : self.textFieldKeywords.text,
                                                          @"website" : self.textFieldOrgWebsite.text,
                                                          @"cEmail" : self.textFieldOrgEmail.text,
                                                          @"phone" : self.textFieldOrgPhone.text,
                                                          @"street1" : self.textFieldOrgAddress1.text,
                                                          @"street2" : self.textFieldOrgAddress2.text,
                                                          @"city" : self.textFieldCity.text,
                                                          @"state" : self.textFieldState.text,
                                                          @"zip" : self.textFieldZipCode.text,
                                                          @"country" : @"USA"
                                                          }
                                             completion:^(NSError* error){
                                                 if(error == nil){
                                                     [[[UIAlertView alloc]initWithTitle:@"Success" message:@"Thank you for your submission. It will appear in the directory shortly." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
                                                     [self dismissViewControllerAnimated:YES completion:nil];
                                                 }
                                                 else{
                                                     [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Sorry, the service is currently unavailable. Please check your network connection and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
                                                 }
                                             }
     ];
    }
    else{
          [[[UIAlertView alloc]initWithTitle:@"Please select a category" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.text.length >= 83){
        return NO;
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:    (NSString *)text {

    if(textView.text.length >= 83){
        return NO;
    }
    
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [self.textFieldKeywords becomeFirstResponder];
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == self.textFieldYourName){
        [self.textFieldYourEmail becomeFirstResponder];
    }
    else if (textField == self.textFieldYourEmail){
        [self.textFieldOrgName becomeFirstResponder];
    }
    else if (textField == self.textFieldOrgName){
        [self.textViewOrgDescription becomeFirstResponder];
    }
    else if (textField == self.textFieldKeywords){
        [self.textFieldOrgWebsite becomeFirstResponder];
    }
    else if (textField == self.textFieldOrgWebsite){
        [self.textFieldOrgPhone becomeFirstResponder];
    }
    else if (textField == self.textFieldOrgPhone){
        [self.textFieldOrgEmail becomeFirstResponder];
    }
    else if (textField == self.textFieldOrgEmail){
        [self.textFieldOrgAddress1 becomeFirstResponder];
    }
    else if (textField == self.textFieldOrgAddress1){
        [self.textFieldOrgAddress2 becomeFirstResponder];
    }
    else if (textField == self.textFieldOrgAddress2){
        [self.textFieldCity becomeFirstResponder];
    }
    else if (textField == self.textFieldCity){
        [self.textFieldState becomeFirstResponder];
    }
    else if (textField == self.textFieldState){
        [self.textFieldZipCode becomeFirstResponder];
    }
    else if (textField == self.textFieldZipCode){
        [self.view endEditing:YES];
    }    
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = [BusinessDirectoryCategory fetchAllBusinessDirectories];
    
    self.textFieldCategory.inputView = self.pickerCategory;
    self.textFieldCategory.inputAccessoryView = self.buttonSelectCategory;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return ((BusinessDirectoryCategory*)self.categories[row]).categoryName;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadSelectedCategory{
    
    self.textFieldCategory.text = self.selectedCategory.categoryName;
        
}

- (IBAction)chooseCategory:(id)sender{
    
    self.selectedCategory = self.categories[[self.pickerCategory selectedRowInComponent:0]];
    [self.view endEditing:YES];
    [self loadSelectedCategory];
    
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
