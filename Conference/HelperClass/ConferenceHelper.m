//
//  ConferenceHelper.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 05/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConferenceHelper.h"

@implementation ConferenceHelper


+(ConferenceHelper *)SharedHelper
{
    static ConferenceHelper *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(BOOL)isEmptyString:(NSString *)string
{
    if(!string)
    { //string is empty or nil
        return YES;
    }
    else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        //string is all whitespace
        return YES;
    }
    return NO;
}



-(Events *)getEventsObjectFromDictionary:(NSMutableDictionary *)dic{
    
   
    Events *events=[[Events alloc] init];
    events.name=[dic objectForKey:@"name"];
    events.event_id=[dic objectForKey:@"event_id"];
    events.date=[dic objectForKey:@"date"];
    events.location = [dic objectForKey:@"location"];
    events.industry_category=[dic objectForKey:@"industry_category"];
    events.event_timing=[dic objectForKey:@"event_timing"];
    events.event_duration=[dic objectForKey:@"event_duration"];
    events.lattitude = [dic objectForKey:@"lattitude"];
    events.longitude=[dic objectForKey:@"longitude"];
    events.brochure=[dic objectForKey:@"brochure"];
   // events.supporters=[dic objectForKey:@"supporters"];
   // events.media_partners = [dic objectForKey:@"media_partners"];
    events.logo=[dic objectForKey:@"logo"];
    events.website=[dic objectForKey:@"website"];
    events.email=[dic objectForKey:@"email"];
    events.shared_link = [dic objectForKey:@"shared_link"];
    events.facebook_link=[dic objectForKey:@"facebook_link"];
    events.twitter_link=[dic objectForKey:@"twitter_link"];
    events.linked_in_link=[dic objectForKey:@"linked_in_link"];
    events.instagram_link = [dic objectForKey:@"instagram_link"];
    events.description = [dic objectForKey:@"description"];
    
    [events.imageGallery addObjectsFromArray:[dic objectForKey:@"image_gallery"]];
    [events.sponsors addObjectsFromArray:[dic objectForKey:@"sponsors"]];
    [events.exhibitorsArray addObjectsFromArray:[dic objectForKey:@"exhibitors"]];
    [events.media_partners addObjectsFromArray:[dic objectForKey:@"media_partners"]];
    [events.supporters addObjectsFromArray:[dic objectForKey:@"supporters"]];
    [events.locationArray addObjectsFromArray:[dic objectForKey:@"location_map"]];
    [events.organizers addObjectsFromArray:[dic objectForKey:@"organizers"]];
    [events.videoGalleryArray addObjectsFromArray:[dic objectForKey:@"video_gallery"]];
    
    events.start_date = [dic objectForKey:@"start_date"];
    events.start_time = [dic objectForKey:@"start_time"];
    events.end_date = [dic objectForKey:@"end_date"];
    events.end_time = [dic objectForKey:@"end_time"];
    
    /*if ([dic objectForKey:@"YoutubeLink"] == [NSNull null]) {
        pro.YoutubeLink = nil;
    }else{
        pro.YoutubeLink=[dic objectForKey:@"YoutubeLink"];
    }*/
    
    
    return events;
    
    
}



-(News *)getNewsObjectFromDictionary:(NSMutableDictionary *)dic;{
    
    News *new = [[News alloc]init];
    
    [new setNews_id:[dic objectForKey:@"id"]];
    [new setNews_description:[dic objectForKey:@"description"]];
    [new setNews_title:[dic objectForKey:@"title"]];
    [new setNews_image:[dic objectForKey:@"image"]];
    
    return new;
    
}

#pragma mark -date methods

-(NSString *)datefromString:(NSString *)dateString{

    NSString *dateStr;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateString];

    [dateFormat setDateFormat:@"dd LLLL yyyy"];
    dateStr = [dateFormat stringFromDate:[date dateByAddingTimeInterval:[[NSTimeZone defaultTimeZone] secondsFromGMT]]];
   // NSLog(@"Retiurned date  is %@",dateStr);
    return dateStr;
    
}

-(NSDate *)dateForEventFromString:(NSString *)dateStr{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    NSLog(@"returned date for event is %@",[date dateByAddingTimeInterval:[[NSTimeZone defaultTimeZone] secondsFromGMT]]);
    return [date dateByAddingTimeInterval:[[NSTimeZone defaultTimeZone] secondsFromGMT]];
}


//-(NSString *)timeFromSrtring:(NSString*)timeString{
//    
//    return nil;
//}

#pragma mark - Plist saving/retrieve methods

- (NSString *)copyFileToDocumentDirectory:(NSString *)fileName {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *documentDirPath = [documentsDir
                                 stringByAppendingPathComponent:fileName];
    
    NSArray *file = [fileName componentsSeparatedByString:@"."];
    NSString *filePath = [[NSBundle mainBundle]
                          pathForResource:[file objectAtIndex:0]
                          ofType:[file lastObject]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:documentDirPath];
    
    if (!success) {
        success = [fileManager copyItemAtPath:filePath
                                       toPath:documentDirPath
                                        error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable txt file file with message \
                      '%@'.", [error localizedDescription]);
        }
    }
    
    return documentDirPath;
}

-(NSMutableDictionary *)ReadFromthePlistFile:(NSString *)fileName
{
    NSString *path=[self copyFileToDocumentDirectory:fileName];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    return dic;
}

-(void)WriteFromthePlistFile:(NSMutableDictionary*)data toFile:(NSString *)fileName
{
    NSString *path=[self copyFileToDocumentDirectory:fileName];
    [data writeToFile:path atomically:YES];
    
    
}




-(NSString *)getLanguageForAKey:(NSString *)key

{
    
    
    NSDictionary *thedata;
    //NSLog(@"Array count is %d",ApplicationDelegate.appLanguageArray.count);
    
    for (NSDictionary *dic in ApplicationDelegate.appLanguageArray) {
        
        if ([dic objectForKey:key]) {
            thedata=[dic objectForKey:key];
            break;
        }
    }
    //NSLog(@"the outputStr value for lang %@ is %@",ApplicationDelegate.langCode,[thedata objectForKey:ApplicationDelegate.langCode]);
    return [thedata objectForKey:ApplicationDelegate.langCode];
}


-(NSMutableArray *)ReadArrayFromthePlistFile:(NSString *)fileName
{
    NSString *path=[self copyFileToDocumentDirectory:fileName];
    NSMutableArray *dic=[[NSMutableArray alloc] initWithContentsOfFile:path];
    return dic;
}

-(void)WriteArrayTothePlistFile:(NSMutableArray *)data toFile:(NSString *)fileName;
{
    NSString *path=[self copyFileToDocumentDirectory:fileName];
    [data writeToFile:path atomically:YES];
    
    
}

@end
