//
//  ConferenceAppEngine.h
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 05/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "MKNetworkEngine.h"




#define EVENTSURL [NSString stringWithFormat:@"controller/event.php"]
#define INDUSTRYCATEGORYURL [NSString stringWithFormat:@"controller/industrycatagory.php"]
#define NEWSLISTURL [NSString stringWithFormat:@"controller/news.php"]
#define CURRENTEVENTSURL [NSString stringWithFormat:@"controller/event.php"]
#define IMAGEGALLERYURL [NSString stringWithFormat:@"controller/imagegallery.php"]
#define VIDEOGALLERYURL [NSString stringWithFormat:@"controller/videogallery.php"]
#define FAVEVENTSURL [NSString stringWithFormat:@"controller/event.php"]
#define LOGINURL [NSString stringWithFormat:@"controller/staff.php"]
#define PRESSRELEASEURL [NSString stringWithFormat:@"controller/press_release.php"]


#define WEBVIEWURL [NSString stringWithFormat:@"controller/cms.php"]


@interface ConferenceAppEngine : MKNetworkEngine

typedef void (^EventsResponseBlock)(NSMutableArray *eventArray);
typedef void (^industryCategoryResponseBlock)(NSMutableArray *industryArray);
typedef void (^NewsListResponseBlock)(NSMutableArray *newsListArray);
typedef void (^CurrentEventResponseBlock)(NSMutableArray *CurrentEventArray);
typedef void (^ImageGalleryResponseBlock)(NSMutableArray *imageGaleryArray);
typedef void (^VideoGalleryResponseBlock)(NSMutableArray *videoGaleryArray);
typedef void (^LoginResponseBlock)(NSMutableDictionary *loginResponseDic);
typedef void (^favResponceBlock)(NSMutableArray *favEventArray);

typedef void (^PressReleaseResponceBlock)(NSMutableArray *pressReleaseArray);
typedef void (^MCImageGalleryResponceBlock)(NSMutableArray *pressReleaseArray);
typedef void (^MCVideoGalleryResponceBlock)(NSMutableArray *pressReleaseArray);




typedef void (^checkYouTubeBlock)(NSMutableArray *youtube);

-(void)industryCategoryList: (NSString *)industry onCompletion:(industryCategoryResponseBlock) events onError:(MKNKErrorBlock) errorBlock;

-(void)eventsList :(NSString *)eventType  onCompletion:(EventsResponseBlock) events onError:(MKNKErrorBlock) errorBlock;
 
-(void)newsList :(NSString *)news  onCompletion:(NewsListResponseBlock) events onError:(MKNKErrorBlock) errorBlock;

-(void)currentEventList :(NSString *)currentevent  onCompletion:(CurrentEventResponseBlock) events onError:(MKNKErrorBlock) errorBlock;

-(void)imageGalleryList :(NSString *)image  onCompletion:(ImageGalleryResponseBlock) events onError:(MKNKErrorBlock) errorBlock;
-(void)videoGalleryList :(NSString *)video  onCompletion:(VideoGalleryResponseBlock) events onError:(MKNKErrorBlock) errorBlock;
-(void)loginAction:(NSString *)loginuserName withPassword:(NSString*)loginuserPassword onCompletion:(LoginResponseBlock)events onError:(MKNKErrorBlock) errorBlock;

-(void)favList :(NSString *)propertType  onCompletion:(favResponceBlock)events onError:(MKNKErrorBlock) errorBlock;

-(void)checkYoutubeLink:(NSString*)youtubeId onCompletion:(checkYouTubeBlock) cars onError:(MKNKErrorBlock) errorBlock;

-(void)pressReleaseList :(NSString *)press  onCompletion:(PressReleaseResponceBlock) events onError:(MKNKErrorBlock) errorBlock;


-(MKNetworkOperation *)downloadBrochure:(NSString *)remoteUrl toFile:(NSString *)filePath;
-(MKNetworkOperation *)loadWebViewStringforTitle:(NSString *)title;
@end
