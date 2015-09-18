//
//  MainTableViewController.h
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/8/31.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "PFQueryTableViewController.h"
#import "ChoseCategoryTableTableViewController.h"
#import <MBProgressHUD.h>

@interface MainTableViewController : PFQueryTableViewController <ChoseCategoryTableTableViewControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *categoryButton;
@property (strong, nonatomic) NSString *myCategory;
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) NSString *keyWords;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)categoryButtonPressed:(id)sender;
@end
