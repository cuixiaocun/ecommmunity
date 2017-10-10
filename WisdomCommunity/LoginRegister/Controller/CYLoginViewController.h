//
//  CYLoginViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  登录页面

#import <UIKit/UIKit.h>
#import "RegisteredViewController.h"
#import "ForgetPwdViewController.h"
#import "HousingChoiceViewController.h"
#import "PeripheralServicesViewController.h"
#import "ZLCGuidePageView.h"//引导页
// 引入JPush功能所需头文件
#import "JPUSHService.h"
@interface CYLoginViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (nonatomic,strong) UITextField *accountTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UITableView *nameTableView;

@end
