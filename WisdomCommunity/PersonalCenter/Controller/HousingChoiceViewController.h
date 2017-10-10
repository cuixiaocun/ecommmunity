//
//  HousingChoiceViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  添加房屋

#import <UIKit/UIKit.h>

@interface HousingChoiceViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *selectButton;

@property (nonatomic,strong) UITableView *SelectComTableView;//选择小区
@property (nonatomic,strong) UITextField *buildNumberTextField;//楼号
@property (nonatomic,strong) UITextField *unitNumberTextField;//单元
@property (nonatomic,strong) UITextField *houseNumberTextField;//门牌号

@property (nonatomic,strong) NSArray *communityDataArray;//小区数据

@property (nonatomic,strong) NSString *selectHouseComId;//选择的小区id
@property (nonatomic,strong) NSDictionary *selectHouseComDict;
@property (nonatomic,strong) NSString *InputController;//判断那个页面进入

@property (nonatomic,strong) NSDictionary *HouseDict;//修改的小区数据

@end
