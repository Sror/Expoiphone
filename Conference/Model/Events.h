//
//  Events.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 05/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Events : NSObject


@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *event_id;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *industry_category;
@property(nonatomic,strong)NSString *event_timing;
@property(nonatomic,strong)NSString *event_duration;
@property(nonatomic,strong)NSString *lattitude;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *sponsers;
@property(nonatomic,strong)NSString *supporters;
@property(nonatomic,strong)NSString *media_partners;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *website;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *shared_link;
@property(nonatomic,strong)NSString *facebook_link;
@property(nonatomic,strong)NSString *twitter_link;
@property(nonatomic,strong)NSString *linked_in_link;
@property(nonatomic,strong)NSString *instagram_link;

@property(nonatomic,strong)NSString *end_date;
@property(nonatomic,strong)NSString *end_time;

@property(nonatomic,strong)NSString *start_date;
@property(nonatomic,strong)NSString *start_time;

@end
