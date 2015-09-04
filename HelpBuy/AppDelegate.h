//
//  AppDelegate.h
//  HelpBuy
//
//  Created by 駿逸 陳 on 2015/8/9.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (AppDelegate *)sharedDelegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//轉場至首頁
- (void)presentToHomePage;

//轉場至登入畫面
- (void)presentToLoginPage;

//轉場至發布畫面
- (void)presentToPostPage;

//登出
- (void)logOut;

//取得現在Tabbar的badge數量
- (NSNumber *)getTabbarBadgeNumber;

//Tabbar的追蹤 badge +1
- (void)addTabBarBadge:(NSNumber *)number;

//清空Tabbar的數值
- (void)deleteTabBarBadge;
@end

