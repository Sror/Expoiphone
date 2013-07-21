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
@synthesize industrialArray,fromView;

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
    
    //[self.view addSubview:ApplicationDelegate.dragView];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMMM YYYY"];
    
    industrialArray =[[NSMutableArray alloc]init];
    

    [self.view addSubview:ApplicationDelegate.HUD];
    
    self.navigationItem.hidesBackButton = YES;
    
    if (fromView) {
       // [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    }
    [self applyFonts];
}
-(void)applyFonts{
    
    [self.fullNameTextField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.companyTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.genderTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.dateOfBirthTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.IndustryTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.socialTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.mobileTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.skipBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    [self.submitBtn.titleLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:15.0]];
    
    
    // [UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1]
    
    [self.skipBtn.titleLabel setTextColor:[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1]];
    [self.submitBtn.titleLabel setTextColor:[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1]];
    
}


- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSLog(@"called");
    return [emailTest evaluateWithObject:candidate];
}
-(void)applyLanguage{
    
    
    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 1434) {
            [vie removeFromSuperview];
            NSLog(@"Title view removed in regView");
        }
    }
    
    
    if (fromView) {
        [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"regForm"]]];
    }
         else{
     [self.navigationItem setTitleView:[ApplicationDelegate setTitleForViews:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"regForm"]]];
         }
    
    [self.skipBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"skip"] forState:UIControlStateNormal];
    [self.submitBtn setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"submit"] forState:UIControlStateNormal];
    
    [self.fullNameTextField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"fname"]];
    [self.companyTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"email"]];
    [self.mobileTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"mobile"]];
    [self.genderTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sex"]];
    [self.dateOfBirthTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"dob"]];
    [self.IndustryTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"indInterest"]];
    [self.socialTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sStatus"]];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshView:(NSNotification *) notification{
    
    NSLog(@"Notification");
    
    [self applyLanguage];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    [self applyLanguage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    
    if (fromView) {
        [self.skipBtn setHidden:YES];
        [self.submitBtn setFrame:CGRectMake(121, 335, 80, 33)];
         //[[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    }
}

- (void)doneEditing{
    
    
    [fullNameTextField resignFirstResponder];
    [companyTxtField resignFirstResponder];
    [socialTxtField resignFirstResponder];
    [genderTxtField resignFirstResponder];
    [IndustryTxtField resignFirstResponder];
    [dateOfBirthTxtField resignFirstResponder];
    [self.mobileTxtField resignFirstResponder];
    
    
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
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"sex"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectGender"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"cancel"] otherButtonTitles:@"Male",@"Female", nil];
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
        [ApplicationDelegate.HUD setLabelText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"loading"]];

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
            
            [ActionSheetStringPicker showPickerWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectCategory"] rows:self.industrialArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];

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
    
        
    if ([[ConferenceHelper SharedHelper]isEmptyString:self.fullNameTextField.text] ||[[ConferenceHelper SharedHelper]isEmptyString:self.genderTxtField.text]    ||
        [[ConferenceHelper SharedHelper]isEmptyString:self.dateOfBirthTxtField.text] ||
        [[ConferenceHelper SharedHelper]isEmptyString:self.IndustryTxtField.text]||
        [[ConferenceHelper SharedHelper]isEmptyString:self.socialTxtField.text] ||
        [[ConferenceHelper SharedHelper]isEmptyString:self.socialTxtField.text] ||
        [[ConferenceHelper SharedHelper]isEmptyString:self.companyTxtField.text]) {
        NSLog(@"empty");
        
        if (!fromView) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"error"] message:@"Please fill up all fields before you submit" delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"skipReg"], nil];
            alertView.tag = 20;
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"fillAllBeforeSubmit"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
    
    else if (![self validateEmail:companyTxtField.text]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"error"] message:@"Enter a valid Email" delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"]otherButtonTitles:nil];
        [alert show];
    }
    else{

        NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
        [userDic setValue:self.fullNameTextField.text forKey:@"fullname"];
        [userDic setValue:self.genderTxtField.text forKey:@"sex"];
        [userDic setValue:self.dateOfBirthTxtField.text forKey:@"dob"];
        [userDic setValue:self.IndustryTxtField.text forKey:@"industry"];
        [userDic setValue:self.socialTxtField.text forKey:@"socialstatus"];
        [userDic setValue:self.companyTxtField.text forKey:@"email"];
        [userDic setValue:self.mobileTxtField.text forKey:@"mobile"];
        [userDic setValue:@"" forKey:@"username"];
        [userDic setValue:@"" forKey:@"password"];

        [ApplicationDelegate.HUD setLabelText:@"Saving"];
        [ApplicationDelegate.HUD show:YES];
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
        
        [ApplicationDelegate.appEngine addUserProfile:userDic onCompletion:^(NSMutableDictionary *userProfileResponseDic) {
            NSLog(@"userProfileResponseDic is %@",userProfileResponseDic);
            
            [ApplicationDelegate.HUD hide:YES];
            [self.navigationController.navigationBar setUserInteractionEnabled:YES];
            if (!fromView) {
                [self updatePlist];
                NSLog(@"Plist entered");
            }
            
        } onError:^(NSError *error) {
            [ApplicationDelegate.HUD hide:YES];
            [self.navigationController.navigationBar setUserInteractionEnabled:YES];
            [UIAlertView showWithError:error];
        }];

    
    }
}

- (IBAction)viewTouchBtnAction:(id)sender {
    
    for (UIView *vie in self.navigationController.view.subviews) {
        if (vie.tag==DRAGVIEWTAG) {
            [UIView animateWithDuration:0.7 animations:^{
                [vie setFrame:CGRectMake(247, 0, 73, 58)];
                [vie setAlpha:0.0];
            } completion:^(BOOL finished) {
                [vie removeFromSuperview];
                [ApplicationDelegate set_dragged:NO];
            }];
        }
    }
}



-(void)stopThari{
    
    [ApplicationDelegate.HUD hide:YES];
    
   /* UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Search Event" message:@"No results found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];*/
    
}

-(NSMutableDictionary *)returnDicForSubmit{
    

    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    [dic setValue:@"Buy" forKey:@"username"];
    [dic setValue:@"Rent" forKey:@"SalesStatus"];
    [dic setValue:@"" forKey:@"type"];

    return dic;

}


- (void)viewDidUnload {
    [self setScrollViewReg:nil];
    [self setMobileTxtField:nil];
    [super viewDidUnload];
}
@end
