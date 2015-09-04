//
//  MyLoveHelpBuyTableViewController.m
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/9/4.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "MyLoveHelpBuyTableViewController.h"
#import "TTTTimeIntervalFormatter.h"
#import "PopTableViewCell.h"
#import "HelpBuyDetailViewController.h"

static TTTTimeIntervalFormatter *timeFormatter;

@interface MyLoveHelpBuyTableViewController ()

@end

@implementation MyLoveHelpBuyTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) { // This table displays items in the Todo class
        self.parseClassName = @"Love";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.parseClassName = @"Love";
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadObjects];
    
    //清空Tabbar的數值
    [[AppDelegate sharedDelegate] deleteTabBarBadge];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query includeKey:@"helpBuy"];
    [query whereKey:@"isLoved" equalTo:@YES];
    [query fromLocalDatastore];
    
    [query orderByDescending:@"updatedAt"];
    
    return query;
}

- (void)objectsDidLoad:(nullable NSError *)error {
    [super objectsDidLoad:error];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.objects.count) {
        PFObject *object = [[self objectAtIndexPath:indexPath] objectForKey:@"helpBuy"];
        PopTableViewCell *cell = (PopTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell startCanvasAnimation];
        
        [object setObject:@YES forKey:@"isSelected"];
        [object pinInBackground];
        
        cell.isSelectView.alpha = 0.3;
        
        [self performSegueWithIdentifier:@"helpBuyDetail" sender:object];
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
    cell.titleLabel.text = [object objectForKey:@"helpBuy"][@"title"];
    cell.categoryLabel.text = [object objectForKey:@"helpBuy"][@"category"];
    [cell.timeLabel setText:[timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:[[object objectForKey:@"helpBuy"] objectForKey:@"postDate"]]];
    
    cell.helpBuyObject = [object objectForKey:@"helpBuy"];
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"objectId" equalTo:[[object objectForKey:@"helpBuy"] objectId]];
    [query fromLocalDatastore];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object) {
            if ([[object objectForKey:@"isSelected"] boolValue]) {
                cell.isSelectView.alpha = 0.3;
            }
            
            if ([[object objectForKey:@"isLoved"] boolValue]) {
                [cell.isLovedButton setSelected:true];
            }else{
                [cell.isLovedButton setSelected:false];
            }
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
