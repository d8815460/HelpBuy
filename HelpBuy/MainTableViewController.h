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

@interface MainTableViewController : PFQueryTableViewController <ChoseCategoryTableTableViewControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *categoryButton;
@property (strong, nonatomic) NSString *myCategory;
@property (strong, nonatomic) NSMutableArray  *dataList;    // = self.objects
@property (strong, nonatomic) NSMutableArray  *searchList; //關鍵字的歷史紀錄，user的searchHistory
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) NSString *keyWords;

- (IBAction)categoryButtonPressed:(id)sender;
@end
