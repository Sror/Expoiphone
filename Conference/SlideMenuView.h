//
//  Created by Björn Sållarp on 2008-10-04.
//  Copyright MightyLittle Industries 2008. All rights reserved.
//
//  Read my blog @ http://jsus.is-a-geek.org/blog
//

#import <UIKit/UIKit.h>


@interface SlideMenuView : UIView <UIScrollViewDelegate> {
	UIScrollView *menuScrollView;
	//UIImageView *rightMenuImage;
	//UIImageView *leftMenuImage;
	NSMutableArray *menuButtons;
}
-(id) initWithFrameColorAndButtons:(CGRect)frame backgroundColor:(UIColor*)bgColor  buttons:(NSMutableArray*)buttonArray;

@property (nonatomic, strong) UIScrollView* menuScrollView;
//@property (nonatomic, strong) UIImageView* rightMenuImage;
//@property (nonatomic, strong) UIImageView* leftMenuImage;
@property (nonatomic, strong) NSMutableArray* menuButtons;

@end
