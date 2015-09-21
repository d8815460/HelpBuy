//
//  SearchDetailTableViewController.m
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/9/20.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "SearchDetailTableViewController.h"
#import "PopTableViewCell.h"
#import "HelpBuyDetailViewController.h"
#import "TTTTimeIntervalFormatter.h"


static TTTTimeIntervalFormatter *timeFormatter;

@interface SearchDetailTableViewController ()

@end

@implementation SearchDetailTableViewController

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
    
    
    if (!timeFormatter) {
        timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"category" notEqualTo:@"推薦"];
    [query whereKey:@"category" notEqualTo:@"公告"];
    [query whereKey:@"category" notEqualTo:@"問題"];
    [query whereKey:@"category" notEqualTo:@"板務"];
    [query whereKey:@"category" notEqualTo:@"情報"];
    [query whereKey:@"category" notEqualTo:@"檢舉"];
    [query whereKey:@"category" notEqualTo:@"參選"];
    
    [query whereKey:@"content" containsString:[self.searchKey objectForKey:@"searchKey"]];
    
    [query orderByDescending:@"postDate"];
    
    return query;
}

- (void)objectsDidLoad:(nullable NSError *)error {
    [super objectsDidLoad:error];
    
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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"POPCell";
//    
//    
//    PopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
//        cell = [[PopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
//                                       reuseIdentifier:cellIdentifier];
//    }
//    
//    if (indexPath.row < self.objects.count) {
//        // Configure the cell to show todo item with a priority at the bottom
//        cell.titleLabel.text = [self.objects objectAtIndex:indexPath.row][@"title"];
//        cell.categoryLabel.text = [self.objects objectAtIndex:indexPath.row][@"category"];
//        [cell.timeLabel setText:[timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:[[self.objects objectAtIndex:indexPath.row] objectForKey:@"postDate"]]];
//        
//        cell.helpBuyObject = [self.objects objectAtIndex:indexPath.row]; //Parse上的物件
//        
//        PFQuery *query = [PFQuery queryWithClassName:@"Love"];
//        [query whereKey:@"helpBuy" equalTo:[self.objects objectAtIndex:indexPath.row]];
//        [query whereKey:@"user" equalTo:[PFUser currentUser]];
//        [query fromLocalDatastore];
//        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//            if (object) {
//                if ([[object objectForKey:@"isFollowed"] boolValue]) {
//                    [cell.isLovedButton setSelected:true];
//                }else{
//                    [cell.isLovedButton setSelected:false];
//                }
//                if ([[object objectForKey:@"isReaded"] boolValue]) {
//                    cell.isSelectView.alpha = 0.3;
//                }else{
//                    cell.isSelectView.alpha = 1.0;
//                }
//            }else{
//                cell.isSelectView.alpha = 1.0;
//                [cell.isLovedButton setSelected:false];
//            }
//        }];
//    }
//    
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *cellIdentifier = @"POPCell";
    
    
    
    
    PopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier];
    }
    
    
    if (indexPath.row < self.objects.count) {
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
    } else {
        
    }
    
    
    
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

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = 15;
    if(y > h + reload_distance) {
        NSLog(@"load more rows");
        [self loadNextPageInTable];
    }
}

-(void) loadNextPageInTable {
    
    [self loadNextPage];
    NSLog(@"NEW PAGE LOADED");
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


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
