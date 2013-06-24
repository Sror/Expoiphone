//
//  ExpoRegViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 08/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ExpoRegViewController.h"
#import "ActionSheetPicker.h"

@interface ExpoRegViewController ()

@end

@implementation ExpoRegViewController

@synthesize fullNameTextField,companyTxtField,genderTxtField,socialTxtField,dateOfBirthTxtField,IndustryTxtField;
@synthesize industrialArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setHidden:NO];
    
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMMM YYYY"];
    
    industrialArray =[[NSMutableArray alloc]init];
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];

    self.navigationItem.hidesBackButton = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [self.navigationController.navigationBar setHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)doneEditing{
    
    
    [fullNameTextField resignFirstResponder];
    [companyTxtField resignFirstResponder];
    [socialTxtField resignFirstResponder];
    [genderTxtField resignFirstResponder];
    [IndustryTxtField resignFirstResponder];
    [dateOfBirthTxtField resignFirstResponder];
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self doneEditing];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 13 ){
        
        [self doneEditing];
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Sex" message:@"Please select Gender" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Male",@"Female", nil];
        al.tag = 10;
        [al show];
        
          return NO; //hide keyboard
    }
    else if (textField.tag == 14){
        
        [self doneEditing];
        
       
         [self DatePickerView];
        
         return NO;
       
    }
    else if (textField.tag == 15){
        
        [self doneEditing];
        [self showActionSheet:textField];
        
         return NO;
    }
    else
        return YES; //show keyboard
}

-(void)showActionSheet:(id)sender{
    
    
    if (self.industrialArray.count==0) {
        
        [ApplicationDelegate.HUD show:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
        
        [ApplicationDelegate.appEngine industryCategoryList:@"" onCompletion:^(NSMutableArray *industryArray) {
            
            [ApplicationDelegate.HUD hide:YES];
            [self.navigationController.navigationBar setUserInteractionEnabled:YES];
            [self.industrialArray removeAllObjects];
            
            for (NSMutableDictionary *dic in industryArray) {
                [self.industrialArray addObject:[dic objectForKey:@"category"]];
                NSLog(@"the property dic=%@",dic);
            }
            
            ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                
                [self.IndustryTxtField setText:selectedValue];
                
            };
            ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
            };
            
            [ActionSheetStringPicker showPickerWithTitle:@"Select a Category" rows:self.industrialArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];

        } onError:^(NSError *error) {
            [ApplicationDelegate.HUD hide:YES];
            [self.navigationController.navigationBar setUserInteractionEnabled:YES];
            [UIAlertView showWithError:error];
        }];

        
    }else{
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            NSLog(@"Selected value is %@",selectedValue);
            [self.IndustryTxtField setText:selectedValue];
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        };
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Value" rows:self.industrialArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        if (buttonIndex == 1) {
            [self.genderTxtField setText:@"Male"];
        }else if (buttonIndex == 2){
            [self.genderTxtField setText:@"Female"];
        }
    }
    else if (alertView.tag == 20) {
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }else if (buttonIndex == 1){
            [self updatePlist];
        }
    }
    
}

-(void)DatePickerView
{
    pickerViewDate = [[UIActionSheet alloc] initWithTitle:nil
                                                 delegate:self
                                        cancelButtonTitle:nil
                                   destructiveButtonTitle:nil
                                        otherButtonTitles:nil];
    
    theDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    theDatePicker.datePickerMode = UIDatePickerModeDate;
    //[theDatePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    theDatePicker.maximumDate = [self logicalYearsAgo:[NSDate date] :YES];
    theDatePicker.minimumDate = [self logicalYearsAgo:[NSDate date] :NO];
    /*if ((birthdayTextField.text.length!=0)  && ![birthdayTextField.text isEqualToString:@"Not defined"]){
        [theDatePicker setDate:birthdate];
    }*/
    pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle=UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DatePickerDoneClick)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *closetn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(DatePickerCloseClick)];
    [barItems addObjectsFromArray:[NSArray arrayWithObjects:doneBtn,flexSpace,closetn, nil]];
    [pickerToolbar setItems:barItems animated:YES];
    [pickerViewDate addSubview:pickerToolbar];
    [pickerViewDate addSubview:theDatePicker];
    [pickerViewDate  showInView:self.view];
    [pickerViewDate setBounds:CGRectMake(0,0,320, 464)];
}


- (NSDate *)logicalYearsAgo:(NSDate *)from : (BOOL)start {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    if (start) {
        [offsetComponents setYear:-1];
    }
    else{
        [offsetComponents setYear:-120];
    }
    
    return [gregorian dateByAddingComponents:offsetComponents toDate:from options:0];
    
}

-(IBAction)DatePickerDoneClick{
    
    
     dateOfBirthTxtField.text = [dateFormatter stringFromDate:[theDatePicker date]];
    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    
}
-(IBAction)DatePickerCloseClick{
    

    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)updatePlist{
    
    NSMutableDictionary *dic= [[NSMutableDictionary alloc]init];
    [dic setValue:@"1" forKey:@"reg"];
    [[ConferenceHelper SharedHelper]WriteFromthePlistFile:dic toFile:@"RegView.plist"];
    [ApplicationDelegate showMainHomeView];
}


- (IBAction)skipBtnAction:(id)sender {
    
    [self updatePlist];
}

- (IBAction)submitBtnAction:(id)sender {
    
        
    if ([[ConferenceHelper SharedHelper]isEmptyString:self.fullNameTextField.text] || [[ConferenceHelper SharedHelper]isEmptyString:self.companyTxtField.text]   ||[[ConferenceHelper SharedHelper]isEmptyString:self.genderTxtField.text]    ||
        [[ConferenceHelper SharedHelper]isEmptyString:self.dateOfBirthTxtField.text] ||
        [[ConferenceHelper SharedHelper]isEmptyString:self.IndustryTxtField.text]||
        [[ConferenceHelper SharedHelper]isEmptyString:self.socialTxtField.text]) {
        NSLog(@"empty");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill up all fields before you submit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Skip Registration", nil];
        alertView.tag = 20;
        [alertView show];
        
    }
    else{
        
    [self updatePlist];
        
    
    }
}

-(NSMutableDictionary *)returnDicForSubmit{
    

    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    [dic setValue:@"Buy" forKey:@"username"];
    [dic setValue:@"Rent" forKey:@"SalesStatus"];
    [dic setValue:@"" forKey:@"type"];

    return dic;

}


@end
