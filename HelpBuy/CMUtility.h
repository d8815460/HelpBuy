//
//  CMUtility.h
//  chatMessenger
//
//  Created by Ayi on 2014/3/4.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface CMUtility : NSObject <UIAlertViewDelegate>

+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenHeight;
+ (NSInteger)windowWidth;
+ (NSInteger)windowHeight;
+ (void)likePhotoInBackground:(id)photo block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unlikePhotoInBackground:(id)photo block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void)processFacebookProfilePictureData:(NSData *)data;

+ (void)followUserInBackground:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)followUserEventually:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)followUsersEventually:(NSArray *)users block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unfollowUserEventually:(PFUser *)user;
+ (void)unfollowUsersEventually:(NSArray *)users;

+ (void)addUserToGroupInBackground:(PFUser *)user toGroup:(PFObject *)group block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)addUserToGroupEventually:(PFUser *)user toGroup:(PFObject *)group block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)addUsersToGroupEventually:(NSArray *)users toGroup:(PFObject *)group block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unaddToGroupUserEventually:(PFUser *)user fromGroup:(PFObject *)group;
+ (void)unaddToGroupUsersEventually:(NSArray *)users fromGroup:(PFObject *)group;




///// helperlists
//+ (void)addUserToHelperListInBackground:(PFUser *)user toCase:(PFObject *)cases block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
//+ (void)addUserToHelperListEventually:(PFUser *)user toCase:(PFObject *)cases block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
//+ (void)addUsersToHelperListEventually:(NSArray *)users toCase:(PFObject *)cases block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
//+ (void)unaddToHelperListEventually:(PFUser *)user fromCase:(PFObject *)cases;

/////

+ (void)sendFollowingPushNotification:(PFUser *)user;

+ (PFQuery *)queryForActivitiesOnPhoto:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy;

//從Activities Query該約會單所有的約會請求、留言訊息
+ (PFQuery *)queryForActivitiesOnDate:(PFObject *)date cachePolicy:(PFCachePolicy)cachePolicy;


//用戶有一個有效的Facebook數據
+ (BOOL)userHasValidFacebookData:(PFUser *)user;
//用戶有個人照片
+ (BOOL)userHasProfilePictures:(PFUser *)user;
//截取用戶的名字顯示在DisplayName上
+ (NSString *)firstNameForDisplayName:(NSString *)displayName;

//判斷用戶是業主還是幫手模式
+(void)isHelperblock:(void (^)(BOOL succeeded, PFObject *user))completionBlock;

//判斷用戶是業主還是幫手模式
+(BOOL)isHelper;

//讀取大類別物件
+ (PFQuery *)getCategory;

//讀取小類別物件
+ (PFQuery *)getCategoryDetail:(PFObject *)category;





//幫手收到業主發送訊息__前景執行中
+ (void)HelperGotPushInForeGround:(NSDictionary *)launchOptions fromCustomId:(NSString *)CustomId AndCaseId:(NSString *)caseId inRootView:(UIViewController *)rootViewController;
//幫手收到業主發送訊息__背景執行
+ (void)HelperGotPushInBackGround:(NSDictionary *)launchOptions inRootView:(UIViewController *)rootViewController;
//業主收到幫手發送訊息__前景執行中
+ (void)CustomerGotPushInForeGround:(NSDictionary *)launchOptions fromHelperId:(NSString *)helperId AndCaseId:(NSString *)caseId inRootView:(UIViewController *)rootViewController;
//業主收到幫手發送訊息__背景執行
+ (void)CustomerGotPushInBackGround:(NSDictionary *)launchOptions inRootView:(UIViewController *)rootViewController;

//系統推薦沒有人接案
+ (void)nonOneGetThisJob:(UIButton *)button InTheView:(UIView *)theView;

//看別人的任務，系統推薦
//+ (void)SystemAutoFromQuery:(PFQuery *)helperList withObjects:(NSArray *)objects AndCaseObject:(PFObject *)caseObject InTheView:(UIView *)theView ChangeButtonName:(UIButton *)button;

//業主自選，我已經接過
+ (void)havedGetThisJob:(UIButton *)button InTheView:(UIView *)theView;

//看別人的任務，業主自選
//+ (void)CustomerChoseFromQuery:(PFQuery *)helperList withObjects:(NSArray *)objects AndCaseObject:(PFObject *)caseObject InTheView:(UIView *)theView ChangeButtonName:(UIButton *)button;

+ (void)drawSideDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;
+ (void)drawSideAndBottomDropShadowForRect:(CGRect)rect inContext:(CGContextRef)context;

//經緯度轉換成縣市單位
+ (void)getLocationName:(PFGeoPoint *)point block:(void (^)(BOOL succeeded, NSString *nameLabel))completionBlock;

//顏色變成UIImage
+ (UIImage *) imageFromColor:(UIColor *)color;

//刪除用戶照片
+ (void)deleteUserPhoto:(PFObject *)photoObjct;


// APP 內部廣播系統，確保頁面切來切去訊息仍然會送到
//+(void) addMinnaListener:(id<MinnaNotificationProtocol>) listener;
//+(void) broadcastMinnaMessage:(NSString *)broadcastMessage;


//正在定位的約吃飯數量
+ (void)nowDatingNumberPostAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSNumber *number))completionBlock;

//約吃飯留言訊息數量
+ (void)nowMessengerNumberAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSString *number))completionBlock;

//正在定位的約吃飯Array
+ (void)nowDatingArrayPostAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSArray *array))completionBlock;

//約吃飯留言訊息數量
+ (void)nowMessengerArrayAtRestaurant:(PFObject *)restaurant block:(void (^)(BOOL succeeded, NSString *array))completionBlock;

@end
