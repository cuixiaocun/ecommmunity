//
//  AppDelegate.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"[CYSmallTools getDataStringKey:TOKEN] = %@",[CYSmallTools getDataStringKey:TOKEN]);
    
    //监听电话回调
    [self callResult];
    
    //友盟
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"587438924544cb799700195f"];
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx62b736ca85387e14" appSecret:@"4e3e0002777bba3658b2b1b289b185c5" redirectURL:@"http://mobile.umeng.com/social"];
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105861891"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"03845f317a9840ca367c9457"
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:nil];
    //移除推送提示数量'
    application.applicationIconBadgeNumber = 0;
   
    // apn 内容获取：
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    NSLog(@"remoteNotification = %@",remoteNotification);
    [CYSmallTools saveData:launchOptions withKey:@"hello"];
    
    //页面跳转
    [self PushController];
    
    
    return YES;
}

//跳转页面
- (void) PushController
{
    // Override point for customization after application launch.
    if ([CYSmallTools getDataStringKey:TOKEN].length)//登录
    {
        [CYSmallTools saveDataString:@"0" withKey:@"WetherFirstInput"];//是否第一次进入
        
        NSString *string = [NSString stringWithFormat:@"%@",[CYSmallTools getDataKey:COMDATA]];
        NSLog(@"%@",string);
        if (string.length > 6)//绑定的小区数据
        {
            NSString *string = [NSString stringWithFormat:@"%@",[CYSmallTools getDataKey:@"hello"]];
            if (string.length > 10)//推送
            {
                MessagePlistViewController *MPController = [[MessagePlistViewController alloc] init];
                _navigationController = [[UINavigationController alloc] initWithRootViewController:MPController];
                self.window.rootViewController = _navigationController;
            }
            else
            {
                //创建标签控制器
                UITabBarController *tabbarController = [[UITabBarController alloc] init];
                
//                NSArray *arryaVC = @[@"RootViewController",@"MallViewController",@"CommunityABBSViewController",@"PersonalCenterViewController"];
                //用新的朋友圈测试
                  NSArray *arryaVC = @[@"RootViewController",@"MallViewController",@"CommunityABBSViewController",@"PersonalCenterViewController"];
                NSMutableArray *arrayNav = [[NSMutableArray alloc] initWithCapacity:arryaVC.count];
                for (NSString *str in arryaVC)
                {
                    UIViewController *viewController = [[NSClassFromString(str) alloc] init];
                    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
                    navigation.navigationBar.translucent = NO;
                    navigation.navigationBar.barStyle = UIBarStyleBlackTranslucent;
                    [navigation.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
                    [arrayNav addObject:navigation];
                    if ([str isEqualToString:@"RootViewController"])
                    {
                        navigation.tabBarItem.title = @"首页";
                        navigation.tabBarItem.image = [UIImage imageNamed:@"icon_home-1"];
                        navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_pre-1"];
                    }
                    else if([str isEqualToString:@"MallViewController"])
                    {
                        navigation.tabBarItem.title = @"社区商城";
                        navigation.tabBarItem.image = [UIImage imageNamed:@"icon_shangcheng-1"];
                        //未标题-1_26
                        navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_shangcheng_pre-1"];
                    }
                    else if([str isEqualToString:@"CommunityABBSViewController"])
                    {
                        navigation.tabBarItem.title = @"社区大小事";
                        navigation.tabBarItem.image = [UIImage imageNamed:@"icon_community-1"];
                        //未标题-1_32
                        navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_community_pre-1"];
                    }
                    else if([str isEqualToString:@"PersonalCenterViewController"])
                    {
                        navigation.tabBarItem.title = @"我的";
                        navigation.tabBarItem.image = [UIImage imageNamed:@"icon_me-1"];
                        //未标题-1_32
                        navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_me_pre-1"];
                    }
                    //        navigation.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 30, 30);
                }
                tabbarController.viewControllers = arrayNav;
                //点击之后字体颜色
                [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                tabbarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00];
                self.window.rootViewController = tabbarController;
            }
        }
        else
        {
            CYLoginViewController *rootViewController = [[CYLoginViewController alloc] init];
            _navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
            self.window.rootViewController = _navigationController;
        }
    }
    else
    {
        [CYSmallTools saveDataString:@"1" withKey:@"WetherFirstInput"];//是否第一次进入
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        CYLoginViewController *rootViewController = [[CYLoginViewController alloc] init];
        _navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        self.window.rootViewController = _navigationController;
    }
}
// -- --    - - - - ---------------------------------拨打电话回调函数-- - -  -  -  -- - --   - - - - - ---  -  --- --
- (void) callResult
{
    // 为了避免出现循环引用
    __weak typeof(self) weakSelf = self;
    //
    _callCenter = [[CTCallCenter alloc] init];
    _callCenter.callEventHandler = ^(CTCall* call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected])//挂电话之后
        {
            NSLog(@"Call has been disconnected");
            [weakSelf sendCallPhoneMessage];
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            NSLog(@"Call has just been connected");
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"call is dialing");//开始拨打
        }
        else
        {
            NSLog(@"Nothing is done");
        }
    };
}
//拨打电话使用 -> 通知
- (void) sendCallPhoneMessage
{
    NSNotification *notification = nil;
    notification = [NSNotification notificationWithName:@"callPhoneMessageResult" object:self userInfo:[NSDictionary dictionaryWithObject:@"OK" forKey:@"callPhone"]];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
// -- --    - - - - ---------------------------------Ping++支付-- - -  -  -  -- - --   - - - - - ---  -  --- --
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    NSNotification *notification = nil;
    notification = [NSNotification notificationWithName:@"payResult" object:self userInfo:[NSDictionary dictionaryWithObject:options forKey:@"pay"]];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    return canHandleURL;
}
//IOS8以上
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
//{
//    
//    [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error)
//     {
//         NSLog(@"result = %@",result);
//         //fail
//         //cancel
//         //success
//         // 用通知实现支付的页面跳转
//         //        if ([result isEqualToString:@"success"]) {
//         //            [[NSNotificationCenter defaultCenter] postNotificationName:@"enterSuccessView" object:nil];
//         //            //通知
//         //            [self sendMessage];
//         //        }
//         NSNotification *notification = nil;
//         notification = [NSNotification notificationWithName:@"payResult" object:self userInfo:[NSDictionary dictionaryWithObject:result forKey:@"pay"]];
//         //发送通知
//         [[NSNotificationCenter defaultCenter] postNotification:notification];
//     }];
//    
//    return YES;
//}

//IOS8以下
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //友盟，分享回调
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result)
    {
        // 其他如支付等SDK的回调：ping++回调
        [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error)
         {
             NSNotification *notification = nil;
             notification = [NSNotification notificationWithName:@"payResult" object:self userInfo:[NSDictionary dictionaryWithObject:result forKey:@"pay"]];
             //发送通知
             [[NSNotificationCenter defaultCenter] postNotification:notification];
         }];
        return YES;
    }
    return result;

}
// -- --    - - - - --------------------------------- 推送 -- - -  -  -  -- - --   - - - - - ---  -  --- --
- (void)networkDidReceiveMessage:(NSNotification *)notification//接收自定义消息
{
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
    NSLog(@"content = %@,customizeField1 = %@",content,customizeField1);
    
}
//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *result = [[NSString alloc] initWithData:deviceToken  encoding:NSUTF8StringEncoding];
    NSLog(@"result = %@,deviceToken = %@,deviceToken.length = %d",result,deviceToken,deviceToken.length);
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support  显示本地通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"userInfo = %@",userInfo);
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else
    {
        NSLog(@"本地通知");
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support  点击弹出的通知后走的方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"userInfo = %@",userInfo);
    //表示通过推送点击进入
    [CYSmallTools saveData:userInfo withKey:@"hello"];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else
    {
        NSLog(@"本地通知");
    }
    completionHandler();  // 系统要求执行这个方法
    //跳转页面
    [CYSmallTools saveData:userInfo withKey:@"hello"];
    MessagePlistViewController *MPController = [[MessagePlistViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:MPController];
    [_navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
    self.window.rootViewController = _navigationController;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"userInfo = %@",userInfo);
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{    
    NSLog(@"userInfo = %@",userInfo);
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    application.applicationIconBadgeNumber = 0;
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
