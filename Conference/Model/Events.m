//
//  Events.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 05/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "Events.h"

@implementation Events

@synthesize name,event_id,date,location,industry_category,event_timing,event_duration,lattitude,longitude,logo,website,email,shared_link,facebook_link,twitter_link,linked_in_link,instagram_link,end_date,end_time,start_date,start_time,brochure;
@synthesize locationArray,media_partners,sponsors,supporters,imageGallery,exhibitorsArray,organizers,videoGalleryArray;


- (id)init
{
    self = [super init];
    if (self) {
        self.imageGallery=[[NSMutableArray alloc] init];
        self.supporters=[[NSMutableArray alloc] init];
        self.media_partners=[[NSMutableArray alloc] init];
        self.sponsors=[[NSMutableArray alloc] init];
        self.locationArray = [[NSMutableArray alloc]init];
        self.exhibitorsArray = [[NSMutableArray alloc]init];
        self.organizers = [[NSMutableArray alloc]init];
        self.videoGalleryArray = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
