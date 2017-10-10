//
//  AddressManagement ViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//  地址管理

#import <UIKit/UIKit.h>
#import "AddressMangeTableViewCell.h"
#import "AddressEditViewController.h"
#import "AddressUpdateViewController.h"
#import "AccountInforViewController.h"
@interface AddressManagementViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,OnClickEditDelegate>


@property (nonatomic,strong) UITableView *AddressTableView;//

@property (nonatomic,strong) NSMutableArray *AllAllAddressArray;//收货地址总数据
@property (nonatomic,strong) NSMutableArray *AllAddressArray;//收货地址模型

@property (nonatomic,strong) NSDictionary *selectAddressDict;//选择的收货地址

@property (nonatomic,strong) AddressMangeTableViewCell *cell;

@end
