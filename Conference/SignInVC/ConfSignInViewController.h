//
//  ConfSignInViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 29/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfSignInViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTxtField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxtField;

@property (strong, nonatomic) IBOutlet UILabel *homeLabel;

- (IBAction)loginBtnAction:(id)sender;

@end
