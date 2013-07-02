//
//  AMMediaCell.m
//  Arther
//
//  Created by EAAM TECHNOLOGIES on 15/02/13.
//  Copyright (c) 2013 TILT PVT LTD. All rights reserved.
//

#import "ExhibitCell.h"

@implementation ExhibitCell

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

-(void)setListToCell:(NSMutableDictionary *)listDic{

    [self.companyheadLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.cateHeadLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
    [self.boothHeadLabel setFont:[UIFont fontWithName:@"Eagle-Light" size:12.0]];
    [self.companyLabelValue setFont:[UIFont fontWithName:@"Eagle-Light" size:14.0]];
    [self.catLabelValue setFont:[UIFont fontWithName:@"Eagle-Light" size:13.0]];
    [self.boothLabelValue setFont:[UIFont fontWithName:@"Eagle-Light" size:12.0]];
    
    //NSLog(@"List dic is %@", listDic);
    
    [self.companyLabelValue setText:[listDic objectForKey:@"company_name"]];
    [self.catLabelValue setText:[listDic objectForKey:@"industry_category"]];
    [self.boothLabelValue setText:[listDic objectForKey:@"booth_number"]];


}


@end
