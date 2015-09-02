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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query orderByDescending:@"post"];
    
    return query;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PopTableViewCell *cell = (PopTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell startCanvasAnimation];
    
    cell.isSelectView.alpha = 0.3;
    
    PFObject *object = [self objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"helpBuyDetail" sender:object];
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
    cell.textLabel.text = object[@"title"];
    cell.categoryLabel.text = object[@"category"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 79.0f;
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
