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
    
    PFQuery *myLoveQuery = [PFQuery queryWithClassName:@"Love"];
    [myLoveQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [myLoveQuery whereKey:@"helpBuy" equalTo:_helpBuyObject];
    [myLoveQuery fromLocalDatastore];
    [myLoveQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            if ([[object objectForKey:@"isFollowed"] boolValue]) {
                [self.followButton setTitle:@"不追蹤" forState:UIControlStateNormal];
            }
        }
    }];
    
    self.userNameLabel.text = [NSString stringWithFormat:@"作者：%@", [_helpBuyObject objectForKey:@"author"]];
    
    [self.navigationController.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
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

- (IBAction)followButtonPressed:(id)sender {
    
    PFQuery *loveQuery = [PFQuery queryWithClassName:@"Love"];
    [loveQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [loveQuery whereKey:@"helpBuy" equalTo:_helpBuyObject];
    [loveQuery fromLocalDatastore];
    PFACL *ACL = [PFACL ACL];
    [ACL setPublicReadAccess:YES];
    [ACL setPublicWriteAccess:YES];
    
    [loveQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (!error) {
            if ([self.followButton.titleLabel.text isEqualToString:@"追蹤"]) {
                [self.followButton setTitle:@"不追蹤" forState:UIControlStateNormal];
                object.ACL = ACL;
                [object setObject:[NSNumber numberWithBool:TRUE] forKey:@"isFollowed"];
                
                //Tabbar 的 count +1
                
                NSNumber *finalNumber = [NSNumber numberWithInt:([[[AppDelegate sharedDelegate] getTabbarBadgeNumber] intValue] + 1)];
                [[AppDelegate sharedDelegate] addTabBarBadge:finalNumber];
            }else{
                [self.followButton setTitle:@"追蹤" forState:UIControlStateNormal];
                object.ACL = ACL;
                [object setObject:[NSNumber numberWithBool:FALSE] forKey:@"isFollowed"];
                
                //Tabbar 的 count -1
                if ([[[AppDelegate sharedDelegate] getTabbarBadgeNumber] intValue] < 1) {
                    
                }else{
                    NSNumber *finalNumber = [NSNumber numberWithInt:([[[AppDelegate sharedDelegate] getTabbarBadgeNumber] intValue] - 1)];
                    [[AppDelegate sharedDelegate] addTabBarBadge:finalNumber];
                }
            }
            [object pinInBackground];
            [object saveEventually];
            
        }
        
    }];
    
    
}
@end
