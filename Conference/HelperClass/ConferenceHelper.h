//
//  ConferenceHelper.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 05/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Events.h"

@interface ConferenceHelper : NSObject




+(ConferenceHelper *)SharedHelper;

-(BOOL)isEmptyString:(NSString *)string;

- (NSString *)copyFileToDocumentDirectory:(NSString *)fileName;
-(void)WriteFromthePlistFile:(NSMutableDictionary*)data toFile:(NSString *)fileName;
-(NSMutableDictionary *)ReadFromthePlistFile:(NSString *)fileName;

-(Events *)getEventsObjectFromDictionary:(NSMutableDictionary *)dic;




@end
