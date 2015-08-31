//
//  NSString+Empty.m
//  Highlights
//
//  Created by Valentin Filip on 9/12/13.
//
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

- (BOOL)isEmpty {
    if (self && ![self isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

@end
