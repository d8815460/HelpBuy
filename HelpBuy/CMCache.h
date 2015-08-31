//
//  CMCache.h
//  chatMessenger
//
//  Created by Ayi on 2014/3/5.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCache : NSObject

+ (id)sharedCache;

- (void)clear;

- (void)setAttributesForPhoto:(PFObject *)photo likers:(NSArray *)likers commenters:(NSArray *)commenters likedByCurrentUser:(BOOL)likedByCurrentUser;
- (NSDictionary *)attributesForPhoto:(PFObject *)photo;
- (NSNumber *)likeCountForPhoto:(PFObject *)photo;
- (NSNumber *)commentCountForPhoto:(PFObject *)photo;
- (NSArray *)likersForPhoto:(PFObject *)photo;
- (NSArray *)commentersForPhoto:(PFObject *)photo;
- (void)setPhotoIsLikedByCurrentUser:(PFObject *)photo liked:(BOOL)liked;
- (BOOL)isPhotoLikedByCurrentUser:(PFObject *)photo;
- (void)incrementLikerCountForPhoto:(PFObject *)photo;
- (void)decrementLikerCountForPhoto:(PFObject *)photo;
- (void)incrementCommentCountForPhoto:(PFObject *)photo;
- (void)decrementCommentCountForPhoto:(PFObject *)photo;
- (void)setPhotoIsReadedByCurrentUser:(PFObject *)photo readed:(BOOL)readed;
- (BOOL)isPhotoReadedByCurrentUser:(PFObject *)photo;

- (NSDictionary *)attributesForUser:(PFUser *)user;

- (NSDictionary *)attributesForObject:(PFObject *)user;

- (NSNumber *)photoCountForUser:(PFUser *)user;
- (BOOL)followStatusForUser:(PFUser *)user;
- (BOOL)addStatusForUser:(PFUser *)user;
- (BOOL)addStatusForUser:(PFUser *)user ForGroup:(PFObject *)groupObject;
- (void)setPhotoCount:(NSNumber *)count user:(PFUser *)user;
- (void)setFollowStatus:(BOOL)following user:(PFUser *)user;
- (void)setAddToGroupStatus:(BOOL)adding ToGroup:(PFObject *)group user:(PFUser *)user;

- (void)setAttributes:(NSDictionary *)attributes forUserGroup:(NSString *)userGroup;
- (NSDictionary *)attributesForUserGroup:(NSString *)userGroup;
- (void)setHelperlists:(NSArray *)friends ToCase:(NSString *)caseObjectId;
- (NSArray *)helperListsFrom:(NSString *)caseObjectId;


- (void)setFacebookFriends:(NSArray *)friends;
- (NSArray *)facebookFriends;

- (void)setPhoneNumbers:(NSArray *)numbers;
- (NSArray *)phoneNumbers;

- (void)setFacebookFriendsNumber:(NSNumber *)friendsNumber;
- (NSNumber *)facebookFriendsNumber;

- (void)setFacebookGroups:(NSArray *)groups;
- (NSArray *)facebookGroups;

- (void)setSelectObject:(NSData *)object;
- (NSData *)selectObject;

//讀取所有大類別
- (void)getBigCategoryBlock:(void (^)(BOOL succeeded, NSArray *array))completionBlock;

//讀取所有小類別
- (void)getAllCategory:(PFObject *)Category Block:(void (^)(BOOL succeeded, NSArray *array))completionBlock;


//計算我過去發過案子總數
- (void)postTasksCount:(PFUser *)currenter block:(void (^)(BOOL succeeded, int numbers))completionBlock;

//計算我過去接過案子總數
- (void)getTasksCount:(PFUser *)currenter block:(void (^)(BOOL succeeded, int numbers))completionBlock;

//計算我的幫手總數
- (void)getMyHelperCount:(PFUser *)currenter block:(void (^)(BOOL succeeded, NSArray *array))completionBlock;

//查看現在已經選擇的人數
+ (void)SelectNumberQuery:(PFQuery *)SelectHelperList block:(void (^)(BOOL succeeded, NSArray *array))completionBlock;

//留言板的總人數
+ (void)MessangerQuery:(PFObject *)caseObject block:(void (^)(BOOL succeeded, NSArray *array))completionBlock;

//統計計算用戶的評價。
+ (void)CountUserAverageRating:(PFUser *)user Block:(void (^)(BOOL succeeded, NSArray *array))completionBlock;


/**************************
 eatingDate用
 **************************/
//把讀到的結果先chace到該約會單上
- (void)setAttributesForDate:(PFObject *)date askers:(NSArray *)askers commenters:(NSArray *)commenters askedByCurrentUser:(BOOL)askedByCurrentUser;
- (NSDictionary *)attributesForDate:(PFObject *)date;
- (void)setThisPeopleIsLikedByDateOwner:(PFUser *)thisPeople thisDate:(PFObject *)date liked:(BOOL)liked;
- (NSNumber *)askCountForDate:(PFObject *)date;
- (NSNumber *)commentCountForDate:(PFObject *)date;
- (NSArray *)askersForDate:(PFObject *)date;
- (NSArray *)commentersForDate:(PFObject *)date;
- (BOOL)isDateAskedByCurrentUser:(PFObject *)date;
- (void)setDateIsAskedByCurrentUser:(PFObject *)date asked:(BOOL)asked;

//計算報名約會的總人數
+ (void)askPostDateCountQuery:(PFQuery *)Date block:(void (^)(BOOL successed, NSArray *array))completionBlock;


//餐廳資料
//- (void)setAttributesForRestaurant:(PFObject *)restaurant dates:(NSArray *)dates messagers:(NSArray *)messagers;
- (NSDictionary *)attributesForRestaurant:(PFObject *)restaurant;
- (void)setThisRestaurantIsFollowedByCurrentUser:(PFObject *)restaurant followed:(BOOL)followed;
- (NSNumber *)dateCountForRestaurant:(PFObject *)restaurant;
- (NSNumber *)messagerCountForRestaurant:(PFObject *)restaurant;
- (NSArray *)datesForRestaurant:(PFObject *)restaurant;
- (NSArray *)messagersForRestaurant:(PFObject *)restaurant;
- (BOOL)isRestaurantFollowedByCurrentUser:(PFObject *)restaurant;

@end
