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
    [dic setValue:@"getlist" forKey:@"action"];
    MKNetworkOperation *op = [self operationWithPath:NEWSLISTURL params:dic
                                          httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSLog(@"ompletedOperation.responseString %@", completedOperation.responseString);
        
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
    [dic setValue:@"getCurrentEvents" forKey:@"action"];
    MKNetworkOperation *op = [self operationWithPath:CURRENTEVENTSURL params:dic
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
    [dic setValue:@"getList" forKey:@"action"];
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



-(MKNetworkOperation *)loadWebViewStringforTitle:(NSString *)title forEvent:(NSString *)eventId{

    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setValue:@"getHTML" forKey:@"action"];
    [dic setValue:title forKey:@"title"];
    /*
    if (![[ConferenceHelper SharedHelper]isEmptyString:eventId]) {
        [dic setValue:eventId forKey:@"id"];
    }*/
    
    MKNetworkOperation *op = [self operationWithPath:WEBVIEWURL params:dic
                                          httpMethod:@"POST"];
    
    [self enqueueOperation:op];
    

    return op;

}

@end
