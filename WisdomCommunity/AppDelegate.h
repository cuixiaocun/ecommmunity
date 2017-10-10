//
//  AppDelegate.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLoginViewController.h"
#import "MessagePlistViewController.h"
#import <CoreTelephony/CTCall.h>//拨打电话
#import <CoreTelephony/CTCallCenter.h>
#import <UMSocialCore/UMSocialCore.h>


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UINavigationController *navigationController;

@property (nonatomic,strong) CTCallCenter *callCenter;//拨打电话使用


@end

