//
//  RegisteredViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RegisteredViewController.h"

@interface RegisteredViewController ()

@end

@implementation RegisteredViewController

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
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.delegate = self;
    _phoneTextField.textColor = [UIColor blackColor];
    _phoneTextField.backgroundColor = [UIColor clearColor];
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_phoneTextField];
    _phoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    _phoneTextField.frame =CGRectMake(phoneImmage.right+10/375.0*CYScreanW, showImmage.top-88*CXCWidth,460*CXCWidth , 87*CXCWidth);

    
    //获取验证码
    _getCodeButton = [[UIButton alloc] init];
    [_getCodeButton setBackgroundColor:BGColor];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCodeButton.titleLabel.textColor=TextGroColor;
    _getCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    [_getCodeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    _getCodeButton.layer.cornerRadius =4*CXCWidth;
    [_getCodeButton.layer setBorderWidth:1.0f]  ;

    [_getCodeButton addTarget:self action:@selector(getCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    _getCodeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [self.view addSubview:_getCodeButton];
    [_getCodeButton setFrame:CGRectMake(520*CXCWidth, 100*CXCWidth, 190*CXCWidth,60*CXCWidth)];

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
    _codeTextField = [[UITextField alloc] init];
    _codeTextField.delegate = self;
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.textColor = [UIColor blackColor];
    _codeTextField.backgroundColor = [UIColor clearColor];
    _codeTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_codeTextField];
    [_codeTextField setFrame:CGRectMake(codeImmage2.right+20*CXCWidth,showImmage.bottom+ 30*CXCWidth, 560*CXCWidth, 89*CXCWidth)];
    
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
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.delegate = self;
    _pwdTextField.placeholder = @"6-12位,建议数字加字母组成";
    _pwdTextField.textColor = [UIColor blackColor];
    _pwdTextField.backgroundColor = [UIColor clearColor];
    _pwdTextField.textAlignment = NSTextAlignmentLeft;
    _pwdTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTextField];
    _pwdTextField.frame =CGRectMake(suoImmage.right+20*CXCWidth,codeImmage.bottom+30*CXCWidth, 550*CXCWidth, 88*CXCWidth);
    
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
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //选择阅读协议按钮
    _selectAgreementButton = [[UIButton alloc] init];
    [_selectAgreementButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
    [_selectAgreementButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
    [self.view addSubview:_selectAgreementButton];
    [_selectAgreementButton addTarget:self action:@selector(agreementOnClickButton:) forControlEvents:UIControlEventTouchUpInside];
    _selectAgreementButton.backgroundColor = [UIColor clearColor];
    [_selectAgreementButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.width.mas_equalTo(CYScreanW * 0.045);
         make.top.equalTo(pwdImmage.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.03);
     }];
    _selectAgreementButton.selected = YES;
    //协议
    UIButton *agreementButton = [[UIButton alloc] init];
    [agreementButton setTitle:@"同意《瀧璟智慧社区使用条款与隐私规则》" forState:UIControlStateNormal];
    agreementButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    agreementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左
    [agreementButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:agreementButton];
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(_selectAgreementButton.mas_right).offset(CYScreanW * 0.02);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(pwdImmage.mas_bottom).offset((CYScreanW * 0.02));
         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
     }];
    NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:agreementButton.titleLabel.text];
    [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.255 green:0.557 blue:0.910 alpha:1.00] range:NSMakeRange(2,17)];
    //        [sendMessageString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15] range:NSMakeRange(0,2)];
    agreementButton.titleLabel.attributedText = sendMessageString;
    //注册
    UIButton *registeredButton = [[UIButton alloc] init];
    [registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    [registeredButton setTitle:@"注册" forState:UIControlStateNormal];
    registeredButton.layer.cornerRadius = 5;
    registeredButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [registeredButton addTarget:self action:@selector(getRegisteredRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeredButton];
    [registeredButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.right.equalTo(self.view.mas_right).offset(- CYScreanW * 0.05);
         make.top.equalTo(_selectAgreementButton.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
    self.registeredButton = registeredButton;
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
    [_pwdTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码
- (void) getCodeButton:(UIButton *)sender
{
    //是否是手机号
    if (![CYWhetherPhone isValidPhone:self.phoneTextField.text])
    {
        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
        [self dealWithButton];
        return;
    }
    else
    {
        //禁止点击
        _getCodeButton.userInteractionEnabled = NO;
        //申请验证码
        [self getRegisteredCodeRequest];
        //设置倒计时总时长
        _secondsCountDownInput = 60;
        //开始倒计时
        _counTDownTimerInput = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethodInput) userInfo:nil repeats:YES];
        _getCodeButton.titleLabel.textColor =[UIColor redColor];
        [_getCodeButton setTitleColor:NavColor forState:UIControlStateNormal];
        //显示倒计时
        [_getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒",_secondsCountDownInput] forState:UIControlStateNormal];
    }
}
//计时器函数
- (void) timeFireMethodInput
{

    //倒计时-1
    if (_secondsCountDownInput > 0)
    {
        _secondsCountDownInput --;
    }
    //修改倒计时标签现实内容
    [_getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒",_secondsCountDownInput] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDownInput == 0)
    {
        [_counTDownTimerInput invalidate];

        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _getCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;

        _getCodeButton.userInteractionEnabled = YES;//时间到之后打开交互
    }
}


- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
    
    self.navigationItem.title = @"注册";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     
    
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController.navigationBar setHidden:NO];
}
//将要消失
- (void) viewWillDisappear:(BOOL)animated
{
    [self dealWithButton];
}
-(void)rightBtnPressed:(UIButton *)btn
{
    
    btn.selected =!btn.selected;
    if (btn.selected==YES) {
        _pwdTextField.secureTextEntry =NO;
        
    }else
    {
        _pwdTextField.secureTextEntry =YES;

    }

}
//取消定时器
- (void) dealWithButton
{
    [_counTDownTimerInput invalidate];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;

    _getCodeButton.userInteractionEnabled = YES;//时间到之后打开交互
}
//是否遵循协议按钮
- (void) agreementOnClickButton:(UIButton *)sender
{
    if (_selectAgreementButton.selected == YES)
    {
        _selectAgreementButton.selected = NO;
        
        self.registeredButton.userInteractionEnabled = NO;
        [_registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    }
    else
    {
        _selectAgreementButton.selected = YES;
        
        self.registeredButton.userInteractionEnabled = YES;
        [self.registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
    }
}
//获取验证码
- (void) getRegisteredCodeRequest
{
    
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.phoneTextField.text];
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/sendRCode",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         self.requestCodeDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", self.requestCodeDict);
         if ([[self.requestCodeDict objectForKey:@"success"] integerValue] == 1)
         {
             [MBProgressHUD showError:@"发送成功" ToView:self.view];
         }
         else
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         [self dealWithButton];
         NSLog(@"请求失败:%@", error.description);
     }];
}
//注册
- (void) getRegisteredRequest
{

    if (_selectAgreementButton.selected == NO) {
        [ProgressHUD showError:@"您尚未同意协议"];
        return;
    }
    NSLog(@"[self.requestCodeDict objectForKey:@returnValue] = %@,self.codeTextField.text = %ld",[self.requestCodeDict objectForKey:@"returnValue"],self.codeTextField.text.length);
    if (![CYWhetherPhone judgePassword:self.pwdTextField.text] || self.pwdTextField.text.length < 6 || self.pwdTextField.text.length > 12)
    {
        [MBProgressHUD showError:@"密码格式不正确" ToView:self.view];
        return;
    }
    [MBProgressHUD showLoadToView:self.view];
    NSLog(@"self.phoneTextField.text = %@,self.pwdTextField.text = %@",self.phoneTextField.text,self.pwdTextField.text);
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.phoneTextField.text];//
    parames[@"password"]  =  [NSString stringWithFormat:@"%@",self.pwdTextField.text];
    parames[@"code"] = [NSString stringWithFormat:@"%@",self.codeTextField.text];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/regist",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSLog(@"请求成功");
             [MBProgressHUD showError:@"注册成功" ToView:self.navigationController.view];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
     }];

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if(textField ==_phoneTextField)
    {
    
        
        if (string.length == 0)
        {
            _getCodeButton.titleLabel.textColor=TextGroColor;
            
            _getCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
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
            _getCodeButton.titleLabel.textColor=NavColor ;
            _getCodeButton.layer.borderColor = NavColor.CGColor;
            
        }else
        {
            
            _getCodeButton.titleLabel.textColor=TextGroColor;
            _getCodeButton.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
            return YES;
            
            
        }
        
 
    }else if(textField ==_codeTextField)

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
