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
#import "ChoseCategoryTableTableViewController.h"

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
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.myCategory = [userDefaults objectForKey:@"myCategory"];
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

- (void)viewDidAppear:(BOOL)animated {
    //先讀取本機資料
    if ([PFUser currentUser]) {
        //就新增
        myPreCategory = [PFObject objectWithClassName:@"LocalCurrentUser"];
        [myPreCategory setObject:[PFUser currentUser] forKey:@"user"];
        
        [self myCategory:@"isAll"];
        [self myCategory:@"isTWN"];
        [self myCategory:@"isUSA"];
        [self myCategory:@"isJPN"];
        [self myCategory:@"isCHN"];
        [self myCategory:@"isHKG"];
        [self myCategory:@"isKOR"];
        [self myCategory:@"isTHA"];
        [self myCategory:@"isSGP"];
        [self myCategory:@"isMYS"];
        [self myCategory:@"isNZL"];
        [self myCategory:@"isVNM"];
        [self myCategory:@"isDEU"];
        [self myCategory:@"isFRA"];
        [self myCategory:@"isGBR"];
        [self myCategory:@"isEU"];
        [self myCategory:@"isAUS"];
        [self myCategory:@"isAFR"];
        [self myCategory:@"isFor"];
        [self myCategory:@"isAsk"];
        [self myCategory:@"isRec"];
        
    }
    
    
    if ([[myPreCategory objectForKey:@"isTWN"] boolValue]) {
        [self.categoryButton setTitle:@"台灣" forState:UIControlStateNormal];
        self.myCategory = @"代買";
    }else if ([[myPreCategory objectForKey:@"isUSA"] boolValue]) {
        [self.categoryButton setTitle:@"美國" forState:UIControlStateNormal];
        self.myCategory = @"美國";
    }else if ([[myPreCategory objectForKey:@"isJPN"] boolValue]) {
        [self.categoryButton setTitle:@"日本" forState:UIControlStateNormal];
        self.myCategory = @"日本";
    }else if ([[myPreCategory objectForKey:@"isCHN"] boolValue]) {
        [self.categoryButton setTitle:@"中國" forState:UIControlStateNormal];
        self.myCategory = @"中國";
    }else if ([[myPreCategory objectForKey:@"isHKG"] boolValue]) {
        [self.categoryButton setTitle:@"香港" forState:UIControlStateNormal];
        self.myCategory = @"香港";
    }else if ([[myPreCategory objectForKey:@"isKOR"] boolValue]) {
        [self.categoryButton setTitle:@"韓國" forState:UIControlStateNormal];
        self.myCategory = @"韓國";
    }else if ([[myPreCategory objectForKey:@"isTHA"] boolValue]) {
        [self.categoryButton setTitle:@"泰國" forState:UIControlStateNormal];
        self.myCategory = @"泰國";
    }else if ([[myPreCategory objectForKey:@"isSGP"] boolValue]) {
        [self.categoryButton setTitle:@"新加坡" forState:UIControlStateNormal];
        self.myCategory = @"新加坡";
    }else if ([[myPreCategory objectForKey:@"isMYS"] boolValue]) {
        [self.categoryButton setTitle:@"馬來西亞" forState:UIControlStateNormal];
        self.myCategory = @"馬來西亞";
    }else if ([[myPreCategory objectForKey:@"isNZL"] boolValue]) {
        [self.categoryButton setTitle:@"紐西蘭" forState:UIControlStateNormal];
        self.myCategory = @"紐西蘭";
    }else if ([[myPreCategory objectForKey:@"isVNM"] boolValue]) {
        [self.categoryButton setTitle:@"越南" forState:UIControlStateNormal];
        self.myCategory = @"越南";
    }else if ([[myPreCategory objectForKey:@"isDEU"] boolValue]) {
        [self.categoryButton setTitle:@"德國" forState:UIControlStateNormal];
        self.myCategory = @"德國";
    }else if ([[myPreCategory objectForKey:@"isFRA"] boolValue]) {
        [self.categoryButton setTitle:@"法國" forState:UIControlStateNormal];
        self.myCategory = @"法國";
    }else if ([[myPreCategory objectForKey:@"isGBR"] boolValue]) {
        [self.categoryButton setTitle:@"英國" forState:UIControlStateNormal];
        self.myCategory = @"英國";
    }else if ([[myPreCategory objectForKey:@"isEU"] boolValue]) {
        [self.categoryButton setTitle:@"歐洲" forState:UIControlStateNormal];
        self.myCategory = @"歐洲";
    }else if ([[myPreCategory objectForKey:@"isAUS"] boolValue]) {
        [self.categoryButton setTitle:@"澳洲" forState:UIControlStateNormal];
        self.myCategory = @"澳洲";
    }else if ([[myPreCategory objectForKey:@"isAFR"] boolValue]) {
        [self.categoryButton setTitle:@"非洲" forState:UIControlStateNormal];
        self.myCategory = @"非洲";
    }else if ([[myPreCategory objectForKey:@"isFor"] boolValue]) {
        [self.categoryButton setTitle:@"外國" forState:UIControlStateNormal];
        self.myCategory = @"外國";
    }else if ([[myPreCategory objectForKey:@"isAsk"] boolValue]) {
        [self.categoryButton setTitle:@"徵求" forState:UIControlStateNormal];
        self.myCategory = @"徵求";
    }else if ([[myPreCategory objectForKey:@"isRec"] boolValue]) {
        [self.categoryButton setTitle:@"推薦" forState:UIControlStateNormal];
        self.myCategory = @"推薦";
    }else if ([[myPreCategory objectForKey:@"isAll"] boolValue]) {
        [self.categoryButton setTitle:@"不拘" forState:UIControlStateNormal];
        self.myCategory = @"";
    }
}

- (void) myCategory:(NSString *)category {
    if ([[PFUser currentUser] objectForKey:category] != Nil) {
        [myPreCategory setObject:[[PFUser currentUser] objectForKey:category] forKey:category];
    }else{
        [myPreCategory setObject:@NO forKey:category];
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
    
    if (self.myCategory.length > 0) {
        [query whereKey:@"category" equalTo:self.myCategory];
    }
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
    
    if (self.myCategory.length > 0) {
        [query whereKey:@"category" equalTo:self.myCategory];
    }
    
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

- (IBAction)categoryButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"category" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"helpBuyDetail"]) {
        HelpBuyDetailViewController *viewController = [segue destinationViewController];
        viewController.helpBuyObject = (PFObject *)sender;
    }else if ([segue.identifier isEqualToString:@"category"]) {
        ChoseCategoryTableTableViewController *viewcontroller = [segue destinationViewController];
        viewcontroller.delegate = self;
    }
}


#pragma ChoseCategoryDelegate
- (void)didSelectedCategory:(ChoseCategoryTableTableViewController *)controller Category:(NSString *)category{
    self.myCategory = category;
    [self loadObjects];
}

@end
