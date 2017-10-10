//
//  ProPayCostController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//  物业缴费主页

#import <UIKit/UIKit.h>
#import "ProPayTableViewCell.h"
#import "ProPayCConfirmViewController.h"
@interface ProPayCostController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,OnClickProPayDelegate>


@property (nonatomic,strong) UITableView *PeripheralSTableView;//首页展示tableview
@property (nonatomic,strong) UITableView *ProComTableView;//房屋展示
@property (nonatomic,strong) UITableView *YearTableView;//年份展示
@property (nonatomic,strong) UITableView *ChoosePAddTableView;//选择缴纳地址
@property (nonatomic,strong) UIView *maskView;//蒙版

//@property (nonatomic,strong) UITextField *phonePCTextField;
@property (nonatomic,strong) UIButton *timeButton;//年份
@property (nonatomic,strong) UIButton *proComButton;//物业公司
@property (nonatomic,strong) UIButton *complaintsButton;//缴费按钮
//未有信息提示
@property (nonatomic,weak) UIImageView *showImmage;
@property (nonatomic,weak) UILabel *promptLabel;
//显示选择的小区
@property (nonatomic,strong) UILabel *showAddressLabel;


@property (nonatomic,strong) NSMutableArray *proPayModelArray;//缴费模型
@property (nonatomic,strong) NSArray *proPayDatalArray;//缴费数据
@property (nonatomic,strong) NSMutableArray *selectPayMonthArray;//选择缴费月份总数据
@property (nonatomic,strong) NSMutableArray *showYearArray;//显示的年份
@property (nonatomic,strong) NSArray *ProComArray;//物业公司数组信息
@property (nonatomic,strong) NSMutableArray *choosePAddArray;//选择缴费地址


//数据请求
@property (nonatomic,strong) NSString *selectProComId;//选择物业公司的id
@property (nonatomic,strong) NSString *selectYearData;//选择的年份
//生成订单数据
@property (nonatomic,strong) NSString *selectBuild;//房号
//防止查询之后再次切换物业公司和查询年份
@property (nonatomic,strong) NSString *yearString;//缴费年份
@property (nonatomic,strong) NSString *connunityName;//小区名字
@property (nonatomic,strong) NSString *communityId;//小区id


@property (nonatomic,strong) ProPayTableViewCell * payCell;
@property (nonatomic,strong) ProPayCConfirmViewController *ppccController;


//@property (nonatomic,strong) 

@end
