//
//  ConferenceHelper.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 05/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Events.h"
#import "News.h"

@interface ConferenceHelper : NSObject




+(ConferenceHelper *)SharedHelper;

-(BOOL)isEmptyString:(NSString *)string;
-(NSString *)datefromString:(NSString *)dateString;
-(NSDate *)dateForEventFromString:(NSString *)dateStr;
//-(NSString *)timeFromSrtring:(NSString*)timeString;

- (NSString *)copyFileToDocumentDirectory:(NSString *)fileName;
-(void)WriteFromthePlistFile:(NSMutableDictionary*)data toFile:(NSString *)fileName;
-(NSMutableDictionary *)ReadFromthePlistFile:(NSString *)fileName;

-(NSMutableArray *)ReadArrayFromthePlistFile:(NSString *)fileName;
-(void)WriteArrayTothePlistFile:(NSMutableArray *)data toFile:(NSString *)fileName;

-(Events *)getEventsObjectFromDictionary:(NSMutableDictionary *)dic;

-(NSString *)getLanguageForAKey:(NSString *)key;

-(News *)getNewsObjectFromDictionary:(NSMutableDictionary *)dic;;

@end
