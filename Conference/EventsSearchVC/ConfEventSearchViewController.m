//
//  ConfEventSearchViewController.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 16/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConfEventSearchViewController.h"

#import "ActionSheetPicker.h"
#import "ExpoEventsViewController.h"

@interface ConfEventSearchViewController ()

@end

@implementation ConfEventSearchViewController

@synthesize industrialTxtField,upcomingEventTxtField,dateTxtField,keywordTxtField;
@synthesize industrialArray,eventTypeArray,searchResultsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        industrialArray = [[NSMutableArray alloc]init];
        eventTypeArray = [[NSMutableArray alloc]init];
        searchResultsArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   /* [self.navigationItem setTitleView:[ApplicationDelegate setTitle:@"Events Search"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[ApplicationDelegate customBackBtn]]];*/
    
    self.navigationItem.hidesBackButton = YES;
    
    
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMMM YYYY"];
    
    
    
    
    [self.view addSubview:ApplicationDelegate.HUD];
    [ApplicationDelegate.HUD setLabelText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"searching"]];
    
   /* UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
    self.keywordTxtField.leftView = paddingView;
    self.keywordTxtField.leftViewMode = UITextFieldViewModeAlways;*/
    
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self applyFonts];
}

-(void)applyFonts{
    [self.upcomingEventTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.keywordTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.industrialTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.dateTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.endDateTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    
    [self.arabEventTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.arabIndustryTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.arabStartTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.arabEndTxtField setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    
    [self.homeLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:9.0]];
    [self.submitBtn.titleLabel setTextColor:[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1]];
    
    [self.keywordTxtField setValue:[UIColor blackColor]
                    forKeyPath:@"_placeholderLabel.textColor"];

    [self.upcomingEventTxtField setValue:[UIColor blackColor]
                    forKeyPath:@"_placeholderLabel.textColor"];

    [self.dateTxtField setValue:[UIColor blackColor]
                    forKeyPath:@"_placeholderLabel.textColor"];

    [self.endDateTxtField setValue:[UIColor blackColor]
                    forKeyPath:@"_placeholderLabel.textColor"];

    [self.industrialTxtField setValue:[UIColor blackColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    
    
    

    //[self.skipBtn.layer setBorderColor: [[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
    [self.submitBtn.layer setBorderColor: [[UIColor colorWithRed:(60.0f/255.0f) green:(115.0f/255.0f) blue:(171.0f/255.0f) alpha:1] CGColor]];
    [self.submitBtn.layer setBorderWidth:1.0];
    //[self.skipBtn.layer setBorderWidth:1.0];
    //[self.skipBtn.layer setCornerRadius:8.0f];
    [self.submitBtn.layer setCornerRadius:8.0f];

    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
    [self updateUI];
    
    //[[UIToolbar appearance] setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
}
-(void)refreshView:(NSNotification *) notification{
    
    [self updateUI];
}


-(void)updateUI{
    
    for (UIView *vie in self.navigationController.navigationBar.subviews) {
        if (vie.tag == 143) {
            [vie removeFromSuperview];
        }
    }
    
    
    switch (ApplicationDelegate.langBool) {
        case LANG_English:
            [self.arabView setHidden:YES];
            [self.engView setHidden:NO];
            
            break;
        case LANG_ARABIC:
            [self.arabView setHidden:NO];
            [self.engView setHidden:YES];
            [self.arabIndustryTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"indInterest"]];
            [self.arabEventTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"upcomingEvent"]];
            [self.arabEndTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"startdate"]];
            [self.arabStartTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"enddate"]];
            break;
        default:
            break;
    }
    
      
    [self.navigationItem setTitleView:[ApplicationDelegate setTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"eventssearch"]]];
    eventTypeArray = [[NSMutableArray alloc]initWithObjects:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"upcomingEvent"],[[ConferenceHelper SharedHelper] getLanguageForAKey:@"currentevent"], nil];
    [self.submitBtn.titleLabel setText:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"submit"]];
    [self.keywordTxtField setPlaceholder:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"entersearchkeyword"]]; 
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar_bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
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
    
    if ([self textFieldInt]==13) {
         dateTxtField.text = [dateFormatter stringFromDate:[theDatePicker date]];
    }
    else{
        self.endDateTxtField.text = [dateFormatter stringFromDate:[theDatePicker date]];
    }
   
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
        
        [self setTextFieldInt:13];
        [self.keywordTxtField resignFirstResponder];
        
        [self DatePickerView];
        
        return NO;
    }
    else if (textField.tag == 14){
        
        [self setTextFieldInt:14];
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
            
            [ActionSheetStringPicker showPickerWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectCategory"] rows:self.industrialArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
            
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
        
        [ActionSheetStringPicker showPickerWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectCategory"] rows:self.industrialArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    }
    }else{
        
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            NSLog(@"Selected value is %@",selectedValue);
            [self.upcomingEventTxtField setText:selectedValue];
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        };
        
        [ActionSheetStringPicker showPickerWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"selectavalue"] rows:self.eventTypeArray initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
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
        
   /* [ApplicationDelegate.HUD show:YES];
    [self performSelector:@selector(stopThari) withObject:nil afterDelay:3.0];*/
    
    [ApplicationDelegate.HUD show:YES];
    [self.navigationController.toolbar setUserInteractionEnabled:NO];
    
    
    NSMutableDictionary *searcDic = [[NSMutableDictionary alloc]init];
    switch (ApplicationDelegate.langBool) {
        case LANG_English:
            [searcDic setValue:self.keywordTxtField.text forKey:@"keyword"];
            [searcDic setValue:self.upcomingEventTxtField.text forKey:@"upcoming"];
            [searcDic setValue:self.industrialTxtField.text forKey:@"industry_category"];
            [searcDic setValue:self.dateTxtField.text forKey:@"date_start"];
            [searcDic setValue:self.endDateTxtField.text forKey:@"date_end"];
            
            break;
        case LANG_ARABIC:
            [searcDic setValue:self.keywordTxtField.text forKey:@"keyword"];
            [searcDic setValue:self.arabEventTxtField.text forKey:@"upcoming"];
            [searcDic setValue:self.arabIndustryTxtField.text forKey:@"industry_category"];
            [searcDic setValue:self.arabStartTxtField.text forKey:@"date_start"];
            [searcDic setValue:self.arabEndTxtField.text forKey:@"date_end"];
            break;
            
        default:
            break;
    }
    
    
    
    
    [ApplicationDelegate.appEngine searchEvents:searcDic onCompletion:^(NSMutableArray *searchEventArray) {
        
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.toolbar setUserInteractionEnabled:YES];
        
        if (searchEventArray.count == 0) {
            UIAlertView *ser = [[UIAlertView alloc]initWithTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"eventsSearch"] message:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"noSearchResults"] delegate:self cancelButtonTitle:[[ConferenceHelper SharedHelper] getLanguageForAKey:@"ok"] otherButtonTitles:nil, nil];
            
            [ser show];
            
        }else{
            for (NSMutableDictionary *dic in searchEventArray) {
                [searchResultsArray addObject:[[ConferenceHelper SharedHelper] getEventsObjectFromDictionary:dic]];
                NSLog(@"Dic is %@", dic);
                
            }
            [ApplicationDelegate.appSearchEventsArray removeAllObjects];
            [ApplicationDelegate.appSearchEventsArray addObjectsFromArray:searchResultsArray];
            NSLog(@"search events array count is %d",ApplicationDelegate.appSearchEventsArray.count
                  );
            
            [self.navigationController fadePopViewController];
           /* ExpoEventsViewController *eveView = [[ExpoEventsViewController alloc]initWithNibName:@"ExpoEventsViewController" bundle:nil];
            [eveView setFromSearch:YES];
            [self.navigationController pushFadeViewController:eveView];*/
            
        }
       
        
    } onError:^(NSError *error) {
        
        [ApplicationDelegate.HUD hide:YES];
        [self.navigationController.toolbar setUserInteractionEnabled:YES];
        
    }];
    
    
    
    //http://conferenceapp.crisiltech.com/controller/event.php?action=search&keyword=&upcoming=&industry_category=&date_start=&date_end=
  
}

-(void)stopThari{
    
     /*[ApplicationDelegate.HUD hide:YES];

    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Search Event" message:@"No results found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [al show];*/
    
}
- (void)viewDidUnload {
    [self setHomeLabel:nil];
    [self setEngView:nil];
    [self setArabView:nil];
    [self setArabEventTxtField:nil];
    [self setArabIndustryTxtField:nil];
    [self setArabStartTxtField:nil];
    [self setArabEndTxtField:nil];
    [self setSubmitBtn:nil];
    [super viewDidUnload];
}
@end
