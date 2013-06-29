//
//  UIView+bounce.m
//  SlideAndBounceExample
//
//  Created by EAAM TECHNOLOGIES on 30/06/13.
//
//

#import "UIView+bounce.h"


@implementation UIView (bounce)

-(void)addSubviewWithBounce:(UIView*)theView
{
    theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self addSubview:theView];
    
    [UIView animateWithDuration:0.4/1.5 animations:^{
        theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4/2 animations:^{
            theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4/2 animations:^{
                theView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}


-(void)removeSubview:(UIView *)theView{
    
   /* theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.4/1.5 animations:^{
        theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [theView removeFromSuperview];
        
    }];*/
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         theView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [theView setAlpha:1.0];
                         [theView removeFromSuperview];
                     }];
}

@end