//
//  PopTableViewCell.h
//  Canvas
//
//  Created by 駿逸 陳 on 2015/8/27.
//  Copyright (c) 2015年 Canvas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CSAnimationView.h>

@interface PopTableViewCell : PFTableViewCell

@property (strong, nonatomic) IBOutlet UIView *isSelectView;
@property (strong, nonatomic) IBOutlet CSAnimationView *categoryView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@end
