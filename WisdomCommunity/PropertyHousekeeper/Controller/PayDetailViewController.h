//
//  PayDetailViewController.h
//  WisdomCommunity
//
//  Created by Admin on 2017/5/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProPayTableViewCell.h"
#import "ProPayCConfirmViewController.h"

@interface PayDetailViewController : UIViewController

@property (nonatomic,strong) UITableView *payDetailTableview;//年份展示

@property (nonatomic,strong) ProPayTableViewCell * payCell;
@property (nonatomic,strong) NSMutableArray *yuanArray;//缴费模型

@property (nonatomic,strong) NSMutableArray *proPayModelArray;//缴费模型
@property (nonatomic,strong) NSString *proPay;//小区
@property (nonatomic,strong) NSString *house;//房间
//@property (nonatomic,strong) NSString *proPay;//小区

@property (nonatomic,strong) UIButton *complaintsButton;//缴费按钮
@property (nonatomic,strong) NSMutableArray *selectPayMonthArray;//选择缴费月份总数据

@property (nonatomic,strong) ProPayCConfirmViewController *ppccController;


@end
