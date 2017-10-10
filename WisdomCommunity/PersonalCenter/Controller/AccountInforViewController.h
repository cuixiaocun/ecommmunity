//
//  AccountInforViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  账号信息

#import <UIKit/UIKit.h>
#import "UIImage+wiRoundedRectImage.h"
#import "SeeSignInRecordViewController.h"//签到信
#import "SetGeneralAcInforViewController.h"
#import "SelectSexViewController.h"
#import "RealNameViewController.h"
#import "SetHeadViewController.h"
#import "AddressManagementViewController.h"
#import "CYLoginViewController.h"
@interface AccountInforViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *accountInforTableView;//账号信息tableview

@property (nonatomic,strong) NSArray *promptAccountArray;//信息说明
@property (nonatomic,strong) NSArray *dataAccountArray;//账户信息

@property (nonatomic,strong) UIImageView *headImage;//头像
@property (nonatomic,strong) UIButton *exitButton;

@end
