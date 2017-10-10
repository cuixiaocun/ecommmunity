//
//  ForgetPwdViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()
{
    UIScrollView *bgScrollView;//背景scrollview
    
    
}
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSInteger tokenLength = [CYSmallTools getDataStringKey:TOKEN].length;//登录
    //账号边框
    UIImageView *showImmage = [[UIImageView alloc] initWithFrame:CGRectMake(40*CXCWidth,78*CXCWidth +89*CXCWidth,450*CXCWidth , 1*CXCWidth)];
    showImmage.backgroundColor =BGColor;
    [self.view addSubview:showImmage];
    //账号图标
    UIImageView *phoneImmage = [[UIImageView alloc] init];
    phoneImmage.image = [UIImage imageNamed:@"1user"];
    [self.view addSubview:phoneImmage];
    phoneImmage.frame =CGRectMake(24.0/375*CYScreanW,78*CXCWidth+30*CXCWidth,13.0*CYScreanW/375.0 ,20*CYScreanW/375.0);
    //账号输入框
    self.phoneFPTextField = [[UITextField alloc] init];
    self.phoneFPTextField.placeholder = @"请输入手机号";
    self.phoneFPTextField.delegate = self;
    self.phoneFPTextField.textColor = [UIColor blackColor];
    self.phoneFPTextField.backgroundColor = [UIColor clearColor];
    self.phoneFPTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.phoneFPTextField];
    self.phoneFPTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.phoneFPTextField.frame =CGRectMake(phoneImmage.right+10/375.0*CYScreanW, showImmage.top-88*CXCWidth,460*CXCWidth , 87*CXCWidth);
    
    
    //获取验证码
    
    _getFPCodeButton = [[UIButton alloc] init];
    [_getFPCodeButton setBackgroundColor:BGColor];
    [_getFPCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getFPCodeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _getFPCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;

    
    _getFPCodeButton.layer.cornerRadius =4*CXCWidth;
    [_getFPCodeButton.layer setBorderWidth:1.0f]  ;
    
    [_getFPCodeButton addTarget:self action:@selector(getFPCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    _getFPCodeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [self.view addSubview:_getFPCodeButton];
    [_getFPCodeButton setFrame:CGRectMake(520*CXCWidth, 100*CXCWidth, 190*CXCWidth,60*CXCWidth)];
    
    //验证码边框
    UIImageView *codeImmage = [[UIImageView alloc] init];
    codeImmage.backgroundColor =BGColor;
    [self.view addSubview:codeImmage];
    codeImmage.frame =CGRectMake(40*CXCWidth,showImmage.bottom+120*CXCWidth,670*CXCWidth , CXCWidth);
    
    
    
    //验证码图标
    UIImageView *codeImmage2 = [[UIImageView alloc] init];
    codeImmage2.image = [UIImage imageNamed:@"icon_yanzhengma"];
    [self.view addSubview:codeImmage2];
    codeImmage2.frame =CGRectMake(40*CXCWidth, showImmage.bottom+58*CXCWidth, 30*CXCWidth, 48*CXCWidth) ;
    //验证码输入框
    
    _codeFPTextField = [[UITextField alloc] init];
    _codeFPTextField.delegate = self;
    _codeFPTextField.placeholder = @"请输入验证码";
    _codeFPTextField.textColor = [UIColor blackColor];
    _codeFPTextField.backgroundColor = [UIColor clearColor];
    _codeFPTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_codeFPTextField];
    [_codeFPTextField setFrame:CGRectMake(codeImmage2.right+20*CXCWidth,showImmage.bottom+ 30*CXCWidth, 560*CXCWidth, 89*CXCWidth)];
    
    //密码管理
    UIImageView *pwdImmage = [[UIImageView alloc] init];
    pwdImmage.backgroundColor =BGColor;
    [self.view addSubview:pwdImmage];
    pwdImmage.frame =CGRectMake(40*CXCWidth, codeImmage.bottom+120*CXCWidth, 670*CXCWidth, CXCWidth);
    //密码图标
    UIImageView *suoImmage = [[UIImageView alloc] init];
    suoImmage.image = [UIImage imageNamed:@"1password"];
    [self.view addSubview:suoImmage];
    suoImmage.frame =CGRectMake(40*CXCWidth, codeImmage.bottom+58*CXCWidth, 36*CXCWidth, 47*CXCWidth);
    
    //密码输入框
    
    _pwdFPTextField = [[UITextField alloc] init];
    _pwdFPTextField.delegate = self;
    _pwdFPTextField.placeholder = @"6-12位,建议数字加字母组成";
    _pwdFPTextField.textColor = [UIColor blackColor];
    _pwdFPTextField.backgroundColor = [UIColor clearColor];
    _pwdFPTextField.textAlignment = NSTextAlignmentLeft;
    _pwdFPTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdFPTextField];
    _pwdFPTextField.frame =CGRectMake(suoImmage.right+20*CXCWidth,codeImmage.bottom+30*CXCWidth, 550*CXCWidth, 88*CXCWidth);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setFrame:CGRectMake(640*CXCWidth, codeImmage.bottom, 100*CXCWidth, 100*CXCWidth)];
    [btn setImage:[UIImage imageNamed:@"icon_xianshi"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_yincang"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(8*CXCWidth, 24*CXCWidth,4*CXCWidth, 0)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //                [btn setImage:[UIImage imageNamed:@"navigation_jiantou"] forState:UIControlStateNormal];
    //            [btn addSubview:jiantouImg];
    [btn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    UIButton *registeredButton = [[UIButton alloc] init];
    [registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    [registeredButton setTitle:@"确定" forState:UIControlStateNormal];
    registeredButton.layer.cornerRadius = 5;
    registeredButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [registeredButton addTarget:self action:@selector(ModifyPasswordRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeredButton];
    [registeredButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(_pwdFPTextField.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
}
-(void)rightBtnPressed:(UIButton *)btn
{
    
    btn.selected =!btn.selected;
    if (btn.selected==YES) {
        _pwdFPTextField.secureTextEntry =NO;
        
    }else
    {
        _pwdFPTextField.secureTextEntry =YES;
        
    }
    
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_pwdFPTextField resignFirstResponder];
    [_codeFPTextField resignFirstResponder];
    [_phoneFPTextField resignFirstResponder];
    [_confirmPwdFPTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码
- (void) getFPCodeButton:(UIButton *)sender
{
    //是否是手机号
    if (![CYWhetherPhone isValidPhone:self.phoneFPTextField.text])
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
        _getFPCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;

        [self dealForgetWithButton];
        return;
    }
    else
    {
        //禁止点击
        _getFPCodeButton.userInteractionEnabled = NO;
        //设置倒计时总时长
        _countDownInput = 60;
        //获取验证码
        [self RequestVerificationCode];
        //开始倒计时
        _downFPTimerInput = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFPFireMethodInput) userInfo:nil repeats:YES];
        //显示倒计时
        [_getFPCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",_countDownInput] forState:UIControlStateNormal];
    }
    
}
//计时器函数
- (void) timeFPFireMethodInput
{
    //倒计时-1
    if (_countDownInput > 0)
    {
        _countDownInput --;
    }
    //修改倒计时标签现实内容
    [_getFPCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",_countDownInput] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_countDownInput == 0)
    {
        [self dealForgetWithButton];
    }
}
//取消定时器
- (void) dealForgetWithButton
{
    [_downFPTimerInput invalidate];
    [_getFPCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getFPCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;

    _getFPCodeButton.userInteractionEnabled = YES;//时间到之后打开交互
}
//确定
- (void) registeredFPButton:(UIButton *)sender
{
    //是否是手机号
    if ([CYWhetherPhone isValidPhone:self.phoneFPTextField.text])
    {
        [self ModifyPasswordRequest];
    }
    else
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
    
    self.navigationItem.title = @"设置密码";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController.navigationBar setHidden:NO];
}
//将要消失
- (void) viewWillDisappear:(BOOL)animated
{
    [self dealForgetWithButton];
}
//获取验证码
- (void) RequestVerificationCode
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/sendRCode",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.phoneFPTextField.text];
    NSLog(@"parames = %@",parames);

    [self requestForgetWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"获取验证码请求成功JSON:%@", dict);
        if ([[dict objectForKey:@"success"] integerValue] == 1)
        {
            [MBProgressHUD showError:@"发送成功" ToView:self.view];
        }
        else
        {
            [self dealForgetWithButton];
            [MBProgressHUD showError:@"加载出错" ToView:self.view];
        }
    }];
}
///重置密码
- (void) ModifyPasswordRequest
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/resetPassword",POSTREQUESTURL];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  self.phoneFPTextField.text;//
    parames[@"password"]  =  self.pwdFPTextField.text;
    parames[@"code"]      =  self.codeFPTextField.text;
    NSLog(@"parames = %@",parames);
    [self requestForgetWithUrl:requestUrl parames:parames Success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"重置密码请求成功JSON:%@", dict);
        if ([[dict objectForKey:@"success"] integerValue] == 1)
          {
            [MBProgressHUD showError:@"重置密码成功" ToView:self.navigationController.view];
            [self.navigationController popViewControllerAnimated:YES];
          }else{
                    [self dealForgetWithButton];
                    [MBProgressHUD showError:[dict objectForKey:@"error"] ToView:self.view];
                }
            }];
}
//数据请求
- (void)requestForgetWithUrl:(NSString *)requestUrl parames:(NSMutableDictionary *)parames Success:(void(^)(id responseObject))success
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSLog(@"requestUrl = %@",requestUrl);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField ==_phoneFPTextField)
    {
        
        
        if (string.length == 0)
        {
            _getFPCodeButton.titleLabel.textColor=TextGroColor;
            
            _getFPCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
            return YES;
            
        }
        
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength >= 12) {
            [textField resignFirstResponder];
            return NO;
            
            
            
        }else if(existedLength-selectedLength+replaceLength==11)
        {
            _getFPCodeButton.titleLabel.textColor=NavColor ;
            _getFPCodeButton.layer.borderColor = NavColor.CGColor;
            
        }else
        {
            
            _getFPCodeButton.titleLabel.textColor=TextGroColor;
            _getFPCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
            return YES;
            
            
        }
        
        
    }else if(textField ==_codeFPTextField)
        
    {
        
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength >= 7) {
            [textField resignFirstResponder];
            return NO;
            
            
            
        }
        
        
        
        
    }else
    {
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength >= 13) {
            [textField resignFirstResponder];
            return NO;
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    return YES;
    
}


@end
