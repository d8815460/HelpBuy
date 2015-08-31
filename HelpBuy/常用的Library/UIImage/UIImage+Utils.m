//
//  UIImage+Utils.m
//  Highlights
//
//  Created by Valentin Filip on 9/12/13.
//
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)


- (CGFloat)aspectFitHeightForWidth:(CGFloat)width {
    CGFloat scaleFactor;
//    if( self.size.width > width ) {
        scaleFactor = width / self.size.width;
//    } else {
//        scaleFactor = self.size.width / width;
//    }

    return self.size.height * scaleFactor;
}

@end
