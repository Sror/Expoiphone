//
//  ConferenceAppDelegate.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 04/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceAppEngine.h"
#import "ConferenceHelper.h"

#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>

#import <QuartzCore/QuartzCore.h>

#import "UINavigationController+Push.h"

#import "XOSplashVideoController.h"
#import "MBProgressHUD.h"

#define ApplicationDelegate ((ConferenceAppDelegate *)[UIApplication sharedApplication].delegate)


extern NSString *const FBSessionStateChangedNotification;
//NSString *const FBSessionStateChangedNotification = @"com.tiltedu.conference:FBSessionStateChangedNotification";


@class ConferenceViewController;

@interface ConferenceAppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate,XOSplashVideoDelegate>{
    
     BOOL _dragged;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * navController;

@property (nonatomic)  BOOL _dragged;;

@property (strong, nonatomic) ConferenceViewController *viewController;

@property (nonatomic, retain) ConferenceAppEngine *appEngine;
@property (nonatomic, strong) ConferenceHelper *appHelper;

@property (strong, nonatomic) FBSession *appdelegateSession;

@property (nonatomic, retain) MBProgressHUD *HUD;



@property (strong, nonatomic) NSMutableDictionary *postParams;


@property (nonatomic, retain) NSMutableArray *appEventArray;
@property (nonatomic, retain) NSMutableArray *appFavEventArray;
@property (nonatomic, retain) NSMutableArray *appImageGalleryArray;
@property (nonatomic, retain) NSMutableArray *appCurrentEventArray;
@property (nonatomic, retain) NSMutableArray *appLatestNewsArray;
@property (nonatomic, retain) NSMutableArray *appSearchEventsArray;

@property (nonatomic, retain) UIView *dragView;

@property (nonatomic, retain) NSMutableArray *appLanguageArray;


@property (nonatomic, retain) NSString *userNameString;



-(void)emptyAllArrays;

-(UIButton *)customBackBtn;
- (UIView *)setTitle:(NSString *)title;
-(UIView *)titleView:(NSString *)titleText;
-(UIView *) setTitleForMainView;
-(void)showMainHomeView;
- (UIView *)setTitleForViews:(NSString *)title;
-(UIView *)setTitleForDetailView;


- (void)dragBtnAction:(UIPanGestureRecognizer *)rec;

- (void) hideTabBar:(UITabBarController *) tabbarcontroller;
- (void) showTabBar:(UITabBarController *) tabbarcontroller;


@property(nonatomic) int langBool;
@property(nonatomic, retain) NSString* langCode;


//@property (nonatomic,)


- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void)publishStory;

@end
