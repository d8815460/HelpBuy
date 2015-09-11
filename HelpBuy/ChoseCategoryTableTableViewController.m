//
//  ChoseCategoryTableTableViewController.m
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/9/11.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "ChoseCategoryTableTableViewController.h"
#import "PopTableViewCell.h"
#import "DataLoader.h"

@interface ChoseCategoryTableTableViewController ()

@end

@implementation ChoseCategoryTableTableViewController
@synthesize items = _items;
@synthesize myPreCategory = _myPreCategory;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /*
     台灣     isTWN   0
     美國     isUSA   1
     日本     isJPN   2
     中國     isCHN   3
     香港     isHKG   4
     韓國     isKOR   5
     泰國     isTHA   6
     新加坡    isSGP   7
     馬來西亞   isMYS   8
     紐西蘭    isNZL   9
     越南     isVNM   10
     德國     isDEU   11
     法國     isFRA   12
     英國     isGBR   13
     歐洲     isEU    14
     澳洲     isAUS   15
     非洲     isAFR   16
     外國     isFor   17
     徵求     isAsk   18
     推薦     isRec   19
     //結束
     */
    
    if (!self.items) {
        self.items = [DataLoader mainCategory];
    }
    
    //先讀取本機資料
    if ([PFUser currentUser]) {
        //就新增
        _myPreCategory = [PFObject objectWithClassName:@"_User"];
        
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
        
    }else{
        
    }
}

- (void) myCategory:(NSString *)category {
    if ([[PFUser currentUser] objectForKey:category] != Nil) {
        [_myPreCategory setObject:[[PFUser currentUser] objectForKey:category] forKey:category];
    }else{
        [_myPreCategory setObject:@NO forKey:category];
    }
}

- (void) clearMyCategory {
    [_myPreCategory setObject:@NO forKey:@"isTWN"];
    [_myPreCategory setObject:@NO forKey:@"isUSA"];
    [_myPreCategory setObject:@NO forKey:@"isJPN"];
    [_myPreCategory setObject:@NO forKey:@"isCHN"];
    [_myPreCategory setObject:@NO forKey:@"isHKG"];
    [_myPreCategory setObject:@NO forKey:@"isKOR"];
    [_myPreCategory setObject:@NO forKey:@"isTHA"];
    [_myPreCategory setObject:@NO forKey:@"isSGP"];
    [_myPreCategory setObject:@NO forKey:@"isMYS"];
    [_myPreCategory setObject:@NO forKey:@"isNZL"];
    [_myPreCategory setObject:@NO forKey:@"isVNM"];
    [_myPreCategory setObject:@NO forKey:@"isDEU"];
    [_myPreCategory setObject:@NO forKey:@"isFRA"];
    [_myPreCategory setObject:@NO forKey:@"isGBR"];
    [_myPreCategory setObject:@NO forKey:@"isEU"];
    [_myPreCategory setObject:@NO forKey:@"isAUS"];
    [_myPreCategory setObject:@NO forKey:@"isAFR"];
    [_myPreCategory setObject:@NO forKey:@"isFor"];
    [_myPreCategory setObject:@NO forKey:@"isAsk"];
    [_myPreCategory setObject:@NO forKey:@"isRec"];
    
    [[PFUser currentUser] setObject:@NO forKey:@"isTWN"];
    [[PFUser currentUser] setObject:@NO forKey:@"isUSA"];
    [[PFUser currentUser] setObject:@NO forKey:@"isJPN"];
    [[PFUser currentUser] setObject:@NO forKey:@"isCHN"];
    [[PFUser currentUser] setObject:@NO forKey:@"isHKG"];
    [[PFUser currentUser] setObject:@NO forKey:@"isKOR"];
    [[PFUser currentUser] setObject:@NO forKey:@"isTHA"];
    [[PFUser currentUser] setObject:@NO forKey:@"isSGP"];
    [[PFUser currentUser] setObject:@NO forKey:@"isMYS"];
    [[PFUser currentUser] setObject:@NO forKey:@"isNZL"];
    [[PFUser currentUser] setObject:@NO forKey:@"isVNM"];
    [[PFUser currentUser] setObject:@NO forKey:@"isDEU"];
    [[PFUser currentUser] setObject:@NO forKey:@"isFRA"];
    [[PFUser currentUser] setObject:@NO forKey:@"isGBR"];
    [[PFUser currentUser] setObject:@NO forKey:@"isEU"];
    [[PFUser currentUser] setObject:@NO forKey:@"isAUS"];
    [[PFUser currentUser] setObject:@NO forKey:@"isAFR"];
    [[PFUser currentUser] setObject:@NO forKey:@"isFor"];
    [[PFUser currentUser] setObject:@NO forKey:@"isAsk"];
    [[PFUser currentUser] setObject:@NO forKey:@"isRec"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    static NSString *cellIdentifier = @"CategoryCell";
    
    PopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isTWN"] boolValue]];
        cell.titleLabel.text = @"台灣地區";
        cell.categoryLabel.text = @"代買";
    }
    if (indexPath.row == 1) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isUSA"] boolValue]];
        cell.titleLabel.text = @"美國地區";
        cell.categoryLabel.text = @"美國";
    }
    if (indexPath.row == 2) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isJPN"] boolValue]];
        cell.titleLabel.text = @"日本地區";
        cell.categoryLabel.text = @"日本";
    }
    if (indexPath.row == 3) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isCHN"] boolValue]];
        cell.titleLabel.text = @"中國地區";
        cell.categoryLabel.text = @"中國";
    }
    if (indexPath.row == 4) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isHKG"] boolValue]];
        cell.titleLabel.text = @"香港地區";
        cell.categoryLabel.text = @"香港";
    }
    if (indexPath.row == 5) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isKOR"] boolValue]];
        cell.titleLabel.text = @"韓國地區";
        cell.categoryLabel.text = @"韓國";
    }
    if (indexPath.row == 6) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isTHA"] boolValue]];
        cell.titleLabel.text = @"泰國地區";
        cell.categoryLabel.text = @"泰國";
    }
    if (indexPath.row == 7) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isSGP"] boolValue]];
        cell.titleLabel.text = @"新加坡地區";
        cell.categoryLabel.text = @"新加坡";
    }
    if (indexPath.row == 8) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isMYS"] boolValue]];
        cell.titleLabel.text = @"馬來西亞地區";
        cell.categoryLabel.text = @"買來西亞";
    }
    if (indexPath.row == 9) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isNZL"] boolValue]];
        cell.titleLabel.text = @"紐西蘭地區";
        cell.categoryLabel.text = @"紐西蘭";
    }
    if (indexPath.row == 10) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isVNM"] boolValue]];
        cell.titleLabel.text = @"越南地區";
        cell.categoryLabel.text = @"越南";
    }
    if (indexPath.row == 11) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isDEU"] boolValue]];
        cell.titleLabel.text = @"德國地區";
        cell.categoryLabel.text = @"德國";
    }
    if (indexPath.row == 12) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isFRA"] boolValue]];
        cell.titleLabel.text = @"法國地區";
        cell.categoryLabel.text = @"法國";
    }
    if (indexPath.row == 13) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isGBR"] boolValue]];
        cell.titleLabel.text = @"英國地區";
        cell.categoryLabel.text = @"英國";
    }
    if (indexPath.row == 14) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isEU"] boolValue]];
        cell.titleLabel.text = @"歐洲地區";
        cell.categoryLabel.text = @"歐洲";
    }
    if (indexPath.row == 15) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isAUS"] boolValue]];
        cell.titleLabel.text = @"澳洲地區";
        cell.categoryLabel.text = @"澳洲";
    }
    if (indexPath.row == 16) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isAFR"] boolValue]];
        cell.titleLabel.text = @"非洲地區";
        cell.categoryLabel.text = @"非洲";
    }
    if (indexPath.row == 17) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isFor"] boolValue]];
        cell.titleLabel.text = @"外國地區";
        cell.categoryLabel.text = @"外國";
    }
    if (indexPath.row == 18) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isAsk"] boolValue]];
        cell.titleLabel.text = @"買家徵求代買";
        cell.categoryLabel.text = @"徵求";
    }
    if (indexPath.row == 19) {
        [self cellObject:cell isSelected:[[_myPreCategory objectForKey:@"isRec"] boolValue]];
        cell.titleLabel.text = @"買家推薦優良代買者";
        cell.categoryLabel.text = @"推薦";
    }
    
    return cell;
}

- (void)cellObject:(UITableViewCell *)cell isSelected:(BOOL)isSelected{
    
    
    if (isSelected) {
        [[(PopTableViewCell *)cell isSelectedLabel] setHidden:NO];
    }else{
        [[(PopTableViewCell *)cell isSelectedLabel] setHidden:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //先清空個人設定，再勾選所選擇的類別
    [self clearMyCategory];
    
    PopTableViewCell *cell;

    for (int i = 0; i < 20; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:(NSInteger)i inSection:0];
        cell = (PopTableViewCell *)[tableView cellForRowAtIndexPath:index];
        [[(PopTableViewCell *)cell isSelectedLabel] setHidden:YES];
    }
    
    cell = (PopTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([[cell isSelectedLabel] isHidden]) {
        [[(PopTableViewCell *)cell isSelectedLabel] setHidden:NO];
        [self categoryCell:cell saveSelected:YES AtIndex:indexPath];
    }
    
    PFACL *ACL = [PFACL ACL];
    [ACL setPublicReadAccess:YES];
    [PFUser currentUser].ACL = ACL;
    
    
    
    [[PFUser currentUser] saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [[PFUser currentUser] refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (!error) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    // error
                }
            }];
        }else{
            // save error
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

- (void)categoryCell:(PopTableViewCell *)cell saveSelected:(BOOL)Selected AtIndex:(NSIndexPath *)indexPath{
    // Configure the cell...
    if (indexPath.row == 0) {
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isTWN"];
        [[PFUser currentUser] setObject:@YES forKey:@"isTWN"];
    }else if (indexPath.row == 1){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isUSA"];
        [[PFUser currentUser] setObject:@YES forKey:@"isUSA"];
    }else if (indexPath.row == 2){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isJPN"];
        [[PFUser currentUser] setObject:@YES forKey:@"isJPN"];
    }else if (indexPath.row == 3){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isCHN"];
        [[PFUser currentUser] setObject:@YES forKey:@"isCHN"];
    }else if (indexPath.row == 4){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isHKG"];
        [[PFUser currentUser] setObject:@YES forKey:@"isHKG"];
    }else if (indexPath.row == 5){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isKOR"];
        [[PFUser currentUser] setObject:@YES forKey:@"isKOR"];
    }else if (indexPath.row == 6){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isTHA"];
        [[PFUser currentUser] setObject:@YES forKey:@"isTHA"];
    }else if (indexPath.row == 7){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isSGP"];
        [[PFUser currentUser] setObject:@YES forKey:@"isSGP"];
    }else if (indexPath.row == 8){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isMYS"];
        [[PFUser currentUser] setObject:@YES forKey:@"isMYS"];
    }else if (indexPath.row == 9){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isNZL"];
        [[PFUser currentUser] setObject:@YES forKey:@"isNZL"];
    }else if (indexPath.row == 10){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isVNM"];
        [[PFUser currentUser] setObject:@YES forKey:@"isVNM"];
    }else if (indexPath.row == 11){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isDEU"];
        [[PFUser currentUser] setObject:@YES forKey:@"isDEU"];
    }else if (indexPath.row == 12){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isFRA"];
        [[PFUser currentUser] setObject:@YES forKey:@"isFRA"];
    }else if (indexPath.row == 13){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isGBR"];
        [[PFUser currentUser] setObject:@YES forKey:@"isGBR"];
    }else if (indexPath.row == 14){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isEU"];
        [[PFUser currentUser] setObject:@YES forKey:@"isEU"];
    }else if (indexPath.row == 15){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isAUS"];
        [[PFUser currentUser] setObject:@YES forKey:@"isAUS"];
    }else if (indexPath.row == 16){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isAFR"];
        [[PFUser currentUser] setObject:@YES forKey:@"isAFR"];
    }else if (indexPath.row == 17){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isFor"];
        [[PFUser currentUser] setObject:@YES forKey:@"isFor"];
    }else if (indexPath.row == 18){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isAsk"];
        [[PFUser currentUser] setObject:@YES forKey:@"isAsk"];
    }else if (indexPath.row == 19){
        [_myPreCategory setObject:[NSNumber numberWithBool:Selected] forKey:@"isRec"];
        [[PFUser currentUser] setObject:@YES forKey:@"isRec"];
    }
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
