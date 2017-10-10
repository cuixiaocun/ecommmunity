//
//  RegisteredViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  注册页面

#import <UIKit/UIKit.h>
#import "CYWhetherPhone.h"
@interface RegisteredViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *codeTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UIButton *getCodeButton;
@property (nonatomic,strong) UIButton *selectAgreementButton;
@property (nonatomic,weak) UIButton *registeredButton;//注册按钮
//倒计时
@property (nonatomic,assign) NSInteger secondsCountDownInput;//倒计时总时间
@property (nonatomic,strong) NSTimer *counTDownTimerInput;//定时器


@property (nonatomic,strong) NSDictionary *requestCodeDict;

@end
