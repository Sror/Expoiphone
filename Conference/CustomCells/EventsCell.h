//
//  EventsCell.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 09/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Events.h"
#import "MKNetworkKit.h"
#import "ConferenceAppDelegate.h"

@interface EventsCell : UITableViewCell{
    
    
}

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *LocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;



@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

-(void)setPropertyToCell:(Events *)event;

@end
