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
    events.sponsers=[dic objectForKey:@"sponsers"];
    events.supporters=[dic objectForKey:@"supporters"];
    events.media_partners = [dic objectForKey:@"media_partners"];
    events.logo=[dic objectForKey:@"logo"];
    events.website=[dic objectForKey:@"website"];
    events.email=[dic objectForKey:@"email"];
    events.shared_link = [dic objectForKey:@"shared_link"];
    events.facebook_link=[dic objectForKey:@"facebook_link"];
    events.twitter_link=[dic objectForKey:@"twitter_link"];
    events.linked_in_link=[dic objectForKey:@"linked_in_link"];
    events.instagram_link = [dic objectForKey:@"instagram_link"];
    
    return events;
    
    
}


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

@end
