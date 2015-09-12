//
//  ChoseCategoryTableTableViewController.h
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/9/11.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChoseCategoryTableTableViewController;

@protocol ChoseCategoryTableTableViewControllerDelegate <NSObject>

- (void)didSelectedCategory:(ChoseCategoryTableTableViewController *)controller Category:(NSString *)category;

@end

@interface ChoseCategoryTableTableViewController : UITableViewController
@property (nonatomic, retain) NSArray* items;
@property (nonatomic, weak) id <ChoseCategoryTableTableViewControllerDelegate> delegate;
@end
