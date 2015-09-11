//
//  MainTableViewController.h
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/8/31.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "PFQueryTableViewController.h"

@interface MainTableViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *categoryButton;

- (IBAction)categoryButtonPressed:(id)sender;
@end
