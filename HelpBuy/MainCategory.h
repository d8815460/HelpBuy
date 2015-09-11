//
//  MainCategory.h
//  taiwan8
//
//  Created by ALEX on 2014/7/25.
//  Copyright (c) 2014年 taiwan8. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainCategory : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *categoryId;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *objectId;

+ (id)mainCategoryItemWithDict:(NSDictionary *)dict;

@end
