//
//  DataLoader.m
//  
//
//  Created by Valentin Filip on 25/08/2013.
//  Copyright (c) 2013 AppDesignVault. All rights reserved.
//

#import "DataLoader.h"
#import "MainCategory.h"

@implementation DataLoader

+ (NSArray *)mainCategory {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MainCategories" ofType:@"plist"];
    NSArray *rawItems = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:rawItems.count];
    
    
    for (NSDictionary *item in rawItems) {
        [items addObject:[MainCategory mainCategoryItemWithDict:item]];
    }
    
    return items;
}

@end
