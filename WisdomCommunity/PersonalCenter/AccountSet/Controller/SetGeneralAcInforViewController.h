//
//  SetGeneralAcInforViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  修改用户名

#import <UIKit/UIKit.h>

@interface SetGeneralAcInforViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *accountTextField;

@property (nonatomic,strong) NSString *promptString;//提示-页面操作标识



@end
