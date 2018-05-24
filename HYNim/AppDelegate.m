//
//  AppDelegate.m
//  HYNim
//
//  Created by wangJS on 2018/5/23.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "NIMKit.h"


//#import "NTESLoginViewController.h"
//#import "UIView+Toast.h"
//#import "NTESService.h"
//#import "NTESNotificationCenter.h"
//#import "NTESLogManager.h"
//#import "NTESDemoConfig.h"
//#import "NTESSessionUtil.h"
//#import "NTESMainTabController.h"
//#import "NTESLoginManager.h"
//#import "NTESCustomAttachmentDecoder.h"
//#import "NTESClientUtil.h"
//#import "NTESNotificationCenter.h"
//#import "NTESSDKConfigDelegate.h"
//#import "NTESCellLayoutConfig.h"
//#import "NTESSubscribeManager.h"
//#import "NTESRedPacketManager.h"
//#import "NTESBundleSetting.h"
//#import <UserNotifications/UserNotifications.h>
//#import <Fabric/Fabric.h>
//#import <Crashlytics/Crashlytics.h>

NSString *NTESNotificationLogout = @"NTESNotificationLogout";

@interface AppDelegate ()<NIMLoginManagerDelegate>

//@property (nonatomic,strong) NTESSDKConfigDelegate *sdkConfigDelegate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    
    ViewController *viewCotr = [[ViewController alloc] init];
    self.window.rootViewController = viewCotr;
    
    //初始化nimSDK配置
    [self setupNimSDK];
    [self.window makeKeyAndVisible];

    
    return YES;
}
//初始化nimSDK配置
- (void)setupNimSDK {
    
//    self.sdkConfigDelegate = [[NTESSDKConfigDelegate alloc] init];
//    [[NIMSDKConfig sharedConfig] setDelegate:self.sdkConfigDelegate];
    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
    
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:HY_NIM_APPKEY];
//    //注册
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    //是否正在使用demo
    BOOL isUsingDemoAppKey = [[NIMSDK sharedSDK] isUsingDemoAppKey];
    [[NIMSDKConfig sharedConfig] setTeamReceiptEnabled:isUsingDemoAppKey];
    
}
- (void)commonInitListenEvents {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logout:)
                                                 name:NTESNotificationLogout
                                               object:nil];
    
    [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
}
#pragma mark - 注销
-(void)logout:(NSNotification *)note {
    [self doLogout];
}
- (void)doLogout
{
//    [[NTESLoginManager sharedManager] setCurrentLoginData:nil];
//    [[NTESServiceManager sharedManager] destory];
//    [self setupLoginViewController];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
