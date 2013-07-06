//
//  AMMediaCell.h
//  Arther
//
//  Created by EAAM TECHNOLOGIES on 15/02/13.
//  Copyright (c) 2013 TILT PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"

@interface NewsCell : UITableViewCell{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *listImgView;
@property (strong, nonatomic) IBOutlet UILabel *listLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;


-(void)setNewsListToCell:(News *)newsObj;
-(void)setDetailsToCell:(NSMutableDictionary *)dic withTitle:(NSString *)title withView:(BOOL) fromDetailView;
@end
