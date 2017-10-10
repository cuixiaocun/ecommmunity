//
//  AddressUpdateViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/24.
//  Copyright © 2016年 bridge. All rights reserved.
//  更新收货地址

#import <UIKit/UIKit.h>

@interface AddressUpdateViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) UITableView *EditAddressTableView;//编辑view
@property (nonatomic,strong) UIButton *SelectComButton;//选择小区
@property (nonatomic,strong) UITextView *detailsAddressTView;//详细收货地址
@property (nonatomic,strong) UITextField *NameTField;//收货人姓名
@property (nonatomic,strong) UITextField *PhoneTField;//手机号
@property (nonatomic,strong) UIButton *defaultButton;




@property (nonatomic,strong) NSDictionary *ReceiveAddressDict;//收货地址数据


@end
