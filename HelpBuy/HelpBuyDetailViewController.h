//
//  HelpBuyDetailViewController.h
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/9/2.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpBuyDetailViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
@property (strong, nonatomic) PFObject *helpBuyObject;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (IBAction)followButtonPressed:(id)sender;
@end
