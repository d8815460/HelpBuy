//
//  CMConstants.m
//  chatMessenger
//
//  Created by Ayi on 2014/3/2.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#import "CMConstants.h"


#pragma mark - NSUserDefaults
NSString *const kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey    = @"tw.taiwan8.userDefaults.activityFeedViewController.lastRefresh";        //用戶默認設置的活動資訊 - 視圖 - 控制器刷新鍵
NSString *const kPAPUserDefaultsCreateCaseTableViewControllerLastRefreshKey = @"tw.taiwan8.userDefaults.kPAPUserDefaultsCreateCaseTableViewControllerLastRefreshKey.lastRefresh";
NSString *const kPAPUserDefaultsCacheHelpersKey                             = @"tw.taiwan8.userDefaults.cache.helpers";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCacheFacebookFriendsKey                     = @"tw.taiwan8.userDefaults.cache.facebookFriends";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCachePhonesFriendsKey                       = @"tw.taiwan8.userDefaults.cache.phonesFriends";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCacheFacebookFriendsNumberKey                     = @"tw.taiwan8.userDefaults.cache.facebookFriendsNumber";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCacheFacebookGroupsKey                     = @"tw.taiwan8.userDefaults.cache.facebookGroups";                         //用戶默認緩存社團鍵
NSString *const kPAPUserDefaultsMyTasksTableViewControllerLastRefreshKey    = @"tw.taiwan8.userDefaults.myTasksTableViewController.lastRefresh";        //我的任務最後一次刷新鍵
NSString *const kPAPUserDefaultsWaitTasksTableViewControllerLastRefreshKey  = @"tw.taiwan8.userDefaults.waitTasksTableViewController.lastRefresh";      //等待回應任務最後一次刷新鍵
NSString *const kPAPUserDefaultsEndTasksTableViewControllerLastRefreshKey   = @"tw.taiwan8.userDefaults.endTasksTableViewController.lastRefresh";       //結案任務最後一次刷新鍵
NSString *const kPAPUserDefaultsSelectHelperTableViewControllerLastRefreshKey   =
@"tw.taiwan8.userDefaults.selectHelperTableViewControllerLastRefresh";        //接案幫手選擇頁面最後一次刷新鍵



NSString *const kPAPUploadPhotoQueueKey = @"com.eatingdate.uploadPhoto";        //上傳照片的列隊Key


#pragma mark - Launch URLs
NSString *const kPAPLaunchURLHostTakePicture = @"camera";

#pragma mark - NSNotification
NSString *const PAPAppDelegateApplicationDidReceiveRemoteNotification           = @"tw.taiwan8.appDelegate.applicationDidReceiveRemoteNotification";
NSString *const PAPUtilityUserFollowingChangedNotification                      = @"tw.taiwan8.utility.userFollowingChanged";
NSString *const PAPUtilityUserAddingChangedNotification                      = @"tw.taiwan8.utility.userAddingChanged";
NSString *const PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification     = @"tw.taiwan8.utility.userLikedUnlikedPhotoCallbackFinished";
NSString *const PAPUtilityDidFinishProcessingProfilePictureNotification         = @"tw.taiwan8.utility.didFinishProcessingProfilePictureNotification";
NSString *const PAPTabBarControllerDidFinishEditingPhotoNotification            = @"tw.taiwan8.tabBarController.didFinishEditingPhoto";
NSString *const PAPTabBarControllerDidFinishImageFileUploadNotification         = @"tw.taiwan8.tabBarController.didFinishImageFileUploadNotification";
NSString *const PAPPhotoDetailsViewControllerUserDeletedPhotoNotification       = @"tw.taiwan8.photoDetailsViewController.userDeletedPhoto";
NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification  = @"tw.taiwan8.photoDetailsViewController.userLikedUnlikedPhotoInDetailsViewNotification";
NSString *const PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification   = @"tw.taiwan8.photoDetailsViewController.userCommentedOnPhotoInDetailsViewNotification";
NSString *const PAPPhotoDetailsViewControlleerUserGetedOnPhotoNotification      = @"tw.taiwan8.photoDetailsViewController.userGetdPhotoInDetailsViewNotification";
#pragma mark - Notification Location names:
NSString *const kPAWFilterDistanceChangeNotification = @"kPAWFilterDistanceChangeNotification";
NSString *const kPAWLocationChangeNotification = @"kPAWLocationChangeNotification";
NSString *const kPAWFilterHelperTypeChangeNotification = @"kPAWFilterHelperTypeChangeNotification";
NSString *const kPAWFilterCumtomerTypeChangeNotification = @"kPAWFilterCumtomerTypeChangeNotification";

#pragma mark - User Info Keys
NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey = @"liked";
NSString *const kPAPEditPhotoViewControllerUserInfoCommentKey = @"comment";

#pragma mark - Installation Class
// Field keys
NSString *const kPAPInstallationUserKey = @"user";
NSString *const kPAPInstallationChannelsKey = @"channels";


#pragma mark - Activity Class
// Class key
NSString *const kPAPActivityClassKey = @"Activity";

// Field keys
NSString *const kPAPActivityTypeKey         = @"type";
NSString *const kPAPActivityFromUserKey     = @"fromUser";
NSString *const kPAPActivityToUserKey       = @"toUser";
NSString *const kPAPActivityCommentKey      = @"comment";
NSString *const kPAPActivityDateKey         = @"fromDate";
NSString *const kPAPActivityIsReadedKey     = @"isReaded";

// Type values
NSString *const kPAPActivityTypePost                = @"post";          //發案
NSString *const kPAPActivityTypeTake                 = @"take";           //接案
NSString *const kPAPActivityTypeOwnerCheckHelper    = @"check";         //確定幫手
NSString *const kPAPActivityTypeOwnerDidntCheckHelper= @"fail";         //確定選擇其他幫手通知
NSString *const kPAPActivityTypeJoined              = @"joined";        //加入，通知好友我也安裝了
NSString *const kPAPActivityTypeSpan                = @"span";          //封鎖
NSString *const kPAPActivityTypeLike                = @"like";          //喜歡
NSString *const kPAPActivityTypeAsk                 = @"ask";           //報名約會
NSString *const kPAPActivityTypeAnswer              = @"answer";        //發起者決定你
NSString *const kPAPActivityTypeReject              = @"reject";        //發起者拒絕你
NSString *const kPAPActivityTypeSend                = @"send";          //發起約會單
NSString *const kPAPActivityTypecomment             = @"comment";       //某人留言給你
NSString *const kPAPActivityTypeBlock               = @"block";         //某人檢舉你
NSString *const kPAPActivityTypeRate                = @"rating";        //評價
NSString *const kPAPActivityTypeComment             = @"comment";       //留言
NSString *const kPAPActivityTypeFollow              = @"follow";        //跟隨
NSString *const kPAPActivityTypeCancel              = @"cancel";        //取消報名
NSString *const kPAPActivityTypePassCheck           = @"pass";



#pragma mark - NSNotification userInfo keys:
NSString * const kPAWFilterDistanceKey      = @"filterDistance";
NSString * const kPAWLocationKey            = @"location";


#pragma mark - User Class
// Field keys
NSString *const kPAPUserDisplayNameKey                          = @"displayName";
NSString *const kPAPUserFacebookIDKey                           = @"facebookId";
NSString *const kPAPUserPhotoIDKey                              = @"photoId";
NSString *const kPAPUserProfilePicSmallKey                      = @"picSmall";
NSString *const kPAPUserProfilePicMediumKey                     = @"picMedium";
NSString *const kPAPUserFacebookFriendsKey                      = @"facebookFriends";
NSString *const kPAPUserAlreadyAutoFollowedFacebookFriendsKey   = @"userAlreadyAutoFollowedFacebookFriends";
NSString *const kPAPUserPrivateChannelKey                       = @"channel";
//資料表新增生日、性別、email、地區、姓氏、名字
NSString *const kPAPUserFacebookBirthdayKey                     = @"birthday";
NSString *const kPAPUserFacebookGenderKey                       = @"gender";
NSString *const kPAPUserFacebookEmailKey                        = @"email";
NSString *const kPAPUserFacebookLocalsKey                       = @"fbLocale";
NSString *const kPAPUserFacebookFirstNameKey                    = @"fbFirstName";
NSString *const kPAPUserFacebookLastNameKey                     = @"fbLastName";
NSString *const kPAPUserFacebookLocation                        = @"location";
NSString *const kPAPUserMaxPostQuotaKey                         = @"postQuota";
NSString *const kPAPUserMaxReceiveQuotaKey                      = @"receiveQuota";
NSString *const kPAPUserFrequencyKey                            = @"frequency";

NSString *const kCMUserNameString           = @"username";
NSString *const kCMUserFirstName            = @"firstName";
NSString *const kCMUserLastName             = @"lastName";
NSString *const defaultsFilterDistanceKey   = @"filterDistance";
NSString *const defaultsLocationKey         = @"currentLocation";
NSString *const kPAPParseLocationKey        = @"location";
NSString *const kPAPUserTypeKey             = @"type";
NSString *const kPAPUserIsReadLocationKey   = @"isReadLocation";
//Type
NSString *const kPAPUserTypeHelperKey       = @"helper";
NSString *const kPAPUserTypeCustomerKey     = @"unhelper";

#pragma mark - PFObject User Location Class
// Class key
NSString *const kPAPUserLocationClassKey        = @"UserLocation";
// Field keys
NSString *const kPAPUserLocationUserKey         = @"user";
NSString *const kPAPUserLocationLocationKey     = @"location";

//個人檔案照片儲存位置
NSString * const MediumImagefilePath = @"Documents/medium.png";
NSString * const SmallRoundedImagefilePath = @"Documents/small.png";

#pragma mark - Push Notification Payload Keys

NSString *const kAPNSAlertKey = @"alert";
NSString *const kAPNSBadgeKey = @"badge";
NSString *const kAPNSSoundKey = @"sound";

// the following keys are intentionally kept short, APNS has a maximum payload limit
// 下面的鍵被故意盡量短，APNS的最大有效載荷限制
NSString *const kPAPPushPayloadPayloadTypeKey               = @"p";
NSString *const kPAPPushPayloadPayloadTypeActivityKey       = @"a";

NSString *const kPAPPushPayloadActivityTypeKey              = @"t";

NSString *const kPAPPushPayloadActivitySendPlzKey           = @"post";     //業主發案
NSString *const kPAPPushPayloadActivityTakeUpKey            = @"take";     //幫手接案
NSString *const kPAPPushPayloadActivityOwnerCheckHelpKey    = @"check";     //業主確認幫手
NSString *const kPAPPushPayloadActivityOwnerDidntCheckHelpKey = @"fail";    //業主已指派別人
NSString *const kPAPPushPayloadActivityIAmInstallKey        = @"joined";     //當前用戶通知好友
NSString *const kPAPPushPayloadActivityBlockKey             = @"span";     //封鎖
NSString *const kPAPPushPayloadActivityLikeKey              = @"like";     //喜歡
NSString *const kPAPPushPayloadActivityAskKey               = @"ask";       //報名
NSString *const kPAPPushPayloadActivityRatingKey            = @"rating";     //評價
NSString *const kPAPPushPayloadActivityCommentKey           = @"comment";     //留言
NSString *const kPAPPushPayloadActivityFollowKey            = @"follow";     //跟隨
NSString *const kPAPPushPayloadActivitySMSKey               = @"aotp";      //AOTP推播
NSString *const kPAPPushPayloadActivitySMSResultKey         = @"result";     // = 2 成功認證

NSString *const kPAPPushPayloadFromUserObjectIdKey          = @"fu";
NSString *const kPAPPushPayloadToUserObjectIdKey            = @"tu";
NSString *const kPAPPushPayloadPostDateObjectIdKey          = @"po";



#pragma mark - 偏好設定類別
// Class key
NSString *const kPAPUserPreferenceCategoryClassKey          = @"PreferenceCategory";

// Field keys
NSString *const kPAPUserPreferenceCategoryCharityKey        = @"isDharity";
NSString *const kPAPUserPreferenceCategoryPurchaseKey       = @"isPurchase";
NSString *const kPAPUserPreferenceCategoryDeliveryKey       = @"isDelivery";
NSString *const kPAPUserPreferenceCategorySelfDefineKey     = @"isSelfdefine";
NSString *const kPAPUserPreferenceCategoryRallyKey          = @"isDove";
NSString *const kPAPUserPreferenceCategoryCleanerKey        = @"isCleaner";
NSString *const kPAPUserPreferenceCategoryActivitiesKey     = @"isActivities";
NSString *const kPAPUserPreferenceCategoryWaiterKey         = @"isWaiter";
NSString *const kPAPUserPreferenceCategoryPromoterKey       = @"isPromoter";
NSString *const kPAPUserPreferenceCategoryActorKey          = @"isActor";
NSString *const kPAPUserPreferenceCategoryConstructionKey   = @"isConstruction";
NSString *const kPAPUserPreferenceCategorySurveyKey         = @"isSurvey";
NSString *const kPAPUserPreferenceCategoryFactoryKey        = @"isFactory";
NSString *const kPAPUserPreferenceCategoryDmKey             = @"isDm";
NSString *const kPAPUserPreferenceCategoryDollKey           = @"isDoll";
NSString *const kPAPUserPreferenceCategoryArtKey            = @"isArt";
NSString *const kPAPUserPreferenceCategoryWebdesignKey      = @"isWebdesign";
NSString *const kPAPUserPreferenceCategoryElectricianKey    = @"isElectrician";
NSString *const kPAPUserPreferenceCategoryComputerKey       = @"isComputer";
NSString *const kPAPUserPreferenceCategoryAccountantKey     = @"isAccountant";
NSString *const kPAPUserPreferenceCategoryLawyerKey         = @"isLawyer";
NSString *const kPAPUserPreferenceCategoryModelKey          = @"isModel";
NSString *const kPAPUserPreferenceCategoryTranslatorKey     = @"isTranslator";
NSString *const kPAPUserPreferenceCategoryNurseKey          = @"isNurse";
NSString *const kPAPUserPreferenceCategoryDaycareKey        = @"isDaycare";


#pragma mark - 偏好設定類別
// Class key
NSString *const kPAPUserPreferenceTimeClassKey          = @"PreferenceTime";

// Field keys
NSString *const kPAPUserPreferenceTimeMorningKey        = @"morning";
NSString *const kPAPUserPreferenceTimeAfternoonKey      = @"afternoon";
NSString *const kPAPUserPreferenceTimeNightKey          = @"night";
NSString *const kPAPUserPreferenceTimeMidNightKey       = @"midnight";
NSString *const kPAPUserPreferenceTimeAllKey            = @"all";

NSUInteger const kPAWWallPostMaximumCharacterCount = 140;

NSUInteger const kPAWWallPostsSearch = 20; // query limit for pins and tableviewcells

// Parse API key constants:
//NSString * const kPAWParsePostsClassKey = @"Posts";
NSString * const kPAWParseUserKey = @"user";
NSString * const kPAWParseUsernameKey = @"username";
NSString * const kPAWParseTextKey = @"text";
NSString * const kPAWParseLocationKey = @"toGeo";

// UI strings:
NSString * const kPAWWallCantViewPost = @"距離您太遠！請再靠近";

//紀錄是不是第一次安裝，要出現tutorial
NSString *const firstTimeInstallKey = @"firstTimeInstallKey";

//大類別的存檔路徑
NSString *const mainCategoryFile = @"mainCategoryFile.text";
NSString *const subCategoryFile = @"subCategoryFile.text";


//是否為第一次用戶參數
NSString *const myFirstTimeFilePath = @"myfirstTime.text";
NSString *const myFirstTimeManagerPath = @"myFirstTimeManager.text";

//小類別的存檔路徑
/* index = 0 , 公益志工     0個小項
 * index = 1 , 臨時人力     10個小項
 * index = 2 , 代買        6個小項
 * index = 3 , 代送        6個小項
 * index = 4 , 活動造勢     6個小項
 * index = 5 , 專業人力     8個小項
 * index = 6 , 自定幫手     0個小項
 * index = 7 , 協尋幫手     0個小項
 */
NSString *const partTimeSubCategoryFile = @"partTimeSubCategoryFile";           //1
NSString *const buySubCategoryFile = @"buySubCategoryFile";                     //2
NSString *const sendSubCategoryFile = @"sendSubCategoryFile";                   //3
NSString *const activitySubCategoryFile = @"activitySubCategoryFile";           //4
NSString *const professionalSubCategoryFile = @"professionalSubCategoryFile";   //5


//發案子
NSString *const tasksSyncNewFormat = @"tasksSyncNewFormat";
//案子存檔路徑
NSString *const WriteTaskFile = @"WriteTaskFile.txt";

#pragma mark - 報名
//約會報名主key
NSString *const kAskDateListClassesKey      = @"DateList";              //主Key
//table
NSString *const kAskDateFromPostDate    = @"fromPostDate";      //哪個約會單
NSString *const kAskFromUser            = @"fromUser";          //誰報名
NSString *const kAskToUser              = @"toUser";            //報名誰的約會
NSString *const kAskIsLike                 = @"isLike";            //決定人選
NSString *const kAskIsCancel               = @"isCancel";          //報名者是否取消

//約會任務單key
NSString *const kPostDateClassesKey     = @"PostDate";          //主Key
NSString *const kDateObjectId           = @"objectId";
NSString *const kDateFromUser           = @"fromUser";          //誰發起約會單
NSString *const kDateType               = @"dateType";          //約會形式（我請客，誰請我）
NSString *const kDateTitle              = @"dateTitle";         //約會主題
NSString *const kDatePicMedium          = @"picMedium";         //發布約會背景照片（大）
NSString *const kDatePicSmall           = @"picSmall";          //發布約會背景照片（小）
NSString *const kDateRestaurant         = @"restaurant";        //發布約會的餐廳
NSString *const kDateTime               = @"dateTime";          //約會的時間
NSString *const kDateRestaurantCategory = @"restaurantCategory";//餐廳類別
NSString *const kDateRestaurantName     = @"restaurantName";    //餐廳名稱
NSString *const kDateRestaurantAddress  = @"restaurantAddress"; //餐廳地址
NSString *const kDateRestaurantAdministrativeArea   = @"administrativeArea";//縣市
NSString *const kDateRestaurantCity     = @"city";              //市區
NSString *const kDateRestaurantGeo      = @"restaurantGeo";     //餐廳經緯度
NSString *const kDateRestaurantPhone    = @"restaurantPhone";   //餐廳電話
NSString *const kDateRestaurantMinCost  = @"restaurantMinCost"; //餐廳最低消費
NSString *const kDateGameType           = @"gameType";          //馬上約或指定約或發布約
NSString *const kDatePeopleAskNumber    = @"peopleAskNumber";   //報名人數
NSString *const kDateToUser             = @"toUser";            //最後決定約會的人選
NSString *const kDatePostCost           = @"postCost";          //約會單花費的信用額度
NSString *const kIsTVIP                 = @"isTVIP";            //是否用TVIP身份發佈
NSString *const kIsVIP                  = @"isVIP";             //是不是VIP
NSString *const kIsGVIP                 = @"isGVIP";            //是不是GVIP
NSString *const kDateBeenLookedAmount   = @"beenLookedAmount";  //該篇貼文被觀看的次數
NSString *const kDateIsChosed           = @"isChosed";          //已經確定人選
NSString *const kDateIsFinished         = @"isFinished";        //已經互相給評價


#pragma mark - Cached 任務 Attributes
// keys
NSString *const kPAPPhotoAttributesIsAskedByCurrentUserKey = @"isAskedByCurrentUser";
NSString *const kPAPPhotoAttributesIsReadedByCurrentUserKey = @"isReadedByCurrentUser";
NSString *const kPAPPhotoAttributesLikeCountKey            = @"likeCount";
NSString *const kPAPPhotoAttributesLikersKey               = @"likers";
NSString *const kPAPPhotoAttributesCommentCountKey         = @"commentCount";
NSString *const kPAPPhotoAttributesCommentersKey           = @"commenters";
NSString *const kPAPPhotoAttributesIsLikedByThisPeople     = @"isLikedByThisPeople";

#pragma mark - Cached Restaurant Attributes
// keys
NSString *const kPAPRestaurantAttributesIsFollowedByCurrentUserKey  = @"isFollowedByCurrentUser";
NSString *const kPAPRestaurantAttributesDateCountKey                = @"dateCount";
NSString *const kPAPRestaurantAttributesDatesKey                    = @"dates";
NSString *const kPAPRestaurantAttributesMessengerCountKey           = @"messengerCount";
NSString *const kPAPRestaurantAttributesMessengersKey               = @"messengers";


#pragma mark - Cached User Attributes
// keys
NSString *const kPAPUserAttributesPhotoCountKey                 = @"photoCount";
NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey    = @"isFollowedByCurrentUser";
NSString *const kPAPUserAttributesIsAddedByCurrentUserKey    = @"isAddedByCurrentUser";
NSString *const kPAPUserAttributesIsAddedToGroupKey             = @"isAddedToGroup";

#pragma mark - Map Needs
double const kPAWFeetToMeters = 0.3048;                                 // this is an exact value.
double const kPAWFeetToMiles = 5280.0;                                 // this is an exact value.
double const kPAWWallPostMaximumSearchDistance = 2.0; //公里
double const kPAWMetersInAKilometer = 1000.0;                           // this is an exact value.

NSUInteger const kPAWMapCarsSearch = 5;                              // query limit for cars on Map


// ************* Share Facebook Switch *****************
BOOL isFacebookSwitchOn;
PFObject *casesConstants;
PFObject *myGroupCategoryObject;
PFUser *ratingUser;
NSNumber *newBadgeValue;
NSArray *loveAddress;

NSString *const UploadDataNoti =        @"UploadDataNoti";

BOOL isFromPostTaskFlow;
BOOL hasCenterButton;


// ***************** 用戶的基本資料 ****************************
NSUserDefaults *userDefaults;


// ***************** 餐廳的類別 ****************************
NSArray *categoriesForRestaurant;