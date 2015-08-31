//
//  CMCache.m
//  chatMessenger
//
//  Created by Ayi on 2014/3/5.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#import "CMCache.h"

@interface CMCache()
@property (nonatomic, strong) NSCache *cache;
- (void)setAttributes:(NSDictionary *)attributes forPhoto:(PFObject *)photo;
@end

@implementation CMCache
@synthesize cache;
#pragma mark - Initialization

+ (id)sharedCache {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

#pragma mark - PAPCache

- (void)clear {
    [self.cache removeAllObjects];
}

- (void)setAttributesForPhoto:(PFObject *)photo likers:(NSArray *)likers commenters:(NSArray *)commenters likedByCurrentUser:(BOOL)likedByCurrentUser {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithBool:likedByCurrentUser],kPAPPhotoAttributesIsAskedByCurrentUserKey,
                                [NSNumber numberWithInt:(int)[likers count]],kPAPPhotoAttributesLikeCountKey,
                                likers,kPAPPhotoAttributesLikersKey,
                                [NSNumber numberWithInt:(int)[commenters count]],kPAPPhotoAttributesCommentCountKey,
                                commenters,kPAPPhotoAttributesCommentersKey,
                                nil];
    
    [self setAttributes:attributes forPhoto:photo];
}

- (NSDictionary *)attributesForPhoto:(PFObject *)photo {
    NSString *key = [self keyForPhoto:photo];
    return [self.cache objectForKey:key];
}

- (NSDictionary *)attributesForRestaurant:(PFObject *)restaurant {
    NSString *key = [self keyForRestaurant:restaurant];
    return [self.cache objectForKey:key];
}

- (NSNumber *)likeCountForPhoto:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesLikeCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}

- (NSNumber *)commentCountForPhoto:(PFObject *)photo {
    
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesCommentCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}

- (NSArray *)likersForPhoto:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesLikersKey];
    }
    
    return [NSArray array];
}

- (NSArray *)commentersForPhoto:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesCommentersKey];
    }
    
    return [NSArray array];
}

- (void)setPhotoIsLikedByCurrentUser:(PFObject *)photo liked:(BOOL)liked {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:[NSNumber numberWithBool:liked] forKey:kPAPPhotoAttributesIsAskedByCurrentUserKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (BOOL)isPhotoLikedByCurrentUser:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [[attributes objectForKey:kPAPPhotoAttributesIsAskedByCurrentUserKey] boolValue];
    }
    
    return NO;
}

- (void)setPhotoIsReadedByCurrentUser:(PFObject *)photo readed:(BOOL)readed {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:[NSNumber numberWithBool:readed] forKey:kPAPPhotoAttributesIsReadedByCurrentUserKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (BOOL)isPhotoReadedByCurrentUser:(PFObject *)photo {
    NSDictionary *attributes = [self attributesForPhoto:photo];
    if (attributes) {
        return [[attributes objectForKey:kPAPPhotoAttributesIsReadedByCurrentUserKey] boolValue];
    }
    
    return NO;
}

- (void)incrementLikerCountForPhoto:(PFObject *)photo {
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForPhoto:photo] intValue] + 1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:likerCount forKey:kPAPPhotoAttributesLikeCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)decrementLikerCountForPhoto:(PFObject *)photo {
    NSNumber *likerCount = [NSNumber numberWithInt:[[self likeCountForPhoto:photo] intValue] - 1];
    if ([likerCount intValue] < 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:likerCount forKey:kPAPPhotoAttributesLikeCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)incrementCommentCountForPhoto:(PFObject *)photo {
    NSNumber *commentCount = [NSNumber numberWithInt:[[self commentCountForPhoto:photo] intValue] + 1];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:commentCount forKey:kPAPPhotoAttributesCommentCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)decrementCommentCountForPhoto:(PFObject *)photo {
    NSNumber *commentCount = [NSNumber numberWithInt:[[self commentCountForPhoto:photo] intValue] - 1];
    if ([commentCount intValue] < 0) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:photo]];
    [attributes setObject:commentCount forKey:kPAPPhotoAttributesCommentCountKey];
    [self setAttributes:attributes forPhoto:photo];
}

- (void)setAttributesForUser:(PFUser *)user photoCount:(NSNumber *)count followedByCurrentUser:(BOOL)following {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                count,kPAPUserAttributesPhotoCountKey,
                                [NSNumber numberWithBool:following],kPAPUserAttributesIsFollowedByCurrentUserKey,
                                nil];
    [self setAttributes:attributes forUser:user];
}

- (NSDictionary *)attributesForUser:(PFUser *)user {
    NSString *key = [self keyForUser:user];
    return [self.cache objectForKey:key];
}

- (NSDictionary *)attributesForObject:(PFObject *)user {
    NSString *key = [self keyForPhoto:user];
    return [self.cache objectForKey:key];
}

- (NSDictionary *)attributesForUserGroup:(NSString *)userGroup{
    NSString *key = userGroup;
    return [self.cache objectForKey:key];
}

- (NSNumber *)photoCountForUser:(PFUser *)user {
    NSDictionary *attributes = [self attributesForUser:user];
    if (attributes) {
        NSNumber *photoCount = [attributes objectForKey:kPAPUserAttributesPhotoCountKey];
        if (photoCount) {
            return photoCount;
        }
    }
    
    return [NSNumber numberWithInt:0];
}
- (BOOL)followStatusForUser:(PFUser *)user {
    NSDictionary *attributes = [self attributesForUser:user];
    if (attributes) {
        NSNumber *followStatus = [attributes objectForKey:kPAPUserAttributesIsFollowedByCurrentUserKey];
        if (followStatus) {
            return [followStatus boolValue];
        }
    }
    return NO;
}
- (BOOL)addStatusForUser:(PFUser *)user {
    NSDictionary *attributes = [self attributesForUser:user];
    if (attributes) {
        NSNumber *followStatus = [attributes objectForKey:kPAPUserAttributesIsAddedByCurrentUserKey];
        if (followStatus) {
            return [followStatus boolValue];
        }
    }
    return NO;
}
- (BOOL)addStatusForUser:(PFUser *)user ForGroup:(PFObject *)groupObject{
    NSDictionary *attributes = [self attributesForUserGroup:[NSString stringWithFormat:@"%@%@", user.objectId, groupObject.objectId]];
    if (attributes) {
        NSNumber *followStatus = [attributes objectForKey:[NSString stringWithFormat:@"%@%@", user.objectId, groupObject.objectId]];
        if (followStatus) {
            return [followStatus boolValue];
        }
    }
    return NO;
}

- (void)setPhotoCount:(NSNumber *)count user:(PFUser *)user {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForUser:user]];
    [attributes setObject:count forKey:kPAPUserAttributesPhotoCountKey];
    [self setAttributes:attributes forUser:user];
}

- (void)setFollowStatus:(BOOL)following user:(PFUser *)user {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForUser:user]];
    [attributes setObject:[NSNumber numberWithBool:following] forKey:kPAPUserAttributesIsFollowedByCurrentUserKey];
    [self setAttributes:attributes forUser:user];
}

- (void)setAddToGroupStatus:(BOOL)adding ToGroup:(PFObject *)group user:(PFUser *)user{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForUserGroup:[NSString stringWithFormat:@"%@%@", user.objectId, group.objectId]]];
    [attributes setObject:group forKey:@"isAddedToGroup2"];
    [attributes setObject:[NSNumber numberWithBool:adding] forKey:[NSString stringWithFormat:@"%@%@", user.objectId, group.objectId]];
    [self setAttributes:attributes forUserGroup:[NSString stringWithFormat:@"%@%@", user.objectId, group.objectId]];
}

- (void)setFacebookFriends:(NSArray *)friends {
    NSString *key = kPAPUserDefaultsCacheFacebookFriendsKey;
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:friends];
    NSArray *allFriends = [mutableArray copy];
    [self.cache setObject:allFriends forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:allFriends forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    PFQuery *querySystemUser = [PFQuery queryWithClassName:@"Admin"];
//    [querySystemUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (friends.count > 0) {
//            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:friends];
//            NSArray *allFriends = [mutableArray copy];
//            [self.cache setObject:allFriends forKey:key];
//            [[NSUserDefaults standardUserDefaults] setObject:allFriends forKey:key];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }else{
//            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:nil];
//            if (!error) {
//                for (PFObject *facebookIdObject in objects) {
//                    [mutableArray addObject:[facebookIdObject objectForKey:@"facebookId"]];
//                }
//            }
//            NSArray *allFriends = [mutableArray copy];
//            [self.cache setObject:allFriends forKey:key];
//            [[NSUserDefaults standardUserDefaults] setObject:allFriends forKey:key];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//    }];
}

- (NSArray *)facebookFriends {
    NSString *key = kPAPUserDefaultsCacheFacebookFriendsKey;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSArray *friends = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (friends) {
        [self.cache setObject:friends forKey:key];
    }
    
    return friends;
}

- (void)setPhoneNumbers:(NSArray *)numbers{
    NSString *key = kPAPUserDefaultsCachePhonesFriendsKey;
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:numbers];
    NSArray *allFriends = [mutableArray copy];
    [self.cache setObject:allFriends forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:allFriends forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)phoneNumbers{
    NSString *key = kPAPUserDefaultsCachePhonesFriendsKey;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSArray *friends = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (friends) {
        [self.cache setObject:friends forKey:key];
    }
    
    return friends;
}


- (void)setFacebookFriendsNumber:(NSNumber *)friendsNumber{
    NSString *key = kPAPUserDefaultsCacheFacebookFriendsNumberKey;
    [self.cache setObject:friendsNumber forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:friendsNumber forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSNumber *)facebookFriendsNumber{
    NSString *key = kPAPUserDefaultsCacheFacebookFriendsNumberKey;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSNumber *friends = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (friends) {
        [self.cache setObject:friends forKey:key];
    }
    
    return friends;
}

- (void)setHelperlists:(NSArray *)friends ToCase:(NSString *)caseObjectId{
    NSString *key = caseObjectId;
    [self.cache setObject:friends forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:friends forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)helperListsFrom:(NSString *)caseObjectId{
    NSString *key = caseObjectId;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSArray *helps = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (helps) {
        [self.cache setObject:helps forKey:key];
    }
    
    return helps;
}


- (void)setFacebookGroups:(NSArray *)groups{
    NSString *key = kPAPUserDefaultsCacheFacebookGroupsKey;
    [self.cache setObject:groups forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:groups forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)facebookGroups{
    NSString *key = kPAPUserDefaultsCacheFacebookGroupsKey;
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSArray *groups = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (groups) {
        [self.cache setObject:groups forKey:key];
    }
    
    return groups;
}

- (void)setSelectObject:(NSData *)object{
    NSString *key = @"selectObject";
    [self.cache setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSData *)selectObject{
    NSString *key = @"selectObject";
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    
    NSData *caseObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (caseObject) {
        [self.cache setObject:caseObject forKey:key];
    }
    
    return caseObject;
}


//讀取所有大類別
- (void)getBigCategoryBlock:(void (^)(BOOL succeeded, NSArray *array))completionBlock{
    PFQuery *category = [PFQuery queryWithClassName:@"Category"];
    [category orderByAscending:@"categoryid"];
    [category findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, objects);
        }
        else
        {
            completionBlock(NO, nil);
        }
    }];
}

//讀取所有小類別
- (void)getAllCategory:(PFObject *)Category Block:(void (^)(BOOL succeeded, NSArray *array))completionBlock{
    PFQuery *categoryDetail = [PFQuery queryWithClassName:@"CategoryDetail"];
    [categoryDetail includeKey:@"CategoryID"];
    [categoryDetail whereKey:@"CategoryID" equalTo:Category];
    [categoryDetail orderByAscending:@"order"];
    [categoryDetail findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, objects);
        }
        else
        {
            completionBlock(NO, nil);
        }
    }];
}

//計算我過去發過案子總數
- (void)postTasksCount:(PFUser *)currenter block:(void (^)(BOOL, int))completionBlock{
    PFQuery *query = [PFQuery queryWithClassName:kPostDateClassesKey];
    PFObject *pocase = [PFObject objectWithClassName:@"Category"];
    [pocase setObjectId:@"J7zvtq1KNq"];
    [query whereKey:@"categoryID" notEqualTo:pocase];
    [query whereKey:@"isClosed" equalTo:[NSNumber numberWithBool:TRUE]];
    [query whereKey:@"isCancel" notEqualTo:[NSNumber numberWithBool:TRUE]];
    [query whereKey:@"isHide" notEqualTo:[NSNumber numberWithBool:TRUE]];
    
    [query whereKey:@"ownID" equalTo:currenter];
    query.limit = 1000;
    query.cachePolicy = kPFCachePolicyNetworkOnly;
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, number);
        }
        else
        {
            completionBlock(NO, number);
        }
    }];
}

//計算我過去接過案子總數
- (void)getTasksCount:(PFUser *)currenter block:(void (^)(BOOL, int))completionBlock{
    
    
    PFQuery *query = [PFQuery queryWithClassName:kPostDateClassesKey];
    NSArray *array = [NSArray arrayWithObject:currenter.objectId];
//    [query includeKey:@"ownID"];
//    [query includeKey:@"categoryID"];
//    [query includeKey:@"categoryDetailID"];
    [query whereKey:@"helperList" containedIn:array];
    
    [query whereKey:@"isCancel" notEqualTo:[NSNumber numberWithBool:TRUE]];
    [query whereKey:@"isHide" notEqualTo:[NSNumber numberWithBool:TRUE]];
    [query whereKey:@"isClosed" equalTo:[NSNumber numberWithBool:TRUE]];
    PFObject *pocase = [PFObject objectWithClassName:@"Category"];
    [pocase setObjectId:@"J7zvtq1KNq"];
    [query whereKey:@"categoryID" notEqualTo:pocase];
    
    query.cachePolicy = kPFCachePolicyNetworkOnly;
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, number);
        }
        else
        {
            completionBlock(NO, number);
        }
    }];
    
    
}

//計算我的幫手總數
- (void)getMyHelperCount:(PFUser *)currenter block:(void (^)(BOOL succeeded, NSArray *array))completionBlock{
    PFQuery *queryPostTaksNumber = [PFQuery queryWithClassName:kPAPActivityClassKey];
    [queryPostTaksNumber whereKey:@"fromUser" equalTo:currenter];
    [queryPostTaksNumber whereKey:@"type" equalTo:kPAPActivityTypeJoined];
    queryPostTaksNumber.limit = 10000;
    [queryPostTaksNumber findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, objects);
        }
        else
        {
            completionBlock(NO, nil);
        }
    }];
}

//查看現在已經選擇的人數
+ (void)SelectNumberQuery:(PFQuery *)SelectHelperList block:(void (^)(BOOL succeeded, NSArray *array))completionBlock{
//    [SelectHelperList whereKey:kTaskIsYou equalTo:@YES];
    [SelectHelperList findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, objects);
        }
        else
        {
            completionBlock(NO, nil);
        }
    }];
}

//留言板的總人數
+ (void)MessangerQuery:(PFObject *)caseObject block:(void (^)(BOOL succeeded, NSArray *array))completionBlock{
    PFQuery *caseComment = [PFQuery queryWithClassName:@"CasesComment"];
    [caseComment whereKey:@"caseID" equalTo:caseObject];
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    caseComment.cachePolicy = kPFCachePolicyCacheThenNetwork;
    caseComment.limit = kPAWWallPostsSearch;
    [caseComment orderByAscending:@"createdAt"];
    [caseComment findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, objects);
        }
        else
        {
            completionBlock(NO, nil);
        }
    }];
}
//統計計算用戶的評價。
+ (void)CountUserAverageRating:(PFUser *)user Block:(void (^)(BOOL succeeded, NSArray *array))completionBlock{
    PFQuery *caseRatingQuery = [PFQuery queryWithClassName:@"Activity"];
    [caseRatingQuery whereKey:@"type" equalTo:@"rating"];
    [caseRatingQuery whereKey:@"toUser" equalTo:user];
    caseRatingQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [caseRatingQuery orderByAscending:@"createdAt"];
    caseRatingQuery.limit = 1000;
    [caseRatingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            completionBlock(YES, objects);
        }else{
            completionBlock(NO, nil);
        }
    }];
}

#pragma mark - ()

- (void)setAttributes:(NSDictionary *)attributes forPhoto:(PFObject *)photo {
    NSString *key = [self keyForPhoto:photo];
    [self.cache setObject:attributes forKey:key];
}

- (void)setAttributes:(NSDictionary *)attributes forRestaurant:(PFObject *)restaurant {
    NSString *key = [self keyForRestaurant:restaurant];
    [self.cache setObject:attributes forKey:key];
}

- (void)setAttributes:(NSDictionary *)attributes forUser:(PFUser *)user {
    NSString *key = [self keyForUser:user];
    [self.cache setObject:attributes forKey:key];
}

- (void)setAttributes:(NSDictionary *)attributes forUserGroup:(NSString *)userGroup {
    NSString *key = userGroup;
    [self.cache setObject:attributes forKey:key];
}

- (NSString *)keyForPhoto:(PFObject *)photo {
    return [NSString stringWithFormat:@"photo_%@", [photo objectId]];
}

- (NSString *)keyForRestaurant:(PFObject *)restaurant {
    return [NSString stringWithFormat:@"restaurant_%@", [restaurant objectId]];
}

- (NSString *)keyForUser:(PFUser *)user {
    return [NSString stringWithFormat:@"user_%@", [user objectId]];
}

/**************************
 eatingDate用
 **************************/
//把讀到的結果先chace到該約會單上
- (void)setAttributesForDate:(PFObject *)date askers:(NSArray *)askers commenters:(NSArray *)commenters askedByCurrentUser:(BOOL)askedByCurrentUser{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithBool:askedByCurrentUser],kPAPPhotoAttributesIsAskedByCurrentUserKey,
                                [NSNumber numberWithInt:(int)[askers count]],kPAPPhotoAttributesLikeCountKey,
                                askers,kPAPPhotoAttributesLikersKey,
                                [NSNumber numberWithInt:(int)[commenters count]],kPAPPhotoAttributesCommentCountKey,
                                commenters,kPAPPhotoAttributesCommentersKey,
                                nil];
    
    [self setAttributes:attributes forPhoto:date];
}
- (void)setThisPeopleIsLikedByDateOwner:(PFUser *)thisPeople thisDate:(PFObject *)date liked:(BOOL)liked{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:date]];
    [attributes setObject:[NSNumber numberWithBool:liked] forKey:kPAPPhotoAttributesIsAskedByCurrentUserKey];
    [attributes setObject:thisPeople forKey:kPAPPhotoAttributesIsLikedByThisPeople];
    [self setAttributes:attributes forPhoto:date];
}
- (NSDictionary *)attributesForDate:(PFObject *)date{
    NSString *key = [self keyForPhoto:date];
    return [self.cache objectForKey:key];
}
- (NSNumber *)askCountForDate:(PFObject *)date{
    NSDictionary *attributes = [self attributesForPhoto:date];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesLikeCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}
- (NSNumber *)commentCountForDate:(PFObject *)date{
    NSDictionary *attributes = [self attributesForPhoto:date];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesCommentCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}
- (NSArray *)askersForDate:(PFObject *)date{
    NSDictionary *attributes = [self attributesForPhoto:date];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesLikersKey];
    }
    
    return [NSArray array];
}
- (NSArray *)commentersForDate:(PFObject *)date{
    NSDictionary *attributes = [self attributesForPhoto:date];
    if (attributes) {
        return [attributes objectForKey:kPAPPhotoAttributesCommentersKey];
    }
    
    return [NSArray array];
}

- (BOOL)isDateAskedByCurrentUser:(PFObject *)date{
    NSDictionary *attributes = [self attributesForPhoto:date];
    if (attributes) {
        return [[attributes objectForKey:kPAPPhotoAttributesIsAskedByCurrentUserKey] boolValue];
    }
    
    return NO;
}

- (void)setDateIsAskedByCurrentUser:(PFObject *)date asked:(BOOL)asked{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForPhoto:date]];
    [attributes setObject:[NSNumber numberWithBool:asked] forKey:kPAPPhotoAttributesIsAskedByCurrentUserKey];
    [self setAttributes:attributes forPhoto:date];
}

//計算報名約會的總人數
+ (void)askPostDateCountQuery:(PFQuery *)Date block:(void (^)(BOOL successed, NSArray *array))completionBlock{
    PFQuery *askQuery = [PFQuery queryWithClassName:kAskDateListClassesKey];
    [askQuery whereKey:kAskDateFromPostDate equalTo:Date];
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    askQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    askQuery.limit = kPAWWallPostsSearch;
    [askQuery orderByAscending:@"createdAt"];
    [askQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error == nil )
        {
            completionBlock(YES, objects);
        }
        else
        {
            completionBlock(NO, nil);
        }
    }];
}

//餐廳資料
- (void)setAttributesForRestaurant:(PFObject *)restaurant dates:(NSArray *)dates messagers:(NSArray *)messagers followedByCurrentUser:(BOOL)followedByCurrentUser{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithBool:followedByCurrentUser],kPAPRestaurantAttributesIsFollowedByCurrentUserKey,
                                [NSNumber numberWithInt:(int)[dates count]],kPAPRestaurantAttributesDateCountKey,
                                dates, kPAPRestaurantAttributesDatesKey,
                                [NSNumber numberWithInt:(int)[messagers count]],kPAPRestaurantAttributesMessengerCountKey,
                                messagers, kPAPRestaurantAttributesMessengersKey,
                                nil];
    
    [self setAttributes:attributes forRestaurant:restaurant];
}

- (void)setThisRestaurantIsFollowedByCurrentUser:(PFObject *)restaurant followed:(BOOL)followed{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForRestaurant:restaurant]];
    [attributes setObject:[NSNumber numberWithBool:followed] forKey:kPAPRestaurantAttributesIsFollowedByCurrentUserKey];
    [self setAttributes:attributes forRestaurant:restaurant];
}
- (NSNumber *)dateCountForRestaurant:(PFObject *)restaurant{
    NSDictionary *attributes = [self attributesForRestaurant:restaurant];
    if (attributes) {
        return [attributes objectForKey:kPAPRestaurantAttributesDateCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}
- (NSNumber *)messagerCountForRestaurant:(PFObject *)restaurant{
    NSDictionary *attributes = [self attributesForRestaurant:restaurant];
    if (attributes) {
        return [attributes objectForKey:kPAPRestaurantAttributesMessengerCountKey];
    }
    
    return [NSNumber numberWithInt:0];
}
- (NSArray *)datesForRestaurant:(PFObject *)restaurant{
    NSDictionary *attributes = [self attributesForRestaurant:restaurant];
    if (attributes) {
        return [attributes objectForKey:kPAPRestaurantAttributesDatesKey];
    }
    
    return [NSArray array];
}
- (NSArray *)messagersForRestaurant:(PFObject *)restaurant{
    NSDictionary *attributes = [self attributesForRestaurant:restaurant];
    if (attributes) {
        return [attributes objectForKey:kPAPRestaurantAttributesMessengersKey];
    }
    
    return [NSArray array];
}
- (BOOL)isRestaurantFollowedByCurrentUser:(PFObject *)restaurant{
    NSDictionary *attributes = [self attributesForRestaurant:restaurant];
    if (attributes) {
        return [[attributes objectForKey:kPAPRestaurantAttributesIsFollowedByCurrentUserKey] boolValue];
    }
    
    return NO;
}

@end
