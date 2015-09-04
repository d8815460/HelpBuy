//
//  MainTableViewController.m
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/8/31.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "MainTableViewController.h"
#import "Canvas.h"
#import "PopTableViewCell.h"
#import "HelpBuyDetailViewController.h"
#import "TTTTimeIntervalFormatter.h"

static TTTTimeIntervalFormatter *timeFormatter;

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) { // This table displays items in the Todo class
        self.parseClassName = @"HelpBuy";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.parseClassName = @"HelpBuy";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!timeFormatter) {
        timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"category" notEqualTo:@"推薦"];
    [query whereKey:@"category" notEqualTo:@"公告"];
    [query whereKey:@"category" notEqualTo:@"問題"];
    [query whereKey:@"category" notEqualTo:@"板務"];
    [query whereKey:@"category" notEqualTo:@"情報"];
    [query whereKey:@"category" notEqualTo:@"檢舉"];
    [query whereKey:@"category" notEqualTo:@"參選"];
    
    [query orderByDescending:@"postDate"];
    
    return query;
}

- (void)objectsDidLoad:(nullable NSError *)error {
    [super objectsDidLoad:error];
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"category" notEqualTo:@"推薦"];
    [query whereKey:@"category" notEqualTo:@"公告"];
    [query whereKey:@"category" notEqualTo:@"問題"];
    [query whereKey:@"category" notEqualTo:@"板務"];
    [query whereKey:@"category" notEqualTo:@"情報"];
    [query whereKey:@"category" notEqualTo:@"檢舉"];
    [query whereKey:@"category" notEqualTo:@"參選"];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        self.mainTitleLabel.text = [NSString stringWithFormat:@"共%i筆代買資訊", number];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.objects.count) {
        PFObject *buyObject = [self objectAtIndexPath:indexPath];
        PopTableViewCell *cell = (PopTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell startCanvasAnimation];
        
        //先確認是否有DB資料
        PFQuery *query = [PFQuery queryWithClassName:@"Love"];
        [query whereKey:@"helpBuy" equalTo:buyObject];
        [query whereKey:@"user" equalTo:[PFUser currentUser]];
        [query fromLocalDatastore];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (object) {
                if (!object[@"isReaded"]) {
                    [object setObject:@YES forKey:@"isReaded"];
                    [object pinInBackground];
                    
                    PFACL *ACL = [PFACL ACL];
                    [ACL setPublicReadAccess:YES];
                    [ACL setPublicWriteAccess:YES];
                    object.ACL = ACL;
                    [object saveEventually];
                }
                
            }else{
                PFObject *SelectObject = [PFObject objectWithClassName:@"Love"];
                [SelectObject setObject:@YES forKey:@"isReaded"];
                [SelectObject setObject:[PFUser currentUser] forKey:@"user"];
                [SelectObject setObject:buyObject forKey:@"helpBuy"];
                [SelectObject pinInBackground];
                
                PFACL *ACL = [PFACL ACL];
                [ACL setPublicReadAccess:YES];
                [ACL setPublicWriteAccess:YES];
                SelectObject.ACL = ACL;
                [SelectObject saveEventually];
            }
        }];
        
        cell.isSelectView.alpha = 0.3;
        
        [self performSegueWithIdentifier:@"helpBuyDetail" sender:buyObject];
    }else if (self.paginationEnabled) {
        //load more
        [self loadNextPage];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PopTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell startCanvasAnimation];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *cellIdentifier = @"POPCell";
    
    PopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }

    // Configure the cell to show todo item with a priority at the bottom
    cell.titleLabel.text = object[@"title"];
    cell.categoryLabel.text = object[@"category"];
    [cell.timeLabel setText:[timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:[object objectForKey:@"postDate"]]];
    
    cell.helpBuyObject = object; //Parse上的物件
    
    PFQuery *query = [PFQuery queryWithClassName:@"Love"];
    [query whereKey:@"helpBuy" equalTo:object];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query fromLocalDatastore];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object) {
            if ([[object objectForKey:@"isFollowed"] boolValue]) {
                [cell.isLovedButton setSelected:true];
            }else{
                [cell.isLovedButton setSelected:false];
            }
            if ([[object objectForKey:@"isReaded"] boolValue]) {
                cell.isSelectView.alpha = 0.3;
            }else{
                cell.isSelectView.alpha = 1.0;
            }
        }else{
            cell.isSelectView.alpha = 1.0;
            [cell.isLovedButton setSelected:false];
        }
    }];
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.objects.count) {
        return 79.0f;
    } else if (self.paginationEnabled) {
        // load more
        return 44.0f;
    }
    return 44.0f;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"helpBuyDetail"]) {
        HelpBuyDetailViewController *viewController = [segue destinationViewController];
        viewController.helpBuyObject = (PFObject *)sender;
    }
}


@end
