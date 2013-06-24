//
//  EventsCell.m
//  Conference
//
//  Created by EAAM TECHNOLOGIES on 09/06/13.
//  Copyright (c) 2013 EAAM TECHNOLOGIES. All rights reserved.
//

#import "EventsCell.h"

@implementation EventsCell

//@synthesize logoImageView,LocationLabel,categoryLabel,timeLabel,dateLabel,eventNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setPropertyToCell:(Events *)event{

    // AdelleBasic-BoldItalic
    
   /* [self.propertyHeadLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:16.0]];
    [self.propertyIdLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:17.0]];
    [self.buildingTypeLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:13.0]];
    [self.specDetailsLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:11.0]];
    [self.constructorLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:11.0]];
    [self.statusLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:12.0]];
    [self.priceLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:12.0]];
    [self.detailedAddressLabel setFont:[UIFont fontWithName:@"AdelleBasic-Bold" size:11.0]];*/
    
    
    
    // NSMutableDictionary *dic = [nearListArray objectAtIndex:indexPath.row];


    
    [self.eventNameLabel setText:event.name];
    [self.categoryLabel setText:event.industry_category];
    [self.LocationLabel setText:event.location];
    [self.dateLabel setText:event.date];
    [self.timeLabel setText:event.event_timing];

    
 /*   [self.propertyIdLabel setText:prop.PropertyId];
    [self.buildingTypeLabel setText:prop.TypeOfProperty];
    [self.detailedAddressLabel setText:[prop.Address stringByReplacingOccurrencesOfString:@"/n" withString:@""]];
    [self.specDetailsLabel setText:[NSString stringWithFormat:@"%@ Bed, %@+ Bath, %@ sq.ft.",prop.Bedrooms,prop.Bathrooms,prop.SizeOfProperty]];
    //  [self.constructorLabel setText:@"ffggthhy builderss ttgg"];
    
    [self.constructorLabel setText:prop.agentDetails.AgentName];
    [self.statusLabel setText:prop.status];
    
    // NSLog(@"Agent det is %@", prop.agentDetails.AgentName);
    
    [self.priceLabel setText:[NSString stringWithFormat:@"AED%@",prop.Price]];*/
    /*[self.titleLabel setText:[NSString stringWithFormat:@"Building title"]];
     [self.addressLabel setText:prop.CompanyName];
     [self.locationLabel setText:prop.Location];
     [self.statusLabel setText:prop.TypeOfProperty];
     [self.specificationLabel setText:[NSString stringWithFormat:@"%@ Bed, %@+ Bath, %@ sq.ft.",prop.Bedrooms,prop.Bathrooms,prop.SizeOfProperty]];
     [self.courtesyLabel setText:[NSString stringWithFormat:@"courtesy of New builders"]];*/
    
    NSString *iconUrl=event.logo ;
    
    
    
    self.imageLoadingOperation=[ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:iconUrl] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        
        
        if([iconUrl isEqualToString:[url absoluteString]]) {
            
            [UIView animateWithDuration:isInCache?0.0f:0.4f delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                self.logoImageView.image = fetchedImage;
            } completion:nil];
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        
        
    }];
    
    
    
}


@end
