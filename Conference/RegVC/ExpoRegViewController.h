//
//  ExpoRegViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+Push.h"

@class TPKeyboardAvoidingScrollView;
@class AbstractActionSheetPicker;

@interface ExpoRegViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate>{
    
    
    UIDatePicker *theDatePicker;
    UIToolbar* pickerToolbar;
    UIActionSheet* pickerViewDate;
    NSDateFormatter *dateFormatter;
}

@property (strong, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *companyTxtField;
@property (strong, nonatomic) IBOutlet UITextField *socialTxtField;
@property (strong, nonatomic) IBOutlet UITextField *genderTxtField;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirthTxtField;
@property (strong, nonatomic) IBOutlet UITextField *IndustryTxtField;

@property (nonatomic, retain) NSMutableArray *industrialArray;

@property (nonatomic, retain) AbstractActionSheetPicker *actionSheetPicker;

- (IBAction)skipBtnAction:(id)sender;
- (IBAction)submitBtnAction:(id)sender;

@end
