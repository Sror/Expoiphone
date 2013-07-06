//
//  ExpoCommonViewController.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 06/07/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGalleryViewController.h"
@interface ExpoCommonViewController : UIViewController<FGalleryViewControllerDelegate>{
    
}

@property (nonatomic, retain)NSString *selectedVideo;
@property (nonatomic, retain) NSMutableArray *imageArray;

@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) NSString *titleHeaderString;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

- (IBAction)homBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;

@property(nonatomic) BOOL fromEventDetailView;


@property (strong, nonatomic)  FGalleryViewController *networkGallery;



@end
