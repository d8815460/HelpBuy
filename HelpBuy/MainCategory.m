//
//  MainCategory.m
//  taiwan8
//
//  Created by ALEX on 2014/7/25.
//  Copyright (c) 2014年 taiwan8. All rights reserved.
//

#import "MainCategory.h"

@implementation MainCategory

+ (id)mainCategoryItemWithDict:(NSDictionary *)dict {
    MainCategory *item = [[MainCategory alloc] init];
    
    item.objectId = dict[@"objectId"];
    item.categoryId = dict[@"categoryId"];
    item.name = dict[@"name"];
    item.category = dict[@"category"];
    
    return item;
}

@end
