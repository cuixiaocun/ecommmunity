//
//  ForgetPwdViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  忘记密码

#import <UIKit/UIKit.h>

@interface ForgetPwdViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *phoneFPTextField;
@property (nonatomic,strong) UITextField *codeFPTextField;
@property (nonatomic,strong) UITextField *pwdFPTextField;
@property (nonatomic,strong) UITextField *confirmPwdFPTextField;
@property (nonatomic,strong) UIButton *getFPCodeButton;

//倒计时
@property (nonatomic,assign) NSInteger countDownInput;//倒计时总时间
@property (nonatomic,strong) NSTimer *downFPTimerInput;//定时器

@end
