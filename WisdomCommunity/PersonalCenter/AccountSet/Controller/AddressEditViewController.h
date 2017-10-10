//
//  AddressEditViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//  添加收货地址

#import <UIKit/UIKit.h>

@interface AddressEditViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *EditAddressTableView;//编辑view
@property (nonatomic,strong) UIButton *SelectComButton;//选择小区
@property (nonatomic,strong) UITextField *detailsAddressTField;//详细收货地址
@property (nonatomic,strong) UITextField *NameTField;//收货人姓名
@property (nonatomic,strong) UITextField *PhoneTField;//手机号
@property (nonatomic,strong) UIButton *defaultButton;

@property (nonatomic,strong) UITableView *SelectComTableView;//
@property (nonatomic,strong) NSArray *SelectComArray;//小区数据
@property (nonatomic,strong) NSString *selectAdComId;//选择的小区id



@end
