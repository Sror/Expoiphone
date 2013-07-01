//
//  ConfEventSearchViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 16/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppDelegate.h"
#import "ConfMainViewController.h"

@class AbstractActionSheetPicker;

@interface ConfEventSearchViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDelegate>{
    
    
    UIDatePicker *theDatePicker;
    UIToolbar* pickerToolbar;
    UIActionSheet* pickerViewDate;
    NSDateFormatter *dateFormatter;
    
}


@property (nonatomic) int textFieldInt;

@property (strong, nonatomic) IBOutlet UITextField *keywordTxtField;
@property (strong, nonatomic) IBOutlet UITextField *upcomingEventTxtField;
@property (strong, nonatomic) IBOutlet UITextField *industrialTxtField;
@property (strong, nonatomic) IBOutlet UITextField *dateTxtField;

@property (strong, nonatomic) IBOutlet UITextField *endDateTxtField;

@property (nonatomic, retain) NSMutableArray *industrialArray;
@property (nonatomic, retain) NSMutableArray *eventTypeArray;

- (IBAction)homeBtnAction:(id)sender;
- (IBAction)submitBtnAction:(id)sender;


@end
