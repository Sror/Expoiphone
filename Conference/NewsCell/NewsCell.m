//
//  AMMediaCell.m
//  Arther
//
//  Created by EAAM TECHNOLOGIES on 15/02/13.
//  Copyright (c) 2013 TILT PVT LTD. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self.listImgView setContentMode:UIViewContentModeScaleToFill];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setNewsListToCell:(News *)newsObj{
    
   // NSMutableDictionary *myDic = [med]
    
   // [self.locationLabel setHidden:YES];
    
    //[self.listLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:16.0]];

    
    [self.locationLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    self.locationLabel.textColor = [UIColor blackColor];
    
    //NSLog(@"tit %@",newsObj.news_title);

    
    [self.locationLabel setText:newsObj.news_title];
    
    NSString *iconUrl=newsObj.news_image;
    
    self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        
        
        if([iconUrl isEqualToString:[url absoluteString]]) {
            
            [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                self.listImgView.image = fetchedImage;
            } completion:nil];
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    

}

-(void)setDetailsToCell:(NSMutableDictionary *)dic withTitle:(NSString *)title withView:(BOOL) fromDetailView{
    
    NSLog(@"Dic is %@",dic);
    
    [self.locationLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    
   // NSLog(@"tit %@",[dic objectForKey:@"title"]);
    
    
    [self.locationLabel setText:[dic objectForKey:@"title"]];
    NSString *iconUrl;
    
    if ([title isEqualToString:@"Video-Gallery"]){
        
        if (fromDetailView) {
            iconUrl=[dic objectForKey:@"thumb_image"];
        }else{
            iconUrl=[dic objectForKey:@"thum_image"];}
    }
    else if ([title isEqualToString:@"Press-Release"]){
        
        iconUrl=[dic objectForKey:@"thumb_image"];
    }else{
        iconUrl=[dic objectForKey:@"image"];
    }
    self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        
        
        if([iconUrl isEqualToString:[url absoluteString]]) {
            
            [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                self.listImgView.image = fetchedImage;
            } completion:nil];
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
}


@end
