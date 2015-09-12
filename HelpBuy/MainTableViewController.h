//
//  MainTableViewController.h
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/8/31.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "PFQueryTableViewController.h"
#import "ChoseCategoryTableTableViewController.h"

@interface MainTableViewController : PFQueryTableViewController <ChoseCategoryTableTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *categoryButton;
@property (strong, nonatomic) NSString *myCategory;

- (IBAction)categoryButtonPressed:(id)sender;
@end
