//
//  ConfEventSearchViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 16/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConfEventSearchViewController.h"

#import "ActionSheetPicker.h"

@interface ConfEventSearchViewController ()

@end

@implementation ConfEventSearchViewController

@synthesize industrialTxtField,upcomingEventTxtField,dateTxtField,keywordTxtField;
@synthesize industrialArray,eventTypeArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        industrialArray = [[NSMutableArray alloc]init];
        eventTypeArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Events Search"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];
    
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMMM YYYY"];
    
    eventTypeArray = [[NSMutableArray alloc]initWithObjects:@"Upcoming event",@"Sarted Event",@"Test Event",@"End of Event", nil];
    
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:@"Loading"];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
    self.keywordTxtField.leftView = paddingView;
    self.keywordTxtField.leftViewMode = UITextFieldViewModeAlways;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[[UIToolbar appearance] setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
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
    theDatePicker.maximumDate = [self logicalYearsAgo:[NSDate date] :YES];
    theDatePicker.minimumDate = [self logicalYearsAgo:[NSDate date] :NO];
    pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle=UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DatePickerDoneClick)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *closetn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(DatePickerCloseClick)];
    [barItems addObjectsFromArray:[NSArray arrayWithObjects:closetn,flexSpace,doneBtn, nil]];
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
    
    
    dateTxtField.text = [dateFormatter stringFromDate:[theDatePicker date]];
    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
    
}
-(IBAction)DatePickerCloseClick{
    
    
    [pickerViewDate dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    BOOL isTouched = NO;
    for (UIView *view in self.view.subviews) {
        
        if (touch.view == view){
            isTouched = YES;
        }
    }
    if (!isTouched){
        [self.keywordTxtField resignFirstResponder];
        //[self.password resignFirstResponder];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    return YES;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.keywordTxtField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 11){
        [self.keywordTxtField resignFirstResponder];
        [self showActionSheetwithTextField:NO :textField];
        
        
             return NO; //hide keyboard
    }
    else if (textField.tag == 12){
        [self.keywordTxtField resignFirstResponder];
        [self showActionSheetwithTextField:YES :textField];
           return NO;
        
    }
    else if (textField.tag == 13){
        [self.keywordTxtField resignFirstResponder];
        
        [self DatePickerView];
        
        return NO;
    }
    else
        return YES; //show keyboard
}

-(void)showActionSheetwithTextField:(BOOL)isIndustry:(id)sender{
    
    if (isIndustry) {
    
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
                
                [self.industrialTxtField setText:selectedValue];
                
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
            [self.industrialTxtField setText:selectedValue];
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        };
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a category" rows:self.industrialArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    }
    }else{
        
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            NSLog(@"Selected value is %@",selectedValue);
            [self.upcomingEventTxtField setText:selectedValue];
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        };
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Value" rows:self.eventTypeArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    }
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeBtnAction:(id)sender {
    
    ConfMainViewController *cfMainView= [[ConfMainViewController alloc]initWithNibName:@"ConfMainViewController" bundle:nil];
    [self.navigationController pushFadeViewController:cfMainView];
    
}

- (IBAction)submitBtnAction:(id)sender {
    
    
}
@end
