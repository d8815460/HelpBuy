//
//  CMConstants.h
//  chatMessenger
//
//  Created by Ayi on 2014/3/2.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#define SYSTEM_NAVIBAR_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:1]
#define ISIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue] >= 8.0)
#define ISIOS71 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue] >= 7.1)
#define ISIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 7.0)
#define ISIOS6 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6)
#define IS40 ([self windowHeight]>=640)
#define IS400 (self.view.frame.size.height > 460)

#pragma mark - NSUserDefaults
extern NSString *const kPAPUserDefaultsCacheHelpersKey;
extern NSString *const kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey;        //用戶默認設置的活動資訊 - 視圖 - 控制器刷新鍵
extern NSString *const kPAPUserDefaultsCreateCaseTableViewControllerLastRefreshKey;

extern NSString *const kPAPUserDefaultsCacheFacebookFriendsKey;                         //用戶默認緩存給好友鍵
extern NSString *const kPAPUserDefaultsCacheFacebookFriendsNumberKey;
extern NSString *const kPAPUserDefaultsCachePhonesFriendsKey;
extern NSString *const kPAPUserDefaultsCacheFacebookGroupsKey;                          //用戶默認緩存社團鍵
extern NSString *const kPAPUserDefaultsMyTasksTableViewControllerLastRefreshKey;        //我的任務最後一次刷新鍵
extern NSString *const kPAPUserDefaultsWaitTasksTableViewControllerLastRefreshKey;      //等待回應任務最後一次刷新鍵
extern NSString *const kPAPUserDefaultsEndTasksTableViewControllerLastRefreshKey;       //結案任務最後一次刷新鍵
extern NSString *const kPAPUserDefaultsSelectHelperTableViewControllerLastRefreshKey;   //接案幫手選擇頁面最後一次刷新鍵


extern NSString *const kPAPUploadPhotoQueueKey;   //上傳照片的列隊Key

#pragma mark - Launch URLs
extern NSString *const kPAPLaunchURLHostTakePicture;

#pragma mark - NSNotification
extern NSString *const PAPAppDelegateApplicationDidReceiveRemoteNotification;
extern NSString *const PAPUtilityUserFollowingChangedNotification;
extern NSString *const PAPUtilityUserAddingChangedNotification;
extern NSString *const PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification;
extern NSString *const PAPUtilityDidFinishProcessingProfilePictureNotification;
extern NSString *const PAPTabBarControllerDidFinishEditingPhotoNotification;
extern NSString *const PAPTabBarControllerDidFinishImageFileUploadNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserDeletedPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControlleerUserGetedOnPhotoNotification;
// Notification names:
extern NSString * const kPAWFilterDistanceChangeNotification;
extern NSString * const kPAWLocationChangeNotification;
extern NSString * const kPAWFilterHelperTypeChangeNotification;
extern NSString * const kPAWFilterCumtomerTypeChangeNotification;

#pragma mark - User Info Keys
extern NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey;
extern NSString *const kPAPEditPhotoViewControllerUserInfoCommentKey;

#pragma mark - Installation Class
// Field keys
extern NSString *const kPAPInstallationUserKey;
extern NSString *const kPAPInstallationChannelsKey;


#pragma mark - 報名
//約會報名主key
extern NSString *const kAskDateListClassesKey;         //主Key
//table
extern NSString *const kAskDateFromPostDate;        //哪個約會單
extern NSString *const kAskFromUser;                //誰報名
extern NSString *const kAskToUser;                  //報名誰的約會
extern NSString *const kAskIsLike;                     //決定人選
extern NSString *const kAskIsCancel;                   //報名者是否取消


#pragma mark - Post Date Class
// ***************** 發布任務暫存 ****************************

//約會任務單主key
extern NSString *const kPostDateClassesKey;     //主Key
//table
extern NSString *const kDateObjectId;
extern NSString *const kDateFromUser;           //誰發起約會單
extern NSString *const kDateType;               //約會形式（我請客，誰請我）
extern NSString *const kDateTitle;              //約會主題
extern NSString *const kDatePicMedium;          //發布約會背景照片（大）
extern NSString *const kDatePicSmall;           //發布約會背景照片（小）
extern NSString *const kDateRestaurant;         //發布約會的餐廳
extern NSString *const kDateTime;               //約會的時間
extern NSString *const kDateRestaurantCategory; //餐廳類別
extern NSString *const kDateRestaurantName;     //餐廳名稱
extern NSString *const kDateRestaurantAddress;  //餐廳地址
extern NSString *const kDateRestaurantAdministrativeArea;//縣市
extern NSString *const kDateRestaurantCity;     //市區
extern NSString *const kDateRestaurantGeo;      //餐廳經緯度
extern NSString *const kDateRestaurantPhone;    //餐廳電話
extern NSString *const kDateRestaurantMinCost;  //餐廳最低消費
extern NSString *const kDateGameType;           //馬上約或指定約或發布約
extern NSString *const kDatePeopleAskNumber;    //報名人數
extern NSString *const kDateToUser;             //最後決定約會的人選
extern NSString *const kDatePostCost;           //約會單花費的信用額度
extern NSString *const kIsTVIP;                 //是否用TVIP身份發佈
extern NSString *const kIsVIP;                  //是不是VIP
extern NSString *const kIsGVIP;                 //是不是GVIP
extern NSString *const kDateBeenLookedAmount;   //該篇貼文被觀看的次數
extern NSString *const kDateIsChosed;           //已經確定人選
extern NSString *const kDateIsFinished;         //已經互相給評價


#pragma mark - PFObject Activity Class
// Class key
extern NSString *const kPAPActivityClassKey;

// Field keys
extern NSString *const kPAPActivityTypeKey;
extern NSString *const kPAPActivityFromUserKey;
extern NSString *const kPAPActivityToUserKey;
extern NSString *const kPAPActivityCommentKey;
extern NSString *const kPAPActivityDateKey;
extern NSString *const kPAPActivityIsReadedKey;

// Type values
extern NSString *const kPAPActivityTypePost;               //發案
extern NSString *const kPAPActivityTypeTake;                //接案
extern NSString *const kPAPActivityTypeOwnerCheckHelper;   //確定幫手
extern NSString *const kPAPActivityTypeOwnerDidntCheckHelper; //確定選擇其他幫手
extern NSString *const kPAPActivityTypeJoined;             //加入，通知好友我也安裝了
extern NSString *const kPAPActivityTypeSpan;               //封鎖
extern NSString *const kPAPActivityTypeLike;               //喜歡
extern NSString *const kPAPActivityTypeAsk;                  //某人報名約會
extern NSString *const kPAPActivityTypeAnswer;        //發起者決定你
extern NSString *const kPAPActivityTypeReject;        //發起者拒絕你
extern NSString *const kPAPActivityTypeSend;          //發起約會單
extern NSString *const kPAPActivityTypecomment;       //某人留言給你
extern NSString *const kPAPActivityTypeBlock;         //某人檢舉你
extern NSString *const kPAPActivityTypeRate;               //評價
extern NSString *const kPAPActivityTypeComment;            //留言
extern NSString *const kPAPActivityTypeFollow;             //跟隨
extern NSString *const kPAPActivityTypeCancel;             //取消報名
extern NSString *const kPAPActivityTypePassCheck;          //通過驗證
extern NSString *const kPAPPushPayloadActivitySMSKey;
extern NSString *const kPAPPushPayloadActivitySMSResultKey;

// NSNotification userInfo keys:
extern NSString * const kPAWFilterDistanceKey;
extern NSString * const kPAWLocationKey;





#define PAWLocationAccuracy double

#pragma mark - Launch URLs
extern NSString *const kPAPLaunchURLHostTakePicture;                                //啟動URL主機拍照

#pragma mark - PFObject User Class
// Field keys
extern NSString *const kPAPUserDisplayNameKey;
extern NSString *const kPAPUserFacebookIDKey;
extern NSString *const kPAPUserPhotoIDKey;
extern NSString *const kPAPUserProfilePicSmallKey;
extern NSString *const kPAPUserProfilePicMediumKey;
extern NSString *const kPAPUserFacebookFriendsKey;
extern NSString *const kPAPUserAlreadyAutoFollowedFacebookFriendsKey;
extern NSString *const kPAPUserPrivateChannelKey;
//facebook 生日、性別、email、地區、姓氏、名字
extern NSString *const kPAPUserFacebookBirthdayKey;
extern NSString *const kPAPUserFacebookGenderKey;
extern NSString *const kPAPUserFacebookEmailKey;
extern NSString *const kPAPUserFacebookLocalsKey;
extern NSString *const kPAPUserFacebookFirstNameKey;
extern NSString *const kPAPUserFacebookLastNameKey;
extern NSString *const kPAPUserFacebookLocation;
extern NSString *const kPAPUserMaxPostQuotaKey;
extern NSString *const kPAPUserMaxReceiveQuotaKey;
extern NSString *const kPAPUserFrequencyKey;
//個人資訊的key
extern NSString *const kCMUserNameString;
extern NSString *const kCMUserFirstName;
extern NSString *const kCMUserLastName;
extern NSString *const defaultsFilterDistanceKey;
extern NSString *const defaultsLocationKey;
extern NSString *const kPAPParseLocationKey;
extern NSString *const kPAPUserTypeKey;
extern NSString *const kPAPUserIsReadLocationKey;
//Type的類型
// Type values
extern NSString *const kPAPUserTypeHelperKey;
extern NSString *const kPAPUserTypeCustomerKey;

//Type的類型
extern NSString *const kPAPUserType;

#pragma mark - PFObject User Location Class
// Class key
extern NSString *const kPAPUserLocationClassKey;
// Field keys
extern NSString *const kPAPUserLocationUserKey;
extern NSString *const kPAPUserLocationLocationKey;

// 個人檔案照片儲存位置
extern NSString * const MediumImagefilePath;
extern NSString * const SmallRoundedImagefilePath;

//是否為第一次用戶參數
extern NSString *const myFirstTimeFilePath;
extern NSString *const myFirstTimeManagerPath;

#pragma mark - 偏好設定類別
// Class key
extern NSString *const kPAPUserPreferenceCategoryClassKey;

// Field keys
extern NSString *const kPAPUserPreferenceCategoryCharityKey;
extern NSString *const kPAPUserPreferenceCategoryPurchaseKey;
extern NSString *const kPAPUserPreferenceCategoryDeliveryKey;
extern NSString *const kPAPUserPreferenceCategorySelfDefineKey;
extern NSString *const kPAPUserPreferenceCategoryRallyKey;
extern NSString *const kPAPUserPreferenceCategoryCleanerKey;
extern NSString *const kPAPUserPreferenceCategoryActivitiesKey;
extern NSString *const kPAPUserPreferenceCategoryWaiterKey;
extern NSString *const kPAPUserPreferenceCategoryPromoterKey;
extern NSString *const kPAPUserPreferenceCategoryActorKey;
extern NSString *const kPAPUserPreferenceCategoryConstructionKey;
extern NSString *const kPAPUserPreferenceCategorySurveyKey;
extern NSString *const kPAPUserPreferenceCategoryFactoryKey;
extern NSString *const kPAPUserPreferenceCategoryDmKey;
extern NSString *const kPAPUserPreferenceCategoryDollKey;
extern NSString *const kPAPUserPreferenceCategoryArtKey;
extern NSString *const kPAPUserPreferenceCategoryWebdesignKey;
extern NSString *const kPAPUserPreferenceCategoryElectricianKey;
extern NSString *const kPAPUserPreferenceCategoryComputerKey;
extern NSString *const kPAPUserPreferenceCategoryAccountantKey;
extern NSString *const kPAPUserPreferenceCategoryLawyerKey;
extern NSString *const kPAPUserPreferenceCategoryModelKey;
extern NSString *const kPAPUserPreferenceCategoryTranslatorKey;
extern NSString *const kPAPUserPreferenceCategoryNurseKey;
extern NSString *const kPAPUserPreferenceCategoryDaycareKey;

#pragma mark - 偏好設定類別
// Class key
extern NSString *const kPAPUserPreferenceTimeClassKey;

// Field keys
extern NSString *const kPAPUserPreferenceTimeMorningKey;
extern NSString *const kPAPUserPreferenceTimeAfternoonKey;
extern NSString *const kPAPUserPreferenceTimeNightKey;
extern NSString *const kPAPUserPreferenceTimeMidNightKey;
extern NSString *const kPAPUserPreferenceTimeAllKey;


#pragma mark - Cached User Attributes
// keys
extern NSString *const kPAPUserAttributesPhotoCountKey;
extern NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey;
extern NSString *const kPAPUserAttributesIsAddedByCurrentUserKey;
extern NSString *const kPAPUserAttributesIsAddedToGroupKey;

#pragma mark - PFPush Notification Payload Keys

extern NSString *const kAPNSAlertKey;
extern NSString *const kAPNSBadgeKey;
extern NSString *const kAPNSSoundKey;

extern NSString *const kPAPPushPayloadPayloadTypeKey;
extern NSString *const kPAPPushPayloadPayloadTypeActivityKey;

extern NSString *const kPAPPushPayloadActivityTypeKey;
extern NSString *const kPAPPushPayloadActivitySendPlzKey;
extern NSString *const kPAPPushPayloadActivityTakeUpKey;
extern NSString *const kPAPPushPayloadActivityOwnerCheckHelpKey;
extern NSString *const kPAPPushPayloadActivityOwnerDidntCheckHelpKey;
extern NSString *const kPAPPushPayloadActivityIAmInstallKey;
extern NSString *const kPAPPushPayloadActivityBlockKey;
extern NSString *const kPAPPushPayloadActivityLikeKey;
extern NSString *const kPAPPushPayloadActivityAskKey;
extern NSString *const kPAPPushPayloadActivityRatingKey;
extern NSString *const kPAPPushPayloadActivityCommentKey;
extern NSString *const kPAPPushPayloadActivityFollowKey;

extern NSString *const kPAPPushPayloadFromUserObjectIdKey;
extern NSString *const kPAPPushPayloadToUserObjectIdKey;
extern NSString *const kPAPPushPayloadPostDateObjectIdKey;





extern NSUInteger const kPAWWallPostMaximumCharacterCount;

extern NSUInteger const kPAWWallPostsSearch; // query limit for pins and tableviewcells

// Parse API key constants:
//extern NSString * const kPAWParsePostsClassKey;
extern NSString * const kPAWParseUserKey;
extern NSString * const kPAWParseUsernameKey;
extern NSString * const kPAWParseTextKey;
extern NSString * const kPAWParseLocationKey;


//UI strings:
extern NSString * const kPAWWallCantViewPost;

//firstTimeInstall
extern NSString *const firstTimeInstallKey;

//類別的存檔路徑
extern NSString *const mainCategoryFile;
extern NSString *const subCategoryFile;

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
extern NSString *const partTimeSubCategoryFile; //1
extern NSString *const buySubCategoryFile;      //2
extern NSString *const sendSubCategoryFile;     //3
extern NSString *const activitySubCategoryFile; //4
extern NSString *const professionalSubCategoryFile; //5

//發案子
extern NSString *const tasksSyncNewFormat;
//案子路徑
extern NSString *const WriteTaskFile;





#pragma mark - Cached PostDate Attributes
// keys
extern NSString *const kPAPPhotoAttributesIsAskedByCurrentUserKey;
extern NSString *const kPAPPhotoAttributesIsReadedByCurrentUserKey;
extern NSString *const kPAPPhotoAttributesLikeCountKey;
extern NSString *const kPAPPhotoAttributesLikersKey;
extern NSString *const kPAPPhotoAttributesCommentCountKey;
extern NSString *const kPAPPhotoAttributesCommentersKey;
extern NSString *const kPAPPhotoAttributesIsLikedByThisPeople;

#pragma mark - Cached Restaurant Attributes
// keys
extern NSString *const kPAPRestaurantAttributesIsFollowedByCurrentUserKey;
extern NSString *const kPAPRestaurantAttributesDateCountKey;
extern NSString *const kPAPRestaurantAttributesDatesKey;
extern NSString *const kPAPRestaurantAttributesMessengerCountKey;
extern NSString *const kPAPRestaurantAttributesMessengersKey;

#pragma mark - Cached User Attributes
// keys
extern NSString *const kPAPUserAttributesPhotoCountKey;
extern NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey;

// Map Needs
extern double const kPAWFeetToMeters;                               // this is an exact value.
extern double const kPAWFeetToMiles;                                // this is an exact value.
extern double const kPAWWallPostMaximumSearchDistance;
extern double const kPAWMetersInAKilometer;                         // this is an exact value.

extern NSUInteger const kPAWMapCarsSearch;

// ***************** Share To Facebook Switch *****************

extern BOOL isFacebookSwitchOn;


extern PFObject *casesConstants;

extern PFObject *myGroupCategoryObject;

extern PFUser *ratingUser;

extern NSNumber *newBadgeValue;

extern NSArray *loveAddress;


extern NSString *const UploadDataNoti;

extern BOOL isFromPostTaskFlow;
extern BOOL hasCenterButton;

// ***************** 用戶的基本資料 ****************************
extern NSUserDefaults *userDefaults;

// ***************** 餐廳的類別 ****************************
extern NSArray *categoriesForRestaurant;


