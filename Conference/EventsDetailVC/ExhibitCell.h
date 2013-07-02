//
//  AMMediaCell.h
//  Arther
//
//  Created by EAAM TECHNOLOGIES on 15/02/13.
//  Copyright (c) 2013 TILT PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"

@interface ExhibitCell : UITableViewCell{
    
}

@property (strong, nonatomic) IBOutlet UILabel *companyheadLabel;
@property (strong, nonatomic) IBOutlet UILabel *cateHeadLabel;
@property (strong, nonatomic) IBOutlet UILabel *boothHeadLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabelValue;

@property (strong, nonatomic) IBOutlet UILabel *catLabelValue;
@property (strong, nonatomic) IBOutlet UILabel *boothLabelValue;



-(void)setListToCell:(NSMutableDictionary *)listDic;

@end
