//
//  ConferenceAppEngine.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 05/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "ConferenceAppEngine.h"

@implementation ConferenceAppEngine


-(void)industryCategoryList: (NSString *)industry onCompletion:(industryCategoryResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    
    NSLog(@"Indusrty url >> http://conferenceapp.crisiltech.com/controller/industrycatagory.php?action=getlist");
    
    
   
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getlist" forKey:@"action"];
    MKNetworkOperation *op =[self operationWithPath:INDUSTRYCATEGORYURL params:dic
                                         httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSLog(@"ompletedOperation.responseString %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    
    [self enqueueOperation:op];
}



-(void)eventsList :(NSString *)eventType  onCompletion:(EventsResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getlist" forKey:@"action"];
    MKNetworkOperation *op = [self operationWithPath:EVENTSURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSLog(@"ompletedOperation.responseString %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    
    [self enqueueOperation:op];

    
}
/// http://conferenceapp.crisiltech.com/controller/event.php?action=getCurrentEvents

-(void)newsList :(NSString *)news  onCompletion:(NewsListResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    
    NSLog(@"News url >>  http://conferenceapp.crisiltech.com/controller/news.php?action=getList");
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getList" forKey:@"action"];
    [dic setValue:ApplicationDelegate.langCode forKey:@"language"];
    MKNetworkOperation *op = [self operationWithPath:NEWSLISTURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSLog(@"ompletedOperation.responseString %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
}

-(void)currentEventList :(NSString *)currentevent  onCompletion:(CurrentEventResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    
    NSLog(@"currentEvent url >>  http://conferenceapp.crisiltech.com/controller/event.php?action=getCurrentEvents");
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
   // [dic setValue:@"getCurrentEvents" forKey:@"action"];
     [dic setValue:@"getlist" forKey:@"action"];
    [dic setValue:ApplicationDelegate.langCode forKey:@"language"];
    MKNetworkOperation *op = [self operationWithPath:CURRENTEVENTSURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
     //   NSLog(@"currentEventList.responseString %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
}

-(void)imageGalleryList :(NSString *)image  onCompletion:(ImageGalleryResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getList" forKey:@"action"];
    MKNetworkOperation *op = [self operationWithPath:IMAGEGALLERYURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSLog(@"ompletedOperation.responseString %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
}

-(void)loginAction:(NSString *)loginuserName withPassword:(NSString*)loginuserPassword onCompletion:(LoginResponseBlock)events onError:(MKNKErrorBlock) errorBlock{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"loginStaff" forKey:@"action"];
    [dic setValue:loginuserName forKey:@"username"];
    [dic setValue:loginuserPassword forKey:@"password"];
    
    
    MKNetworkOperation *op = [self operationWithPath:LOGINURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSLog(@"Login response str is  %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
           /* if (jsonObject[@"userId"]) {
                events(jsonObject[@"userId"]);
            }
            
            else
            {*/
                
                //events(jsonObject[@"result"]);
           // }
            
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
    
}

-(void)videoGalleryList :(NSString *)video  onCompletion:(VideoGalleryResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getlist" forKey:@"action"];
    MKNetworkOperation *op = [self operationWithPath:VIDEOGALLERYURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}



-(void)favList :(NSString *)propertType  onCompletion:(favResponceBlock)events onError:(MKNKErrorBlock) errorBlock{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getFavouriteList" forKey:@"action"];
    NSString *string1=@"";
    NSLog(@"the array=%@",[[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"favList.plist"]);
    int i=0;
    for (NSString *string in [[ConferenceHelper SharedHelper] ReadArrayFromthePlistFile:@"favList.plist"]) {
        
        
        NSLog(@"the array value %@",string);
        i++;
        
        if (i==1) {
            
            string1=[NSString stringWithFormat:@"%@%@",string1,string];
        }
        else
        {
            
            string1=[NSString stringWithFormat:@"%@,%@",string1,string];
        }
        
    }
    
    NSLog(@"the string value %@",string1);
    
    //string1 = [NSString stringWithFormat:@"41,42,43"];
    [dic setValue:string1 forKey:@"event_ids"];
    
    
    MKNetworkOperation *op = [self operationWithPath:FAVEVENTSURL params:dic
                                          httpMethod:@"POST"];

    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSLog(@"%@",completedOperation);
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    
    [self enqueueOperation:op];
    

}

-(void)checkYoutubeLink:(NSString*)youtubeId onCompletion:(checkYouTubeBlock) cars onError:(MKNKErrorBlock) errorBlock{
    
    
    NSString * url=[[NSString alloc] initWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@?v=2&alt=json",youtubeId];
    
    NSLog(@"url is %@", url);
    
    MKNetworkOperation *op =[[MKNetworkOperation alloc] initWithURLString:url params:nil   httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            cars(jsonObject);
            
            // NSLog(@"json output=%@",jsonObject);
            
            //  NSLog(@"jsonoutput=%@",jsonObject[@"stations"]);
        }];
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        
        NSLog(@"error=%@",[error description]);
        errorBlock(error);
        
    } ];
    
    
    
    [self enqueueOperation:op];
    
    
    
    
}

-(void)pressReleaseList :(NSString *)press  onCompletion:(PressReleaseResponceBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getList" forKey:@"action"];
    MKNetworkOperation *op = [self operationWithPath:PRESSRELEASEURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
}
-(void)searchEvents:(NSMutableDictionary *)searchParams  onCompletion:(SearchEventsResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    //NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [searchParams setValue:@"search" forKey:@"action"];
    
    NSLog(@"serach paramsd are %@",searchParams);
    
    MKNetworkOperation *op = [self operationWithPath:SEARCHEVENTURL params:searchParams
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSLog(@"ompletedOperation.responseString %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    
    [self enqueueOperation:op];
    

    
}

-(void)addUserProfile:(NSMutableDictionary *)userParams  onCompletion:(UserProfileResponseBlock) events onError:(MKNKErrorBlock) errorBlock{
    
    
    [userParams setValue:@"adduser" forKey:@"action"];
    
    NSLog(@"serach paramsd are %@",userParams);
    
    MKNetworkOperation *op = [self operationWithPath:USERPROFILEURL params:userParams
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSLog(@"ompletedOperation.responseString %@", completedOperation.responseString);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            events(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    
    [self enqueueOperation:op];

}


-(MKNetworkOperation *)downloadBrochure:(NSString *)remoteUrl toFile:(NSString *)filePath
{
    MKNetworkOperation *op = [self operationWithURLString:remoteUrl
                                                   params:nil
                                               httpMethod:@"GET"];
    
    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath
                                                            append:YES]];
    
    [self enqueueOperation:op];
    
    [op setFreezable:YES];
    
    return op;
}


-(MKNetworkOperation *)loadWebViewStringforTitle:(NSString *)title{

    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getHTML" forKey:@"action"];
    [dic setValue:title forKey:@"title"];

    MKNetworkOperation *op = [self operationWithPath:WEBVIEWURL params:dic
                                          httpMethod:@"POST"];
    
    [self enqueueOperation:op];

    return op;

}

@end
