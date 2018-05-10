//
//  FirstViewController.m
//  Fire Island
//
//  Created by Peter Rocker on 16/06/2015.
//  Copyright (c) 2015 Motive Interactive. All rights reserved.
//

#import "SchedulesViewController.h"
#import "FerryFilter.h"
#import "FerryLocation.h"
#import "FerryLocationManager.h"
#import "FerryTimeTableViewCell.h"
#import "DataManager.h"
#import "FerryTime.h"

@interface SchedulesViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel* labelDirection1;
@property (nonatomic, strong) IBOutlet UILabel* labelDirection2;
@property (nonatomic, strong) IBOutlet UILabel* labelFerryFrom;
@property (nonatomic, strong) IBOutlet UITextField* textFieldFerrySelect;
@property (nonatomic, strong) IBOutlet UITextField* textFieldDateSelect;
@property (nonatomic, strong) IBOutlet UIPickerView* pickerFerrySelect;
@property (nonatomic, strong) IBOutlet UIDatePicker* pickerDateSelect;
@property (nonatomic, strong) IBOutlet UITableView* tableView1;
@property (nonatomic, strong) IBOutlet UIImageView* imageViewDirection1;
@property (nonatomic, strong) IBOutlet UIImageView* imageViewDirection2;
@property (nonatomic, strong) IBOutlet UIImageView* imageViewBg;
@property (nonatomic, strong) IBOutlet UIButton* buttonFerryDone;
@property (nonatomic, strong) IBOutlet UIButton* buttonDateDone;
@property (nonatomic, strong) IBOutlet UIButton* buttonSwitch;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityView;
@property (nonatomic, strong) IBOutlet UILabel* labelPlaceholder;

@property (nonatomic, strong) FerryFilter* currentFilter;
@property (nonatomic, strong) NSArray* allFerryLocations;
@property (nonatomic, strong) NSArray* fetchedTimes;

@property CGRect locationDirectionFrame1;
@property CGRect locationDirectionFrame2;

@end

@implementation SchedulesViewController

- (IBAction)dateDoneClick:(id)sender{
    self.currentFilter.selectedDate = self.pickerDateSelect.date;
    [self.view endEditing:YES];
    [self applyCurrentFilter];
}

- (IBAction)ferryDoneClick:(id)sender{
    self.currentFilter.selectedLocation = self.allFerryLocations[[self.pickerFerrySelect selectedRowInComponent:0]];
    [self.view endEditing:YES];
    [self applyCurrentFilter];
}

- (IBAction)reverseButtonClick:(id)sender{
    self.currentFilter.isReverse = !self.currentFilter.isReverse;
    [self applyCurrentFilter];
}

- (void)applyCurrentFilter{
    
    [self.currentFilter writeToUserDefaults];
    
    self.imageViewDirection1.hidden = YES;
    self.imageViewDirection2.hidden = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        if(self.currentFilter.isReverse){
            self.labelFerryFrom.frame = CGRectMake(self.locationDirectionFrame2.origin.x, self.locationDirectionFrame2.origin.y, self.locationDirectionFrame2.size.width, self.locationDirectionFrame2.size.height);
            self.textFieldFerrySelect.frame = CGRectMake(self.locationDirectionFrame1.origin.x, self.locationDirectionFrame1.origin.y, self.locationDirectionFrame1.size.width, self.locationDirectionFrame1.size.height);
        }
        else{
            self.labelFerryFrom.frame = CGRectMake(self.locationDirectionFrame1.origin.x, self.locationDirectionFrame1.origin.y, self.locationDirectionFrame1.size.width, self.locationDirectionFrame1.size.height);
            self.textFieldFerrySelect.frame = CGRectMake(self.locationDirectionFrame2.origin.x, self.locationDirectionFrame2.origin.y, self.locationDirectionFrame2.size.width, self.locationDirectionFrame2.size.height);
        }
        
    } completion:^(BOOL finished) {
        if(self.currentFilter.isReverse){
            self.imageViewDirection1.hidden = NO;
            self.imageViewDirection2.hidden = YES;
        }
        else{
            self.imageViewDirection1.hidden = YES;
            self.imageViewDirection2.hidden = NO;
        }
        
    }];
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    self.textFieldDateSelect.text = [formatter stringFromDate:self.currentFilter.selectedDate];
    
    self.labelFerryFrom.text = self.currentFilter.selectedLocation.start;
    self.textFieldFerrySelect.text = self.currentFilter.selectedLocation.end;
    
    self.activityView.hidden = NO;
    self.fetchedTimes = nil;
    [self.tableView1 reloadData];
    self.labelPlaceholder.hidden = YES;
    
    [[DataManager sharedInstance]requestFerryScheduleForFilter:self.currentFilter callback:^(NSArray *results, bool fromWebservice) {
        
        if(!fromWebservice){
            if(!results || !results.count){
                //it's no problem - we are still waiting for the webservice to return
            }
            else{
                self.fetchedTimes = results;
                [self.tableView1 reloadData];
                self.activityView.hidden = YES;
            }
        }
        else{
            
            if(!results || !results.count){
                if(!self.fetchedTimes){
                    self.labelPlaceholder.hidden = NO;
                }
            }
            else{
                self.fetchedTimes = results;
                [self.tableView1 reloadData];
            }
            
            self.activityView.hidden = YES;
        }
        
    }];

    
}

#pragma mark - VC lifecycle

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.locationDirectionFrame1 = CGRectMake(self.labelDirection1.frame.origin.x, self.labelDirection1.frame.origin.y, self.buttonSwitch.frame.origin.x - (self.labelDirection1.frame.origin.x ) - 8, self.labelDirection1.frame.size.height);
    self.locationDirectionFrame2 = CGRectMake(self.labelDirection2.frame.origin.x, self.labelDirection2.frame.origin.y, self.buttonSwitch.frame.origin.x - (self.labelDirection2.frame.origin.x) - 8, self.labelDirection2.frame.size.height);
    
    if(self.currentFilter.isReverse){
        self.labelFerryFrom.frame = CGRectMake(self.locationDirectionFrame2.origin.x, self.locationDirectionFrame2.origin.y, self.locationDirectionFrame2.size.width, self.locationDirectionFrame2.size.height);
        self.textFieldFerrySelect.frame = CGRectMake(self.locationDirectionFrame1.origin.x, self.locationDirectionFrame1.origin.y, self.locationDirectionFrame1.size.width, self.locationDirectionFrame1.size.height);
    }
    else{
        self.labelFerryFrom.frame = CGRectMake(self.locationDirectionFrame1.origin.x, self.locationDirectionFrame1.origin.y, self.locationDirectionFrame1.size.width, self.locationDirectionFrame1.size.height);
        self.textFieldFerrySelect.frame = CGRectMake(self.locationDirectionFrame2.origin.x, self.locationDirectionFrame2.origin.y, self.locationDirectionFrame2.size.width, self.locationDirectionFrame2.size.height);
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.allFerryLocations = [FerryLocationManager allFerryLocations];
    self.currentFilter = [[FerryFilter alloc]initFromUserDefaults];
    
    self.textFieldFerrySelect.inputView = self.pickerFerrySelect;
    self.textFieldFerrySelect.inputAccessoryView = self.buttonFerryDone;
    self.textFieldDateSelect.inputView = self.pickerDateSelect;
    self.textFieldDateSelect.inputAccessoryView = self.buttonDateDone;    
    
    UIView *view = [[self.pickerDateSelect subviews] objectAtIndex:0];
    [view setBackgroundColor:[UIColor whiteColor]];

    
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effectView.frame = self.view.frame;
//    [self.imageViewBg addSubview:effectView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self applyCurrentFilter];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView protocols

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.allFerryLocations.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return ((FerryLocation*)self.allFerryLocations[row]).end;
}

#pragma mark - UITableView protocols

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchedTimes.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FerryTimeTableViewCell* cell = [self.tableView1 dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    FerryTime* theTime = self.fetchedTimes[indexPath.row];
    
    cell.labelTime.text = theTime.time;
    cell.labelNotes.text = theTime.note;
    
    return cell;
}


@end
