//
//  HelpBuyDetailViewController.m
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/9/2.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "HelpBuyDetailViewController.h"

@interface HelpBuyDetailViewController ()

@end

@implementation HelpBuyDetailViewController
@synthesize helpBuyObject = _helpBuyObject;
@synthesize detailTextView = _detailTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _detailTextView.delegate = self;
    
    [_detailTextView setFont:[UIFont systemFontOfSize:17]];
    _detailTextView.text = [_helpBuyObject objectForKey:@"content"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
