//
//  CMUtility.m
//  chatMessenger
//
//  Created by Ayi on 2014/3/4.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#import "CMUtility.h"
#import "UIImage+ResizeAdditions.h"
#import <MBProgressHUD.h>
#import <JSONKit.h>
#import "CMConstants.h"
#import "CMCache.h"

typedef enum {
    ADVNavigationTypeTab = 0,
    ADVNavigationTypeMenu
} ADVNavigationType;

@implementation CMUtility

+ (CGFloat)getScreenWidth {
    UIViewController *root = [[UIApplication sharedApplication] keyWindow].rootViewController;
    return root.presentedViewController.view.bounds.size.width;
}

+ (CGFloat)getScreenHeight {
    UIViewController *root = [[UIApplication sharedApplication] keyWindow].rootViewController;
    return root.presentedViewController.view.bounds.size.height;
}

+ (NSInteger)windowWidth {
    UIWindow *win = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    return win.frame.size.width;
}
+ (NSInteger)windowHeight {
    UIWindow *win = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    return win.frame.size.height;
}

#pragma mark Like Photos
+ (void)likePhotoInBackground:(id)photo block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
//    PFQuery *queryExistingLikes = [PFQuery queryWithClassName:kPAPActivityClassKey];
//    [queryExistingLikes whereKey:kPAPActivityPhotoKey equalTo:photo];
//    [queryExistingLikes whereKey:kPAPActivityTypeKey equalTo:kPAPActivityTypeLike];
//    [queryExistingLikes whereKey:kPAPActivityFromUserKey equalTo:[PFUser currentUser]];
//    [queryExistingLikes setCachePolicy:kPFCachePolicyNetworkOnly];
//    [queryExistingLikes findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
    
        // proceed to creating new like
        PFObject *likeActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
        [likeActivity setObject:kPAPActivityTypeLike forKey:kPAPActivityTypeKey];
        [likeActivity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
//        [likeActivity setObject:[photo objectForKey:kTaskOwner_User] forKey:kPAPActivityToUserKey];
        [likeActivity setObject:photo forKey:kPAPActivityDateKey];
        
        PFACL *likeACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [likeACL setPublicReadAccess:YES];
        likeActivity.ACL = likeACL;
        
//        [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (completionBlock) {
//                completionBlock(succeeded,error);
//            }
//            
//            if (succeeded && ![[[photo objectForKey:kTaskOwner_User] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
//                NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", [[photo objectForKey:kTaskOwner_User] objectId]];
//                if (privateChannelName && privateChannelName.length != 0) {
//                    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
//                                          [NSString stringWithFormat:@"%@喜歡你的任務。", [CMUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey]]], kAPNSAlertKey,
//                                          kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
//                                          kPAPPushPayloadActivityLikeKey, kPAPPushPayloadActivityTypeKey,
//                                          [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,
//                                          [photo objectId], kPAPPushPayloadPhotoObjectIdKey,
//                                          @"Increment",kAPNSBadgeKey,
//                                          @"action", @"tw.com.taiwan8.CUSTOM_BROADCAST",
//                                          nil];
//                    PFPush *push = [[PFPush alloc] init];
//                    [push setChannel:privateChannelName];
//                    [push setData:data];
//                    [push sendPushInBackground];
//                }
//            }
//            
//            // refresh cache
//            PFQuery *query = [CMUtility queryForActivitiesOnPhoto:photo cachePolicy:kPFCachePolicyNetworkOnly];
//            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                if (!error) {
//                    
//                    NSMutableArray *likers = [NSMutableArray array];
//                    NSMutableArray *commenters = [NSMutableArray array];
//                    
//                    
//                    BOOL isLikedByCurrentUser = NO;
//                    
//                    for (PFObject *activity in objects) {
//                        if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike] && [activity objectForKey:kPAPActivityFromUserKey]) {
//                            [likers addObject:[activity objectForKey:kPAPActivityFromUserKey]];
//                        } else if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeComment] && [activity objectForKey:kPAPActivityFromUserKey]) {
//                            [commenters addObject:[activity objectForKey:kPAPActivityFromUserKey]];
//                        }
//                        
//                        if ([[[activity objectForKey:kPAPActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
//                            if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike]) {
//                                isLikedByCurrentUser = YES;
//                            }
//                        }
//                    }
//                    
//                    [[CMCache sharedCache] setAttributesForPhoto:photo likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
//                }
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:photo userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:succeeded] forKey:PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey]];
//            }];
//            
//        }];
//    }];
    
    /*
     // like photo in Facebook if possible
     NSString *fbOpenGraphID = [photo objectForKey:kPAPPhotoOpenGraphIDKey];
     if (fbOpenGraphID && fbOpenGraphID.length > 0) {
     NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
     NSString *objectURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@", fbOpenGraphID];
     [params setObject:objectURL forKey:@"object"];
     [[PFFacebookUtils facebook] requestWithGraphPath:@"me/og.likes" andParams:params andHttpMethod:@"POST" andDelegate:nil];
     }
     */
}

+ (void)unlikePhotoInBackground:(id)photo block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    PFQuery *queryExistingLikes = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryExistingLikes whereKey:kPAPActivityDateKey equalTo:photo];
    [queryExistingLikes whereKey:kPAPActivityTypeKey equalTo:kPAPActivityTypeLike];
    [queryExistingLikes whereKey:kPAPActivityFromUserKey equalTo:[PFUser currentUser]];
    [queryExistingLikes setCachePolicy:kPFCachePolicyNetworkOnly];
    [queryExistingLikes findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        if (!error) {
            for (PFObject *activity in activities) {
                [activity delete];
            }
            
            if (completionBlock) {
                completionBlock(YES,nil);
            }
            
            // refresh cache
            PFQuery *query = [CMUtility queryForActivitiesOnPhoto:photo cachePolicy:kPFCachePolicyNetworkOnly];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    NSMutableArray *likers = [NSMutableArray array];
                    NSMutableArray *commenters = [NSMutableArray array];
                    
                    BOOL isLikedByCurrentUser = NO;
                    
                    for (PFObject *activity in objects) {
                        if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike]) {
                            [likers addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        } else if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeComment]) {
                            [commenters addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        }
                        
                        if ([[[activity objectForKey:kPAPActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                            if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike]) {
                                isLikedByCurrentUser = YES;
                            }
                        }
                    }
                    
                    [[CMCache sharedCache] setAttributesForPhoto:photo likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:photo userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey]];
            }];
            
        } else {
            if (completionBlock) {
                completionBlock(NO,error);
            }
        }
    }];  
}


#pragma mark Activities

+ (PFQuery *)queryForActivitiesOnPhoto:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy {
    PFQuery *queryLikes = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryLikes whereKey:kPAPActivityDateKey equalTo:photo];
    [queryLikes whereKey:kPAPActivityTypeKey equalTo:kPAPActivityTypeLike];
    
    PFQuery *queryComments = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryComments whereKey:kPAPActivityDateKey equalTo:photo];
    [queryComments whereKey:kPAPActivityTypeKey equalTo:kPAPActivityTypeComment];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:queryLikes,queryComments,nil]];
    [query setCachePolicy:cachePolicy];
    [query includeKey:kPAPActivityFromUserKey];
    [query includeKey:kPAPActivityDateKey];
    
    return query;
}

+ (PFQuery *)queryForActivitiesOnDate:(PFObject *)date cachePolicy:(PFCachePolicy)cachePolicy {
    PFQuery *queryAskers = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryAskers whereKey:@"fromDate" equalTo:date];
    [queryAskers whereKey:@"type" equalTo:@"ask"];
    
    PFQuery *queryComments = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryComments whereKey:@"fromDate" equalTo:date];
    [queryComments whereKey:@"type" equalTo:@"comment"];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:queryAskers, queryComments, nil]];
    [query fromLocalDatastore];
//    [query setCachePolicy:cachePolicy];
    [query includeKey:kPAPActivityFromUserKey];
    [query includeKey:@"fromDate"];
    
    return query;
}

#pragma mark Facebook

+ (void)processFacebookProfilePictureData:(NSData *)newProfilePictureData {
    if (newProfilePictureData.length == 0) {
        return;
    }
    
    // The user's Facebook profile picture is cached to disk. Check if the cached profile picture data matches the incoming profile picture. If it does, avoid uploading this data to Parse.
    
    NSURL *cachesDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]; // iOS Caches directory
    
    NSURL *profilePictureCacheURL = [cachesDirectoryURL URLByAppendingPathComponent:@"FacebookProfilePicture.jpg"];
    
    //如果檔案照片一致就不需要再重新上傳。
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[profilePictureCacheURL path]]) {
//    // We have a cached Facebook profile picture
//        NSData *oldProfilePictureData = [NSData dataWithContentsOfFile:[profilePictureCacheURL path]];
//        if ([oldProfilePictureData isEqualToData:newProfilePictureData]) {
//            return;
//        }
//    }
    
    BOOL cachedToDisk = [[NSFileManager defaultManager] createFileAtPath:[profilePictureCacheURL path] contents:newProfilePictureData attributes:nil];
    NSLog(@"磁碟高速緩存個人檔案照片: %d", cachedToDisk);
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
//    SetProfileViewController *setProfile = (SetProfileViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"setProfile"];
//    [setProfile viewDidAppear:YES];
    
    UIImage *image = [UIImage imageWithData:newProfilePictureData];
    UIImage *mediumImage = [image thumbnailImage:640 transparentBorder:0 cornerRadius:160 interpolationQuality:kCGInterpolationHigh];
    UIImage *smallRoundedImage = [image thumbnailImage:64 transparentBorder:0 cornerRadius:32 interpolationQuality:kCGInterpolationLow];
    
    NSData *mediumImageData = UIImagePNGRepresentation(mediumImage); // using JPEG for larger pictures
    NSData *smallRoundedImageData = UIImagePNGRepresentation(smallRoundedImage);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:UIImagePNGRepresentation(mediumImage) forKey:@"mediumImage"];
    [userDefaults setObject:UIImagePNGRepresentation(smallRoundedImage) forKey:@"smallRoundedImage"];
    [userDefaults synchronize];
    
    //创建文件管理器
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    // 创建profile目录 //在Documents里创建目录
//    NSString *profileDirectory = [documentsDirectory stringByAppendingPathComponent:@"profile"];
//    [fileManager createDirectoryAtPath:profileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//    //更改到待操作的目录下
//    [fileManager changeCurrentDirectoryPath:[profileDirectory stringByExpandingTildeInPath]];
//    //在profile目录下创建文件
//    NSString *profileMediumPath = [profileDirectory stringByAppendingPathComponent:@"medium.png"];
//    NSString *profileSmallPath = [profileDirectory stringByAppendingPathComponent:@"small.png"];
//    //寫入檔案
//    [fileManager createFileAtPath:profileMediumPath contents:mediumImageData attributes:nil];
//    [fileManager createFileAtPath:profileSmallPath contents:smallRoundedImageData attributes:nil];
    
    //讀取檔案
    //    NSData *reader = [NSData dataWithContentsOfFile:path];
    /*
     其他地方可以用這個方法去取回當前用戶的大頭照。
     NSData *mediumimageData = [NSData dataWithContentsOfFile:mediumpath];
     NSData *smallimageData = [NSData dataWithContentsOfFile:smallpath];
     */
    PFUser *user = [PFUser currentUser];
    
    if (user.isNew) {
        PFObject *userPhotos = [PFObject objectWithClassName:@"UserPhotos"];
        [userPhotos setObject:[PFUser currentUser] forKey:@"UserID"];
        
        PFACL *ACL = [PFACL ACL];
        [ACL setPublicReadAccess:YES];
        [ACL setPublicWriteAccess:YES];
        userPhotos.ACL = ACL;
        
        if (smallRoundedImageData.length > 0) {
            NSLog(@"小型個人檔案照片上載中...");
            PFFile *fileSmallRoundedImage = [PFFile fileWithData:smallRoundedImageData];
            [fileSmallRoundedImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"小型個人檔案照片上載完成。");
                    PFUser *currentMyFile = [PFUser currentUser];
                    [currentMyFile setObject:fileSmallRoundedImage forKey:kPAPUserProfilePicSmallKey];
                    [userPhotos setObject:fileSmallRoundedImage forKey:kPAPUserProfilePicSmallKey];
                    [currentMyFile saveEventually:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSLog(@"小型個人檔案照片應該要確實上傳到資料庫。");
                            [userPhotos saveEventually:^(BOOL succeeded, NSError *error) {
                                if (succeeded) {
                                    if (mediumImageData.length > 0) {
                                        NSLog(@"中型個人檔案照片上載中...");
                                        PFFile *fileMediumImage = [PFFile fileWithData:mediumImageData];
                                        
                                        [fileMediumImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                            if (succeeded) {
                                                NSLog(@"中型個人檔案照片上載完成。");
                                                [userPhotos setObject:fileMediumImage forKey:kPAPUserProfilePicMediumKey];
                                                [userPhotos saveEventually:^(BOOL succeeded, NSError *error) {
                                                    
                                                }];
                                                PFUser *currentMyFile = [PFUser currentUser];
                                                [currentMyFile setObject:fileMediumImage forKey:kPAPUserProfilePicMediumKey];
                                                
                                                PFACL *ACL = [PFACL ACL];
                                                [ACL setPublicReadAccess:YES];
                                                currentMyFile.ACL = ACL;
                                                
                                                [currentMyFile saveEventually:^(BOOL succeeded, NSError *error) {
                                                    if (!error) {
                                                        NSLog(@"中型個人檔案照片應該要確實上傳到資料庫。");
                                                    }else {
                                                        NSLog(@"中型個人檔案照片出錯囉！");
                                                    }
                                                }];
                                            }
                                        }];
                                    }
                                }
                            }];
                        }else{
                            NSLog(@"小型個人檔案照片出錯囉！");
                        }
                    }];
                }
            }];
        }
    }else{
        
        if (smallRoundedImageData.length > 0) {
            NSLog(@"小型個人檔案照片上載中...");
            PFFile *fileSmallRoundedImage = [PFFile fileWithData:smallRoundedImageData];
            [fileSmallRoundedImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"小型個人檔案照片上載完成。");
                    PFUser *currentMyFile = [PFUser currentUser];
                    [currentMyFile setObject:fileSmallRoundedImage forKey:kPAPUserProfilePicSmallKey];
//                    [currentMyFile saveEventually:^(BOOL succeeded, NSError *error) {
//                        if (succeeded) {
                            NSLog(@"小型個人檔案照片應該要確實上傳到資料庫。");
//                            [userPhotos saveEventually:^(BOOL succeeded, NSError *error) {
//                                if (succeeded) {
                                    if (mediumImageData.length > 0) {
                                        NSLog(@"中型個人檔案照片上載中...");
                                        PFFile *fileMediumImage = [PFFile fileWithData:mediumImageData];
                                        [fileMediumImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                            if (succeeded) {
                                                NSLog(@"中型個人檔案照片上載完成。");
                                                
                                                [currentMyFile setObject:fileMediumImage forKey:kPAPUserProfilePicMediumKey];
                                                
                                                PFACL *ACL = [PFACL ACL];
                                                [ACL setPublicReadAccess:YES];
                                                currentMyFile.ACL = ACL;
                                                
                                                [currentMyFile saveEventually:^(BOOL succeeded, NSError *error) {
                                                    if (!error) {
                                                        NSLog(@"中型個人檔案照片應該要確實上傳到資料庫。");
                                                    }else {
                                                        NSLog(@"中型個人檔案照片出錯囉！");
                                                    }
                                                }];
                                            }
                                        }];
                                    }
//                                }
//                            }];
//                        }else{
//                            NSLog(@"小型個人檔案照片出錯囉！");
//                        }
//                    }];
                }
            }];
        }
    }
}



#pragma mark User Following

+ (void)followUserInBackground:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
    [followActivity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
    [followActivity setObject:user forKey:kPAPActivityToUserKey];
    [followActivity setObject:kPAPActivityTypeFollow forKey:kPAPActivityTypeKey];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, error);
        }
        
        if (succeeded) {
            [CMUtility sendFollowingPushNotification:user];  //移除好友安裝wheels的推播。
        }
    }];
    [[CMCache sharedCache] setFollowStatus:YES user:user];
}

+ (void)followUserEventually:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
    [followActivity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
    [followActivity setObject:user forKey:kPAPActivityToUserKey];
    [followActivity setObject:kPAPActivityTypeFollow forKey:kPAPActivityTypeKey];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveEventually:completionBlock];
    [[CMCache sharedCache] setFollowStatus:YES user:user];
}

+ (void)followUsersEventually:(NSArray *)users block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    for (PFUser *user in users) {
        [CMUtility followUserEventually:user block:completionBlock];
        [[CMCache sharedCache] setFollowStatus:YES user:user];
    }
}

+ (void)unfollowUserEventually:(PFUser *)user {
    PFQuery *query = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [query whereKey:kPAPActivityFromUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kPAPActivityToUserKey equalTo:user];
    [query whereKey:kPAPActivityTypeKey equalTo:kPAPActivityTypeFollow];
    [query findObjectsInBackgroundWithBlock:^(NSArray *followActivities, NSError *error) {
        // While normally there should only be one follow activity returned, we can't guarantee that.
        
        if (!error) {
            for (PFObject *followActivity in followActivities) {
                [followActivity deleteEventually];
            }
        }
    }];
    [[CMCache sharedCache] setFollowStatus:NO user:user];
}

+ (void)unfollowUsersEventually:(NSArray *)users {
    PFQuery *query = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [query whereKey:kPAPActivityFromUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kPAPActivityToUserKey containedIn:users];
    [query whereKey:kPAPActivityTypeKey equalTo:kPAPActivityTypeFollow];
    [query findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        for (PFObject *activity in activities) {
            [activity deleteEventually];
        }
    }];
    for (PFUser *user in users) {
        [[CMCache sharedCache] setFollowStatus:NO user:user];
    }
}


#pragma mark Add User To Group
+ (void)addUserToGroupInBackground:(PFUser *)user toGroup:(PFObject *)group block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:@"MyGroupsList"];
    [followActivity setObject:group forKey:@"myGroupsID"];
    [followActivity setObject:user forKey:@"myFriendsID"];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    [followACL setPublicWriteAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveEventually:completionBlock];
    [[CMCache sharedCache] setAddToGroupStatus:YES ToGroup:group user:user];
}
+ (void)addUserToGroupEventually:(PFUser *)user toGroup:(PFObject *)group block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:@"MyGroupsList"];
    [followActivity setObject:group forKey:@"myGroupsID"];
    [followActivity setObject:user forKey:@"myFriendsID"];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    [followACL setPublicWriteAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveEventually:completionBlock];
    [[CMCache sharedCache] setAddToGroupStatus:YES ToGroup:group user:user];
}
+ (void)addUsersToGroupEventually:(NSArray *)users toGroup:(PFObject *)group block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
}
+ (void)unaddToGroupUserEventually:(PFUser *)user fromGroup:(PFObject *)group{
    PFQuery *query = [PFQuery queryWithClassName:@"MyGroupsList"];
    [query whereKey:@"myGroupsID" equalTo:group];
    [query whereKey:@"myFriendsID" equalTo:user];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *followActivities, NSError *error) {
        // While normally there should only be one follow activity returned, we can't guarantee that.
        
        if (!error) {
            for (PFObject *followActivity in followActivities) {
                [followActivity deleteEventually];
            }
        }
    }];
    [[CMCache sharedCache] setAddToGroupStatus:NO ToGroup:group user:user];
//    [[CMCache sharedCache] setFollowStatus:NO user:user];
}
+ (void)unaddToGroupUsersEventually:(NSArray *)users fromGroup:(PFObject *)group{
    
}


#pragma mark Add User To Helperlist
+ (void)addUserToHelperListInBackground:(PFUser *)user toCase:(PFObject *)cases block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
}
+ (void)addUserToHelperListEventually:(PFUser *)user toCase:(PFObject *)cases block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    int peopleamount=[cases[@"peopleAmount"] intValue];
    PFQuery *query = [PFQuery queryWithClassName:@"CasesHelperList"];
    [query whereKey:@"caseID" equalTo:cases];
    [query whereKey:@"isYou" equalTo:[NSNumber numberWithBool:TRUE]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //這裡面是找到已經被業主選擇的人。
            // The find succeeded.
            // Do something with the found objects
            if([objects count] >0){
                //如果需求人數已經大於等於被選擇的人了，就新增。存isYou = True。
                if(peopleamount > [objects count]){
                    PFQuery *query = [PFQuery queryWithClassName:@"CasesHelperList"];
                    [query whereKey:@"caseID" equalTo:cases];
                    [query whereKey:@"userID" equalTo:user];
                    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                        [object setObject:[NSNumber numberWithBool:TRUE] forKey:@"isYou"];
                        
                        PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
                        [followACL setPublicReadAccess:YES];
                        [followACL setPublicWriteAccess:YES];
                        object.ACL = followACL;
                        
                        [object saveEventually:^(BOOL succeeded, NSError *error) {
                            if (succeeded) {
                                completionBlock(succeeded,nil);
                            }
                        }];
                        
                        //如果選擇你剛好等於需求人數，就要通知其他幫手落選了。
                        if (peopleamount == [objects count]+1) {
                            //先把剩下的其他人撈出來
                            PFQuery *query = [PFQuery queryWithClassName:@"CasesHelperList"];
                            [query whereKey:@"caseID" equalTo:cases];
                            [query whereKey:@"isResponse" equalTo:[NSNumber numberWithBool:TRUE]];
                            [query whereKey:@"isYou" notEqualTo:[NSNumber numberWithBool:TRUE]];
                            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                NSMutableSet *channelSets = [NSMutableSet setWithCapacity:objects.count];
                                if (objects.count > 0) {
                                    for (PFObject *helperList in objects) {
                                        if ([helperList objectForKey:@"userID"] && [[[helperList objectForKey:@"userID"] objectId] length] != 0 && ![[[helperList objectForKey:@"userID"] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                                            NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", [[helperList objectForKey:@"userID"] objectId]];
                                            [channelSets addObject:privateChannelName];
                                        }
                                        PFObject *activity = [PFObject objectWithClassName:kPAPActivityClassKey];
                                        [activity setObject:cases forKey:kPAPActivityDateKey];
                                        [activity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
                                        [activity setObject:[helperList objectForKey:@"userID"] forKey:kPAPActivityToUserKey];
                                        [activity setObject:kPAPActivityTypeOwnerDidntCheckHelper forKey:kPAPActivityTypeKey];
                                        
                                        PFACL *ACL = [PFACL ACL];
                                        [ACL setPublicReadAccess:YES];
                                        [ACL setPublicWriteAccess:YES];
                                        activity.ACL = ACL;
                                        
                                        [activity saveEventually:^(BOOL succeeded, NSError *error) {
                                            
                                        }];
                                    }
                                    
                                    NSString *alert = [NSString stringWithFormat:@"業主%@之任務已指派其他人選", [CMUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey]]];
                                    
                                    // make sure to leave enough space for payload overhead
                                    if (alert.length > 100) {
                                        alert = [alert substringToIndex:99];
                                        alert = [alert stringByAppendingString:@"…"];
                                    }
                                    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                                          alert, kAPNSAlertKey,                                                 //"推播顯示訊息內容", @"alert"
                                                          kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey, //"a" , "p"
                                                          kPAPActivityTypeOwnerDidntCheckHelper, kPAPPushPayloadActivityTypeKey,//"fail" , "t"
                                                          [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,  //"業主用戶ID” , "fu"
                                                          cases.objectId, kPAPPushPayloadPostDateObjectIdKey,                     //"CaseID" , "ca"
                                                          @"Increment",kAPNSBadgeKey,
                                                          @"action", @"tw.taiwan8.CUSTOM_BROADCAST",
                                                          nil];
                                    PFPush *push = [[PFPush alloc] init];
                                    [push setChannels:[channelSets allObjects]];
                                    [push setData:data];
                                    [push sendPushInBackground];
                                }
                            }];
                        }
                    }];
                }else{
                    //但如果是小於的話，不處理
                    completionBlock(FALSE,nil);
                }
            }else{
                //業主還沒有選擇任何人
                PFQuery *query = [PFQuery queryWithClassName:@"CasesHelperList"];
                [query whereKey:@"caseID" equalTo:cases];
                [query whereKey:@"userID" equalTo:user];
                [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                    [object setObject:[NSNumber numberWithBool:TRUE] forKey:@"isYou"];
                    
                    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
                    [followACL setPublicReadAccess:YES];
                    [followACL setPublicWriteAccess:YES];
                    object.ACL = followACL;
                    
                    [object saveEventually:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            completionBlock(succeeded,nil);
                        }
                    }];
                    
                    
                    //如果選擇你剛好等於需求人數，就要通知其他幫手落選了。
                    if (peopleamount == [objects count]+1) {
                        //先把剩下的其他人撈出來
                        PFQuery *query = [PFQuery queryWithClassName:@"CasesHelperList"];
                        [query whereKey:@"caseID" equalTo:cases];
                        [query whereKey:@"isResponse" equalTo:[NSNumber numberWithBool:TRUE]];
                        [query whereKey:@"isYou" notEqualTo:[NSNumber numberWithBool:TRUE]];
                        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                            NSMutableSet *channelSets = [NSMutableSet setWithCapacity:objects.count];
                            if (objects.count > 0) {
                                for (PFObject *helperList in objects) {
                                    if ([helperList objectForKey:@"userID"] && [[[helperList objectForKey:@"userID"] objectId] length] != 0 && ![[[helperList objectForKey:@"userID"] objectId] isEqualToString:[[PFUser currentUser] objectId]] && ![[[helperList objectForKey:@"userID"] objectId] isEqualToString:user.objectId]) {
                                        NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", [[helperList objectForKey:@"userID"] objectId]];
                                        [channelSets addObject:privateChannelName];
                                        
                                        PFObject *activity = [PFObject objectWithClassName:kPAPActivityClassKey];
                                        [activity setObject:cases forKey:kPAPActivityDateKey];
                                        [activity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
                                        [activity setObject:[helperList objectForKey:@"userID"] forKey:kPAPActivityToUserKey];
                                        [activity setObject:kPAPActivityTypeOwnerDidntCheckHelper forKey:kPAPActivityTypeKey];
                                        
                                        PFACL *ACL = [PFACL ACL];
                                        [ACL setPublicReadAccess:YES];
                                        [ACL setPublicWriteAccess:YES];
                                        activity.ACL = ACL;
                                        
                                        [activity saveEventually:^(BOOL succeeded, NSError *error) {
                                            
                                        }];
                                       
                                        }
                                }
                                
                                NSString *alert = [NSString stringWithFormat:@"業主%@之任務已指派其他人選", [CMUtility firstNameForDisplayName:[[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey]]];
                                
                                // make sure to leave enough space for payload overhead
                                if (alert.length > 100) {
                                    alert = [alert substringToIndex:99];
                                    alert = [alert stringByAppendingString:@"…"];
                                }
                                NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                                      alert, kAPNSAlertKey,                                                 //"推播顯示訊息內容", @"alert"
                                                      kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey, //"a" , "p"
                                                      kPAPActivityTypeOwnerDidntCheckHelper, kPAPPushPayloadActivityTypeKey,//"fail" , "t"
                                                      [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,  //"業主用戶ID” , "fu"
                                                      cases.objectId, kPAPPushPayloadPostDateObjectIdKey,                     //"CaseID" , "ca"
                                                      @"Increment",kAPNSBadgeKey,
                                                      @"action", @"tw.taiwan8.CUSTOM_BROADCAST",
                                                      nil];
                                PFPush *push = [[PFPush alloc] init];
                                [push setChannels:[channelSets allObjects]];
                                [push setData:data];
                                [push sendPushInBackground];
                            }
                        }];
                    }
                }];
            }
        } else {
            //這裏是外來者的選擇。
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

+ (void)unaddToHelperListEventually:(PFUser *)user fromCase:(PFObject *)cases{
    PFQuery *query = [PFQuery queryWithClassName:@"CasesHelperList"];
    
    [query whereKey:@"caseID" equalTo:cases];
    [query whereKey:@"userID" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            // Do something with the found objects
            for (PFObject *object in objects) {
                object[@"isYou"] = [NSNumber numberWithBool:FALSE];
                
                PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
                [followACL setPublicReadAccess:YES];
                [followACL setPublicWriteAccess:YES];
                object.ACL = followACL;
                
                [object saveInBackground];
                
                
                NSMutableArray *casesarray = [[NSMutableArray alloc] init];
                NSArray *array= casesConstants[@"helperList"];
                for(NSString *arr in array){
                    if([user.objectId isEqualToString:arr]){
                        
                    }else{
                        if (arr.length > 0) {
                            [casesarray addObject:arr];
                        }
                    }
                }
                
                NSArray *savearray = [NSArray arrayWithArray:casesarray];
                casesConstants[@"helperList"]=savearray;
                [[CMCache sharedCache] setHelperlists:savearray ToCase:casesConstants.objectId];
                [casesConstants saveEventually:^(BOOL succeeded, NSError *error) {
                    
                }];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
}





#pragma mark Push
+ (void)sendFollowingPushNotification:(PFUser *)user {
    NSString *privateChannelName = [NSString stringWithFormat:@"user_%@", user.objectId];
    if (privateChannelName && privateChannelName.length != 0) {
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"你的Facebook好友%@也安裝了台灣幫", [self firstNameForDisplayName:[[PFUser currentUser] objectForKey:kPAPUserDisplayNameKey]]], kAPNSAlertKey,
                              kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
                              kPAPPushPayloadActivityIAmInstallKey, kPAPPushPayloadActivityTypeKey,
                              [[PFUser currentUser] objectId], kPAPPushPayloadFromUserObjectIdKey,
                              @"Increment",kAPNSBadgeKey,
                              @"action", @"tw.com.taiwan8.CUSTOM_BROADCAST",
                              nil];
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:privateChannelName];
        [push setData:data];
        [push sendPushInBackground];
    }
}


+ (BOOL)userHasValidFacebookData:(PFUser *)user {
    NSString *facebookId = [user objectForKey:kPAPUserFacebookIDKey];
    return (facebookId && facebookId.length > 0);
}

+ (BOOL)userHasProfilePictures:(PFUser *)user {
    PFFile *profilePictureMedium = [user objectForKey:kPAPUserProfilePicMediumKey];
    PFFile *profilePictureSmall = [user objectForKey:kPAPUserProfilePicSmallKey];
    
    return (profilePictureMedium && profilePictureSmall);
}



#pragma mark Display Name

+ (NSString *)firstNameForDisplayName:(NSString *)displayName {
    if (!displayName || displayName.length == 0) {
        return @"某人";
    }
    
    NSArray *displayNameComponents = [displayName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *firstName = [displayNameComponents objectAtIndex:0];
    if (firstName.length > 100) {
        // truncate to 100 so that it fits in a Push payload
        firstName = [firstName substringToIndex:100];
    }
    return firstName;
}


//讀取大類別物件
+ (PFQuery *)getCategory{
    PFQuery *category = [PFQuery queryWithClassName:@"Category"];
    [category orderByAscending:@"categoryid"];
    return category;
}

//讀取小類別物件
+ (PFQuery *)getCategoryDetail:(PFObject *)category{
    PFQuery *categoryDetail = [PFQuery queryWithClassName:@"CategoryDetail"];
    [categoryDetail whereKey:@"CategoryID" equalTo:category];
    [categoryDetail orderByAscending:@"order"];
    return categoryDetail;
}


#pragma mark 判斷用戶是業主還是幫手模式
+(void)isHelperblock:(void (^)(BOOL succeeded, PFObject *user))completionBlock{
    if (![PFUser currentUser]) {
        
    }else{
        PFQuery *current =  [PFUser query];
        [current getObjectInBackgroundWithId:[[PFUser currentUser] objectId] block:^(PFObject *object, NSError *error) {
            if(error == nil )
            {
                completionBlock(YES, object);
            }
            else
            {
                completionBlock(NO, nil);
            }
        }];
    }
}

+(BOOL)isHelper{
    BOOL isHelper;
    if ([[[PFUser currentUser] objectForKey:@"type"] isEqualToString:@"helper"]) {
        //幫手模式，沒有Tabbar
        isHelper = YES;
    }else{
        //業主模式，有Tabbar
        isHelper = NO;
    }
    return isHelper;
}


#pragma mark 幫手收到業主發送訊息__前景執行中
+ (void)HelperGotPushInForeGround:(NSDictionary *)launchOptions fromCustomId:(NSString *)CustomId AndCaseId:(NSString *)caseId inRootView:(UIViewController *)rootViewController{
    
    /*
     NSString *const kPAPPushPayloadActivitySendPlzKey           = @"post";         //業主發案
     NSString *const kPAPPushPayloadActivityTakeUpKey            = @"take";         //幫手接案
     NSString *const kPAPPushPayloadActivityOwnerCheckHelpKey    = @"check";        //業主確認幫手
     NSString *const kPAPPushPayloadActivityOwnerDidntCheckHelpKey    = @"fail";        //業主確認幫手
     NSString *const kPAPPushPayloadActivityIAmInstallKey        = @"joined";       //當前用戶通知好友
     NSString *const kPAPPushPayloadActivityBlockKey             = @"span";         //封鎖
     NSString *const kPAPPushPayloadActivityLikeKey              = @"like";         //喜歡
     NSString *const kPAPPushPayloadActivityRatingKey            = @"rating";       //評價
     NSString *const kPAPPushPayloadActivityCommentKey           = @"comment";      //留言
     NSString *const kPAPPushPayloadActivityFollowKey            = @"follow";       //跟隨
     NSString *const kPAPPushPayloadActivitySMSKey               = @"aotp";         //AOTP推播
     NSString *const kPAPPushPayloadActivitySMSResultKey         = @"result";       // = 2 成功認證
     NSString *const kPAPPushPayloadActivityOwnerDidntCheckHelpKey       = @"fail";         //確定選擇其他幫手通知
     */
    
    
    if ([PFUser currentUser]) {
        
    }
    
    
    PFQuery *findUser = [PFUser query];
    NSString *type = [launchOptions objectForKey:kPAPPushPayloadActivityTypeKey];
    
    [findUser getObjectInBackgroundWithId:CustomId block:^(PFObject *object, NSError *error) {
        
        PFUser *customerUser = (PFUser *)object;
        
        if (!caseId) {
            
        }else{
            PFQuery *findCase = [PFQuery queryWithClassName:@"Cases"];
            [findCase includeKey:@"categoryID"];
            [findCase getObjectInBackgroundWithId:caseId block:^(PFObject *object, NSError *error) {
                PFObject *Case = object;
                PFQuery *findCategory = [PFQuery queryWithClassName:@"Category"];
                [findCategory getObjectInBackgroundWithId:[[Case objectForKey:@"categoryID"] objectId] block:^(PFObject *object, NSError *error) {
                    if ([type isEqualToString:kPAPPushPayloadActivitySendPlzKey]) {
                        ////業主請求幫手，幫手端不管在哪個頁面直接顯示Alert，提醒幫手要去搶單。
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@正在呼叫能幫忙「%@」的幫手", [customerUser objectForKey:kPAPUserDisplayNameKey], [object objectForKey:@"name"]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPPushPayloadActivityOwnerCheckHelpKey]){
                        //業主確認幫手的推播要顯示Alert，「業主誰答應你接下這個任務。」
                        if ([[Case objectForKey:@"isAuto"] boolValue]) {
                            //系統指派
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"任務狀態訊息" message:[NSString stringWithFormat:@"系統已成功指派%@承接您的任務", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                            [alertView show];
                        }else{
                            //業主自選
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"任務狀態訊息" message:[NSString stringWithFormat:@"業主%@決定讓您執行任務", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                            [alertView show];
                        }
                    }else if ([type isEqualToString:kPAPPushPayloadActivityOwnerDidntCheckHelpKey]){
                        //業主決定其他人選
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"任務狀態訊息" message:[NSString stringWithFormat:@"業主%@之任務已指派給其他人", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPPushPayloadActivityIAmInstallKey]){
                        //業主確認幫手的推播要顯示Alert，「朋友誰也加入了台灣幫。」
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@也加入了台灣幫", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPPushPayloadActivityLikeKey]){
                        //業主確認幫手的推播要顯示Alert，「某某誰也喜歡您的任務。」
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@也喜歡您的任務", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPPushPayloadActivityRatingKey]){
                        //業主確認幫手的推播要顯示Alert，「某某誰評價您。」
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@評價您", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPPushPayloadActivityCommentKey]){
                        //業主確認幫手的推播要顯示Alert，「某某誰在任務中留言。」
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@在任務中留言", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPPushPayloadActivityFollowKey]){
                        //業主確認幫手的推播要顯示Alert，「某某誰跟隨您。」
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@加您為好友", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPActivityTypeReject]){
                        //業主確認幫手的推播要顯示Alert，「取消」
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@取消任務", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }else if ([type isEqualToString:kPAPActivityTypeSpan]){
                        //業主確認幫手的推播要顯示Alert，「檢舉」
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@檢舉您的任務", [customerUser objectForKey:kPAPUserDisplayNameKey]] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
                        [alertView show];
                    }
                }];
            }];
        }
    }];
}

#pragma mark 背景情況下，幫手收到業主發送訊息__背景執行（需要再細分幫手模式、業主模式）
+ (void)HelperGotPushInBackGround:(NSDictionary *)launchOptions inRootView:(UIViewController *)rootViewController{
    
    /*
     rootViewController = <CustomTabBarViewController: 0x156d22910>,
     launchOptions = {
     aps =     {
     alert = "\U9673\U6021\U5982\U6b63\U5728\U547c\U53eb\U80fd\U5e6b\U5fd9\U300c\U4ee3\U8cb7\U300d\U7684\U5e6b\U624b";
     badge = 8;
     };
     ca = U5g55kePy4;
     fu = TUOnDbXxtx;
     p = a;
     t = post;
     "tw.com.taiwan8.CUSTOM_BROADCAST" = action;
     }
     */
    
    /*
     NSString *const kPAPPushPayloadActivitySendPlzKey           = @"post";     //業主發案
     NSString *const kPAPPushPayloadActivityTakeUpKey            = @"take";     //幫手接案
     NSString *const kPAPPushPayloadActivityOwnerCheckHelpKey    = @"check";     //業主確認幫手
     NSString *const kPAPPushPayloadActivityIAmInstallKey        = @"joined";     //當前用戶通知好友
     NSString *const kPAPPushPayloadActivityBlockKey             = @"span";     //封鎖
     NSString *const kPAPPushPayloadActivityLikeKey              = @"like";     //喜歡
     NSString *const kPAPPushPayloadActivityRatingKey            = @"rating";     //評價
     NSString *const kPAPPushPayloadActivityCommentKey           = @"comment";     //留言
     NSString *const kPAPPushPayloadActivityFollowKey            = @"follow";     //跟隨
     NSString *const kPAPPushPayloadActivitySMSKey               = @"aotp";       //AOTP推播
     NSString *const kPAPPushPayloadActivitySMSResultKey         = @"result";     // = 2 成功認證
     */
    
    if ([[launchOptions objectForKey:@"t"] isEqualToString:kPAPPushPayloadActivitySendPlzKey]) {
        
        //收到發案推播
        
    }else if ([[launchOptions objectForKey:@"t"] isEqualToString:kPAPPushPayloadActivityTakeUpKey]){
        //業主收到幫手接案，引導至管理任務待確認
    
    }else if ([[launchOptions objectForKey:@"t"] isEqualToString:kPAPPushPayloadActivityOwnerCheckHelpKey]){
        //幫手收到業主確認，引導至管理任務正在執行中
        
    }else if ([[launchOptions objectForKey:@"t"] isEqualToString:kPAPPushPayloadActivityCommentKey]){
        //業主或幫手收到留言通知，引導至管理任務正在執行中任務Detail留言版
        
    }else if ([[launchOptions objectForKey:@"t"] isEqualToString:kPAPPushPayloadActivityRatingKey]){
        //收到幫手評價，跳出評價畫面。
        //1.先query Activity的table, 找出caseID 符合收到推播的id, fromUser符合 fu的id，toUser 符合當前用戶的id。
        //2.如果有找到不用跳評價畫面。
        //3.如果找不到，強制跳出評價畫面。
        
    }
}
#pragma mark 業主收到幫手發送訊息__前景執行中
+ (void)CustomerGotPushInForeGround:(NSDictionary *)launchOptions fromHelperId:(NSString *)helperId AndCaseId:(NSString *)caseId inRootView:(UIViewController *)rootViewController{
//    PFQuery *findUser = [PFUser query];
    //如果在前景畫面，而且還在倒數中，直接就導航至Details。
    //Tabbar 要切換到我的任務去。
    /*
     在倒數中的情況
     [(UINavigationController *)rootViewController.presentedViewController viewControllers]
      = (
     "<ChoseCategoryViewController: 0x130488c20>",
     "<TaskContentTableViewController: 0x130489dd0>",
     "<FromToViewController: 0x131c09770>",
     "<TimeAndMessengerTableViewController: 0x131f16c90>",
     "<agreePageViewController: 0x131f37290>",
     "<checkMoneyViewController: 0x131f37da0>",
     "<NeedHandsViewController: 0x131f5c970>"
     )
     
     沒有倒數的情況
     [(UINavigationController *)rootViewController.presentedViewController viewControllers] = null
     */
    
//    if ([[(UINavigationController *)rootViewController.presentedViewController viewControllers] count] > 0) {
//        [(UINavigationController *)rootViewController.presentedViewController dismissViewControllerAnimated:YES completion:^{
//            //還在倒數中...，切換到我的任務
//            [(CustomTabBarViewController *)rootViewController setSelectedIndex:2];
//            UINavigationController *navi = [[(CustomTabBarViewController *)rootViewController viewControllers] objectAtIndex:2];
//            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
//            TasksDetailTableViewController *taskDeatil = (TasksDetailTableViewController *)[storybord instantiateViewControllerWithIdentifier:@"tasktable"];;
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[launchOptions objectForKey:@"ca"]];
//            [[CMCache sharedCache] setSelectObject:data];
//            [navi pushViewController:taskDeatil animated:YES];
//        }];
    
//    }else{
        //已經倒數完了...
//        [findUser getObjectInBackgroundWithId:helperId block:^(PFObject *object, NSError *error) {
//            PFUser *driverUser = (PFUser *)object;
//            PFQuery *findCase = [PFQuery queryWithClassName:@"Cases"];
//            [findCase getObjectInBackgroundWithId:caseId block:^(PFObject *object, NSError *error) {
//                PFObject *Case = object;
//                PFQuery *findCategory = [PFQuery queryWithClassName:@"Category"];
//                [findCategory getObjectInBackgroundWithId:[[Case objectForKey:@"categoryID"] objectId] block:^(PFObject *object, NSError *error) {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@搶到您「%@」的任務", [driverUser objectForKey:kPAPUserDisplayNameKey], [object objectForKey:@"name"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alertView show];
//                }];
//            }];
//        }];
//    }
}
#pragma mark 業主收到幫手發送訊息__背景執行(再細分幫手模式、業主模式，有無TabBar)
+ (void)CustomerGotPushInBackGround:(NSDictionary *)launchOptions inRootView:(UIViewController *)rootViewController{
    //先判斷是業主模式或幫手模式
    //這裡要判斷是幫手模式還是業主模式。
//    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"NavigationType"] == ADVNavigationTypeMenu) {
        //幫手模式，沒有Tabbar
//        PaperFoldNavigationController *naviga = (PaperFoldNavigationController *)rootViewController;
//        UINavigationController *nav = (UINavigationController *)naviga.rootViewController;
//        if (![[[nav.viewControllers objectAtIndex:0] class] isSubclassOfClass:[MapViewController class]]) {
//            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
//            UINavigationController *navMag1 = [storybord instantiateViewControllerWithIdentifier:@"PropertiesNav"];
//            [naviga setRootViewController:navMag1];
//            TasksDetailTableViewController *taskDeatil = (TasksDetailTableViewController *)[storybord instantiateViewControllerWithIdentifier:@"tasktable"];;
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[launchOptions objectForKey:@"ca"]];
//            [[CMCache sharedCache] setSelectObject:data];
//            [navMag1 pushViewController:taskDeatil animated:YES];
//            [taskDeatil getTakeOutAlert:[launchOptions objectForKey:@"tu"]];
//        }else{
//            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
//            TasksDetailTableViewController *taskDeatil = (TasksDetailTableViewController *)[storybord instantiateViewControllerWithIdentifier:@"tasktable"];;
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[launchOptions objectForKey:@"ca"]];
//            [[CMCache sharedCache] setSelectObject:data];
//            [nav pushViewController:taskDeatil animated:YES];
//            [taskDeatil getTakeOutAlert:[launchOptions objectForKey:@"tu"]];
//        }
//    }else{
//        //業主模式，有Tabbar
//        if ([(CustomTabBarViewController *)rootViewController selectedIndex] != 0) {
//            [(CustomTabBarViewController *)rootViewController setSelectedIndex:0];
//            UINavigationController *navi = [[(CustomTabBarViewController *)rootViewController viewControllers] objectAtIndex:0];
//            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
//            TasksDetailTableViewController *taskDeatil = (TasksDetailTableViewController *)[storybord instantiateViewControllerWithIdentifier:@"tasktable"];;
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[launchOptions objectForKey:@"ca"]];
//            [[CMCache sharedCache] setSelectObject:data];
//            [navi pushViewController:taskDeatil animated:YES];
//            [taskDeatil getTakeOutAlert:[launchOptions objectForKey:@"tu"]];
//        }else{
//            UINavigationController *navi = [[(CustomTabBarViewController *)rootViewController viewControllers] objectAtIndex:0];
//            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
//            TasksDetailTableViewController *taskDeatil = (TasksDetailTableViewController *)[storybord instantiateViewControllerWithIdentifier:@"tasktable"];;
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[launchOptions objectForKey:@"ca"]];
//            [[CMCache sharedCache] setSelectObject:data];
//            [navi pushViewController:taskDeatil animated:YES];
//            [taskDeatil getTakeOutAlert:[launchOptions objectForKey:@"tu"]];
//        }
//    }
}


+ (void)drawSideDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {
    // Push the context
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y, rect.size.width + 20.0f, rect.size.height));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake( 0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x,
                                          rect.origin.y - 5.0f,
                                          rect.size.width,
                                          rect.size.height + 10.0f));
    // Save context
    CGContextRestoreGState(context);
}


#pragma mark Shadow Rendering

+ (void)drawSideAndBottomDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context {
    // Push the context
    CGContextSaveGState(context);
    
    // Set the clipping path to remove the rect drawn by drawing the shadow
    CGRect boundingRect = CGContextGetClipBoundingBox(context);
    CGContextAddRect(context, boundingRect);
    CGContextAddRect(context, rect);
    CGContextEOClip(context);
    // Also clip the top and bottom
    CGContextClipToRect(context, CGRectMake(rect.origin.x - 10.0f, rect.origin.y, rect.size.width + 20.0f, rect.size.height + 10.0f));
    
    // Draw shadow
    [[UIColor blackColor] setFill];
    CGContextSetShadow(context, CGSizeMake(0.0f, 0.0f), 7.0f);
    CGContextFillRect(context, CGRectMake(rect.origin.x,
                                          rect.origin.y - 5.0f,
                                          rect.size.width,
                                          rect.size.height + 5.0f));
    // Save context
    CGContextRestoreGState(context);
}



//沒有人接案
+ (void)nonOneGetThisJob:(UIButton *)button InTheView:(UIView *)theView{
    button.userInteractionEnabled = YES;
    [button setTitle: @"  接案  " forState: UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    [MBProgressHUD hideAllHUDsForView:theView animated:YES];
}

//看別人的任務，系統推薦
/*
+ (void)SystemAutoFromQuery:(PFQuery *)helperList withObjects:(NSArray *)objects AndCaseObject:(PFObject *)caseObject InTheView:(UIView *)theView ChangeButtonName:(UIButton *)button{
    if (objects.count < [[caseObject objectForKey:kTaskTotalPeopleNumber] intValue]) {
        [helperList getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                //包括自己
                if ([[[object objectForKey:@"userID"] objectId] isEqual:[[PFUser currentUser] objectId]]) {
                    button.userInteractionEnabled = NO;
                    [button setTitle: @"  錄取  " forState: UIControlStateNormal];
                    button.backgroundColor = [UIColor grayColor];
                }else{
                    if ([caseObject objectForKey:kTaskNeedConvener]) {
                        button.userInteractionEnabled = NO;
                        [button setTitle: @" 不錄取  " forState: UIControlStateNormal];
                        button.backgroundColor = [UIColor grayColor];
                    }else{
                        button.userInteractionEnabled = YES;
                        [button setTitle: @"  接案  " forState: UIControlStateNormal];
                        button.backgroundColor = [UIColor greenColor];
                    }
                }
                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
            }else{
                //如果是需要召集人的case，就必須直接結束。
                //不包括自己，仍然可以接案。
                button.userInteractionEnabled = YES;
                [button setTitle: @"  接案  " forState: UIControlStateNormal];
                button.backgroundColor = [UIColor greenColor];
                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
            }
        }];
    }else{
        //大於等於需求人數
        [helperList whereKey:@"userID" equalTo:[PFUser currentUser]];
        [helperList getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                //包括自己
                button.userInteractionEnabled = NO;
                [button setTitle: @"  錄取  " forState: UIControlStateNormal];
                button.backgroundColor = [UIColor grayColor];
                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
            }else{
                //不包括自己
                //包括自己
                button.userInteractionEnabled = NO;
                [button setTitle: @"已經結束" forState: UIControlStateNormal];
                button.backgroundColor = [UIColor grayColor];
                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
            }
        }];
    }
}
*/

//業主自選，我已經接過
+ (void)havedGetThisJob:(UIButton *)button InTheView:(UIView *)theView{
    button.userInteractionEnabled = NO;
    [button setTitle: @" 已接待回應 " forState: UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [MBProgressHUD hideAllHUDsForView:theView animated:YES];
}

//看別人的任務，業主自選
/*
+ (void)CustomerChoseFromQuery:(PFQuery *)helperList withObjects:(NSArray *)objects AndCaseObject:(PFObject *)caseObject InTheView:(UIView *)theView ChangeButtonName:(UIButton *)button{
    
    if (objects.count >= [[caseObject objectForKey:kTaskTotalPeopleNumber] intValue]) {
        [helperList whereKey:@"userID" equalTo:[PFUser currentUser]];
        [helperList getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                //包括自己
                button.userInteractionEnabled = NO;
                [button setTitle: @"  錄取  " forState: UIControlStateNormal];
                button.backgroundColor = [UIColor grayColor];
                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
            }else{
                //不包括自己，查isResponse 是否已經 YES
                PFQuery *helperIsResponse = [PFQuery queryWithClassName:@"CasesHelperList"];
                [helperIsResponse whereKey:@"caseID" equalTo:caseObject];
                [helperIsResponse whereKey:@"userID" equalTo:[PFUser currentUser]];
                [helperIsResponse whereKey:kTaskIsResponse equalTo:@YES];
                [helperIsResponse getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                    if (!error) {
                        //已經接案
                        button.userInteractionEnabled = NO;
                        [button setTitle: @"  不錄取  " forState: UIControlStateNormal];
                        button.backgroundColor = [UIColor grayColor];
                        [MBProgressHUD hideAllHUDsForView:theView animated:YES];
                    }else{
                        //還沒接過
                        button.userInteractionEnabled = NO;
                        [button setTitle: @" 已經結束 " forState: UIControlStateNormal];
                        button.backgroundColor = [UIColor grayColor];
                        [MBProgressHUD hideAllHUDsForView:theView animated:YES];
                    }
                }];
                
            }
        }];
    }else if (objects.count < [[caseObject objectForKey:kTaskTotalPeopleNumber] intValue]){
        [helperList whereKey:@"userID" equalTo:[PFUser currentUser]];
        [helperList getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                button.userInteractionEnabled = NO;
                [button setTitle: @"  錄取  " forState: UIControlStateNormal];
                button.backgroundColor = [UIColor grayColor];
                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
            }else{
                //不包括自己，查isResponse 是否已經 YES
                PFQuery *helperIsResponse = [PFQuery queryWithClassName:@"CasesHelperList"];
                [helperIsResponse whereKey:@"caseID" equalTo:caseObject];
                [helperIsResponse whereKey:@"userID" equalTo:[PFUser currentUser]];
                [helperIsResponse whereKey:kTaskIsResponse equalTo:@YES];
                [helperIsResponse getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                    if (!error) {
                        //我已經接案，如果其中isYou = false 表示落選啦
                        if ([object objectForKey:kTaskIsYou]) {
                            if ([[object objectForKey:kTaskIsYou] boolValue]) {
                                button.userInteractionEnabled = NO;
                                [button setTitle: @" 錄取 " forState: UIControlStateNormal];
                                button.backgroundColor = [UIColor grayColor];
                                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
                            }else{
                                button.userInteractionEnabled = NO;
                                [button setTitle: @" 不錄取 " forState: UIControlStateNormal];
                                button.backgroundColor = [UIColor grayColor];
                                [MBProgressHUD hideAllHUDsForView:theView animated:YES];
                            }
                        }else{
                            [self havedGetThisJob:button InTheView:theView];
                        }
                    }else{
                        //我還沒接過該案
                        [self nonOneGetThisJob:button InTheView:theView];
                    }
                }];
            }
        }];
    }
}
*/

//經緯度轉換成縣市單位
+ (void)getLocationName:(PFGeoPoint *)point block:(void (^)(BOOL succeeded, NSString *nameLabel))completionBlock{
    /*
     分析google地理位置
     */
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%f,%f&sensor=true",point.latitude, point.longitude];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *jsonStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *resultDict = [jsonStr objectFromJSONString];
    
   
    
    if ([[resultDict objectForKey:@"status"] isEqualToString:@"OK"]) {
        NSDictionary *dict = [[resultDict objectForKey:@"results"] objectAtIndex:0];
        NSMutableArray *dictToComponents = [dict objectForKey:@"address_components"];
        if (dictToComponents.count < 2) {
            completionBlock(YES, @"什麼鬼地方。");
        } else if (dictToComponents.count < 4) {
            
            NSDictionary *formattedAddr = [dictToComponents  objectAtIndex:1];
            NSString *Addr = [formattedAddr objectForKey:@"short_name"];
            NSString *Addr3 = [[NSString alloc] initWithFormat:@"%@", Addr];
            completionBlock(YES, Addr3);
        }else if (dictToComponents.count < 5) {
            NSDictionary *formattedAddr = [dictToComponents  objectAtIndex:1];
            NSString *Addr = [formattedAddr objectForKey:@"short_name"];
            NSString *Addr3 = [[NSString alloc] initWithFormat:@"%@", Addr];
            completionBlock(YES, Addr3);
        }else if (dictToComponents.count < 6) {
            
            NSDictionary *formattedAddr = [dictToComponents  objectAtIndex:2];
            NSString *Addr = [formattedAddr objectForKey:@"short_name"];
            NSString *Addr3 = [[NSString alloc] initWithFormat:@"%@", Addr];
            completionBlock(YES, Addr3);
        } else if (dictToComponents.count < 7) {
            NSDictionary *formattedAddr = [dictToComponents objectAtIndex:3];
            NSString *Addr = [formattedAddr objectForKey:@"short_name"];
            NSString *Addr3 = [[NSString alloc] initWithFormat:@"%@",Addr];
            completionBlock(YES, Addr3);
        } else if (dictToComponents.count < 8) {
            NSDictionary *formattedAddr = [dictToComponents objectAtIndex:4];
            NSString *Addr = [formattedAddr objectForKey:@"short_name"];
            NSString *Addr3 = [[NSString alloc] initWithFormat:@"%@",Addr];
            completionBlock(YES, Addr3);
        }else {
            NSDictionary *formattedAddr = [dictToComponents objectAtIndex:4];
            NSString *Addr = [formattedAddr objectForKey:@"short_name"];
            NSString *Addr3 = [[NSString alloc] initWithFormat:@"%@",Addr];
            completionBlock(YES, Addr3);
        }
    }else{
        completionBlock(NO, nil);
    }
}

//顏色變成UIImage
+ (UIImage *) imageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//刪除用戶照片
+ (void)deleteUserPhoto:(PFObject *)photoObjct{
    [photoObjct deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"刪除照片");
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showDetail"]){
        
    }else if ([[segue identifier] isEqualToString:@"closeCase"]){
        
    }else if ([[segue identifier] isEqualToString:@"comment"]){
        
    }
}


+(NSString *) CStringToNSString:(char *) cString ReplaceCRLF:(BOOL) replaceCRLF
{
    NSString *myNSString = [NSString stringWithUTF8String:cString];
    if(replaceCRLF){
        myNSString = [myNSString stringByReplacingOccurrencesOfString:@"\r" withString:@"<CR>"];
        myNSString = [myNSString stringByReplacingOccurrencesOfString:@"\n" withString:@"<LF>"];
    }
    return myNSString;
}


#pragma mark - 餐廳用
//餐廳用
//正在定位的約吃飯數量
+ (void)nowDatingNumberPostAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSNumber *number))completionBlock{
    PFQuery *datingNowQuery = [PFQuery queryWithClassName:kPostDateClassesKey];
    [datingNowQuery whereKey:kDateRestaurant equalTo:restaurant];
    //還沒確定人選的約會單
    [datingNowQuery whereKey:kDateIsChosed notEqualTo:[NSNumber numberWithBool:true]];
    [datingNowQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (completionBlock) {
                completionBlock(true, [NSNumber numberWithInt:(int)objects.count]);
            }
        }else{
            if (completionBlock) {
                completionBlock(false, [NSNumber numberWithInt:0]);
            }
        }
    }];
}

//約吃飯留言訊息數量
+ (void)nowMessengerNumberAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSString *number))completionBlock{
    
}

//正在定位的約吃飯Array
+ (void)nowDatingArrayPostAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSArray *array))completionBlock{
    
}

//約吃飯留言訊息數量
+ (void)nowMessengerArrayAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSString *array))completionBlock{
    
}


@end
