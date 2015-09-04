//
//  PopTableViewCell.m
//  Canvas
//
//  Created by 駿逸 陳 on 2015/8/27.
//  Copyright (c) 2015年 Canvas. All rights reserved.
//

#import "PopTableViewCell.h"
#import "AppDelegate.h"

@implementation PopTableViewCell
@synthesize helpBuyObject = _helpBuyObject;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)iLoveThisHelpBuy:(id)sender {
    if (self.isLovedButton.isSelected) {
        //Tabbar 的 count -1
        if ([[[AppDelegate sharedDelegate] getTabbarBadgeNumber] intValue] < 1) {
            
        }else{
            NSNumber *finalNumber = [NSNumber numberWithInt:([[[AppDelegate sharedDelegate] getTabbarBadgeNumber] intValue] - 1)];
            [[AppDelegate sharedDelegate] addTabBarBadge:finalNumber];
        }
       
        
        //已經加入追蹤
        [self.isLovedButton setSelected:false];
        
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Love"];
        [query whereKey:@"helpBuy" equalTo:_helpBuyObject];
        [query whereKey:@"user" equalTo:[PFUser currentUser]];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (object) {
                [object setObject:@NO forKey:@"isFollowed"];
                [object pinInBackground];

                PFACL *ACL = [PFACL ACL];
                [ACL setPublicReadAccess:YES];
                [ACL setPublicWriteAccess:YES];
                object.ACL = ACL;
                
                [object saveEventually:^(BOOL succeeded, NSError *error) {
                    
                }];
            }else{
                PFObject *LoveObject = [PFObject objectWithClassName:@"Love"];
                [LoveObject setObject:_helpBuyObject forKey:@"helpBuy"];
                [LoveObject setObject:[PFUser currentUser] forKey:@"user"];
                [LoveObject setObject:@NO forKey:@"isFollowed"];
                [LoveObject pinInBackground];
                
                PFACL *ACL = [PFACL ACL];
                [ACL setPublicReadAccess:YES];
                [ACL setPublicWriteAccess:YES];
                LoveObject.ACL = ACL;
                
                [LoveObject saveEventually:^(BOOL succeeded, NSError *error) {
                    
                }];
            }
            
        }];
    }else{
        //Tabbar 的 count +1
        
        NSNumber *finalNumber = [NSNumber numberWithInt:([[[AppDelegate sharedDelegate] getTabbarBadgeNumber] intValue] + 1)];
        [[AppDelegate sharedDelegate] addTabBarBadge:finalNumber];
        
        //尚未加入追蹤
        [self.isLovedButton setSelected:true];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Love"];
        [query whereKey:@"helpBuy" equalTo:_helpBuyObject];
        [query whereKey:@"user" equalTo:[PFUser currentUser]];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (object) {
                [object setObject:@YES forKey:@"isFollowed"];
                [object pinInBackground];
                
                PFACL *ACL = [PFACL ACL];
                [ACL setPublicReadAccess:YES];
                [ACL setPublicWriteAccess:YES];
                object.ACL = ACL;
                
                [object saveEventually:^(BOOL succeeded, NSError *error) {
                    
                }];
            }else{
                PFObject *LoveObject = [PFObject objectWithClassName:@"Love"];
                [LoveObject setObject:_helpBuyObject forKey:@"helpBuy"];
                [LoveObject setObject:[PFUser currentUser] forKey:@"user"];
                [LoveObject setObject:@YES forKey:@"isFollowed"];
                [LoveObject pinInBackground];
                
                PFACL *ACL = [PFACL ACL];
                [ACL setPublicReadAccess:YES];
                [ACL setPublicWriteAccess:YES];
                LoveObject.ACL = ACL;
                
                [LoveObject saveEventually:^(BOOL succeeded, NSError *error) {
                    
                }];
            }
        }];
    }
}
@end
