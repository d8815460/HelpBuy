//
//  Utils.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(UIImage*)drawImageOfSize:(CGSize)size andColor:(UIColor*)color{
    
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
    
}

+(UIImage*)drawRoundedImageOfSize:(CGSize)size andColor:(UIColor*)color{

    
    
    CGRect rect = CGRectMake(0,0,size.width,size.height);
    CGFloat radius = 3.0f;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                    radius, M_PI, M_PI / 2, 1); //STS fixed
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                    rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                    radius, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                    -M_PI / 2, M_PI, 1);
    
    CGContextFillPath(context);
   
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (NSString*)getTimeAsString:(NSDate *)lastDate {
    NSTimeInterval dateDiff =  [[NSDate date] timeIntervalSinceDate:lastDate];
    
    int nrSeconds = dateDiff;//components.second;
    int nrMinutes = nrSeconds / 60;
    int nrHours = nrSeconds / 3600;
    int nrDays = dateDiff / 86400; //components.day;
    
    NSString *time;
    if (nrDays > 5){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterShortStyle];
        [dateFormat setTimeStyle:NSDateFormatterNoStyle];
        
        time = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:lastDate]];
    } else {
        // days=1-5
        if (nrDays > 0) {
            if (nrDays == 1) {
                time = @"昨天";
            } else {
                time = [NSString stringWithFormat:@"%d天前", nrDays];
            }
        } else {
            if (nrHours == 0) {
                if (nrMinutes < 2) {
                    time = @"剛剛";
                } else {
                    time = [NSString stringWithFormat:@"%d分鐘前", nrMinutes];
                }
            } else { // days=0 hours!=0
                if (nrHours == 1) {
                    time = @"1小時以前";
                } else {
                    time = [NSString stringWithFormat:@"%d小時前", nrHours];
                }
            }
        }
    }
    
    return [NSString stringWithFormat:NSLocalizedString(@"%@", @"label"), time];
}
@end
