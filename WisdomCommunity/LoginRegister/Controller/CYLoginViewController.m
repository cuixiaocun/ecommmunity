//
//  CYLoginViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CYLoginViewController.h"
#import "LoginCell.h"
@interface CYLoginViewController ()
{
    NSArray*arrOfName;
    BOOL                  isbool;
    NSMutableArray      * _searchResultArray;
    LoginCell *cell;

}
@end

@implementation CYLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isbool= NO;

    self.view.backgroundColor = [UIColor colorWithRed:78/255.0 green:142/255.0 blue:232/255.0 alpha:1];
    //是否第一次进入
    if ([[CYSmallTools getDataStringKey:@"WetherFirstInput"] isEqualToString:@"1"]) {
        [self YinDaoPage];
    };
    [self initLoginContrllers];
   
    

    
}
- (void) YinDaoPage
{
    //引导页图片数组
    NSArray *images =  @[[UIImage imageNamed:@"引导页-01_1242_2208"],[UIImage imageNamed:@"引导页-02_1242_2208"],[UIImage imageNamed:@"引导页-03_1242_2208"],[UIImage imageNamed:@"引导页-04_1242_2208"]];
    //创建引导页视图
    ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH) WithImages:images];
    [self.navigationController.view addSubview:pageView];
}
//初始化页面
- (void) initLoginContrllers
{
    
    //登录图标
    UIImageView *headImmage = [[UIImageView alloc] initWithFrame:CGRectMake(142.5/375*CYScreanW,60.0/375*CYScreanW,  90.0/375*CYScreanW, 90.0/375*CYScreanW)];
    headImmage.image = [UIImage imageNamed:@"icon_logo_withbg"];
    [self.view addSubview:headImmage];
    //账号边框
    UIImageView *showImmage = [[UIImageView alloc] init];
    showImmage.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:showImmage];
    showImmage.frame =CGRectMake(24.0/375*CYScreanW,headImmage.bottom+55.0/375*CYScreanW , 335.0/375*CYScreanW, 1);
    //账号图标
    UIImageView *phoneImmage = [[UIImageView alloc] init];
    phoneImmage.image = [UIImage imageNamed:@"user"];
    [self.view addSubview:phoneImmage];
    phoneImmage.frame =CGRectMake(24.0/375*CYScreanW, headImmage.bottom+17/375.0*CYScreanW,13.0*CYScreanW/375.0 ,20*CYScreanW/375.0);
    
    //账号输入框
    _accountTextField = [[UITextField alloc] init];
//    _accountTextField.placeholder = @"请输入手机号";
    _accountTextField.delegate = self;
//    _accountTextField.keyboardType =UIKeyboardTypeNumberPad;
    _accountTextField.textColor = [UIColor whiteColor];
    _accountTextField.backgroundColor = [UIColor clearColor];
    _accountTextField.textAlignment = NSTextAlignmentLeft;
    _accountTextField.frame =CGRectMake(phoneImmage.right+10/375.0*CYScreanW, showImmage.top-54/375.0*CYScreanW,CYScreanW*290.0/375.0 , CYScreanW*54.0/375.0);
    NSMutableAttributedString * attributedStr =[[NSMutableAttributedString alloc]initWithString:@"请输入手机号"];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,attributedStr.length)];
    
    _accountTextField.attributedPlaceholder = attributedStr;
    [self.view addSubview:_accountTextField];
    arrOfName =[[NSArray alloc]init];
    arrOfName =[CYSmallTools getArrData:@"nameArr"];
    
    
    
    //密码边框
    UIImageView *pwdImmage = [[UIImageView alloc] init];
    pwdImmage.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:pwdImmage];
    pwdImmage.frame =CGRectMake(24.0/375*CYScreanW,showImmage.bottom+55.0/375*CYScreanW , 335.0/375*CYScreanW, 1);

    
    //密码图标
    UIImageView *suoImmage = [[UIImageView alloc] init];
    suoImmage.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:suoImmage];
    suoImmage.frame =CGRectMake(24.0/375*CYScreanW, showImmage.bottom+19/375.0*CYScreanW,13*CYScreanW/375.0 ,18*CYScreanW/375.0);
    
    
    
    //密码输入框
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.delegate = self;
    _pwdTextField.textColor = [UIColor whiteColor];
    _pwdTextField.backgroundColor = [UIColor clearColor];
    _pwdTextField.textAlignment = NSTextAlignmentLeft;
    _pwdTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTextField];
    NSMutableAttributedString * attributedStr1 =[[NSMutableAttributedString alloc]initWithString:@"请输入密码"];
    [attributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,attributedStr1.length)];
    
    _pwdTextField.attributedPlaceholder = attributedStr1;
    _pwdTextField.frame =CGRectMake(phoneImmage.right+10/375.0*CYScreanW, pwdImmage.top-54/375.0*CYScreanW,CYScreanW*290.0/375.0 , CYScreanW*54.0/375.0);

    
    
    
    
    //登录
    UIButton *loginButton = [[UIButton alloc] init];
//    [loginButton setBackgroundImage:[UIImage imageNamed:@"rec_line"] forState:UIControlStateNormal];
    
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [loginButton addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton.layer setBorderWidth:1.0f];
    [loginButton.layer setCornerRadius:3.0];
    loginButton.layer.borderColor = [UIColor whiteColor].CGColor;

    [loginButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(20/375.0*CYScreanW);
         make.right.equalTo(self.view.mas_right).offset(-20/375.0*CYScreanW);
         make.top.equalTo(pwdImmage.mas_bottom).offset( 50.0/375*CYScreanW);
         make.height.mas_equalTo(45.0*CYScreanW/375.0);
     }];
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    //忘记密码
    UIButton *forgetPwdButton = [[UIButton alloc] init];
    forgetPwdButton.backgroundColor = [UIColor clearColor];
    [forgetPwdButton addTarget:self action:@selector(forgetPwdButton:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPwdButton.titleLabel.font = font;
//    forgetPwdButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左
    [self.view addSubview:forgetPwdButton];
    
    forgetPwdButton.frame =CGRectMake(40*CXCWidth,pwdImmage.bottom+200*CXCWidth , 175*CXCWidth, 50*CXCWidth );
    
    _nameTableView =[[UITableView alloc]initWithFrame:CGRectMake(_pwdTextField.left, _accountTextField.bottom,CYScreanW*290.0/375.0 , arrOfName.count*CXCWidth*80)];
    self.nameTableView.delegate = self;
    self.nameTableView.dataSource = self;
    self.nameTableView.showsVerticalScrollIndicator = NO;
    self.nameTableView.backgroundColor = [UIColor whiteColor];
//    self.nameTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.nameTableView];
    
    _nameTableView.hidden =YES;

    
//    [forgetPwdButton mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.1);
//         make.width.mas_equalTo(CYScreanW * 0.3);
//         make.top.equalTo(loginButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
    //    NSString *string = @"忘记密码?";
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:forgetPwdButton.titleLabel.text];
//    NSRange strRange = {0,[str length]};
//    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
//    [forgetPwdButton setAttributedTitle:str forState:UIControlStateNormal];
    //注册
    UIButton *registeredPwdButton = [[UIButton alloc] init];
    registeredPwdButton.backgroundColor = [UIColor clearColor];
    [registeredPwdButton setTitle:@"注册账号" forState:UIControlStateNormal];
    [registeredPwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registeredPwdButton.titleLabel.font = font;
    [registeredPwdButton addTarget:self action:@selector(registeredButton:) forControlEvents:UIControlEventTouchUpInside];
    registeredPwdButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//居左
    [self.view addSubview:registeredPwdButton];
    registeredPwdButton.frame =CGRectMake(500*CXCWidth,pwdImmage.bottom+200*CXCWidth , 210*CXCWidth, 50*CXCWidth );

//    [registeredPwdButton mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.1);
//         make.width.mas_equalTo(CYScreanW * 0.6);
//         make.top.equalTo(loginButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
//         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
//     }];
//    
    
    
    
    //    NSString *string = @"忘记密码?";
//    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:registeredPwdButton.titleLabel.text];
//    NSRange strRange2 = {6,5};
//    [str2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange2];
//    [registeredPwdButton setAttributedTitle:str2 forState:UIControlStateNormal];
    
    //取数组，未存则存，进度条
    NSArray *array = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];
    if (!array.count)
    {
        NSArray *array2 = [NSArray arrayWithObjects:[UIImage imageNamed:@"an_001"],[UIImage imageNamed:@"an_002"],[UIImage imageNamed:@"an_003"],[UIImage imageNamed:@"an_004"],[UIImage imageNamed:@"an_005"],[UIImage imageNamed:@"an_006"],[UIImage imageNamed:@"an_007"],nil];
        [CYSmallTools saveArrData:array2 withKey:LOADANIMATION];
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
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
    [_accountTextField resignFirstResponder];
}
//注册
- (void) registeredButton:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    RegisteredViewController *RController = [[RegisteredViewController alloc] init];
    [self.navigationController pushViewController:RController animated:YES];
}
//登录
- (void) loginButton:(UIButton *)sender
{
    if (!(self.accountTextField.text.length && self.pwdTextField.text.length))
    {
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
        return;
    }
//    if (![CYWhetherPhone isValidPhone:self.accountTextField.text])
//    {
//        [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
//        return;
//    }
    //放弃第一响应身份
    [_pwdTextField resignFirstResponder];
    [_accountTextField resignFirstResponder];
    //进度条
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]  =  [NSString stringWithFormat:@"%@",self.accountTextField.text];//
    parames[@"password"]  =  [NSString stringWithFormat:@"%@",self.pwdTextField.text];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/doLogin",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"登录请求成功JSON:%@", JSON);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             [CYSmallTools saveData:[[JSON objectForKey:@"param"] objectForKey:@"user"] withKey:PERSONALDATA];//user 大范围的
             [CYSmallTools saveData:[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"] withKey:COMDATA];//communityDO 小范围的小区数据
             NSString *communityDo = [NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"]];
             if (![communityDo isEqualToString:@"<null>"])
             {
                 [CYSmallTools saveDataString:[[[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"communityDO"] objectForKey:@"comTel"] withKey:PROPERTYCPHONE];//手机号
             }
             NSString *tokenString = [[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"token"];//token
             NSString *accoutString = [[[JSON objectForKey:@"param"] objectForKey:@"user"] objectForKey:@"account"];//账号
             NSLog(@"tokenString = %@",tokenString);
             [CYSmallTools saveDataString:tokenString withKey:TOKEN];
             [CYSmallTools saveDataString:accoutString withKey:ACCOUNT];
             
             [self saveArrWithName:[NSString stringWithFormat:@"%@",accoutString]];
             [CYSmallTools saveDataString:@"0" withKey:@"WetherFirstInput"];
             
             
             //推送
             [self jushWithAccount:accoutString];
             //跳转
             [self jumpController];
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
//设置设备别名
- (void) jushWithAccount:(NSString *)account
{
    [JPUSHService setTags:nil alias:account fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"设置结果:%i 用户别名:%@",iResCode,account);
    }];
    // 这是极光提供的方法，USER_INFO.userID是用户的id，你可以根据账号或者其他来设置，只要保证唯一便可
    // 不要忘了在登出之后将别名置空
    [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"设置结果:%i 用户别名:%@",iResCode,account);
    }];
    //注销通知
}
//跳转页面
- (void) jumpController
{
    
    NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
    if ([[dictT objectForKey:@"success"] integerValue] == 1)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
        if (![[dict objectForKey:@"account"] isEqualToString:[CYSmallTools getDataStringKey:ACCOUNT]])
        {
            [CYSmallTools saveData:nil withKey:ACCOUNTDATA];
        }
    }
    else
        [CYSmallTools saveData:nil withKey:ACCOUNTDATA];
    
    
    NSString *stringT = [NSString stringWithFormat:@"%@",[CYSmallTools getDataKey:COMDATA]];
    if (stringT.length > 6)//绑定房屋
    {
        
        //创建标签控制器
        UITabBarController *tabbarController = [[UITabBarController alloc] init];
        
        NSArray *arryaVC = @[@"RootViewController",@"MallViewController",@"CommunityABBSViewController",@"PersonalCenterViewController"];
        NSMutableArray *arrayNav = [[NSMutableArray alloc] initWithCapacity:arryaVC.count];
        for (NSString *str in arryaVC)
        {
            UIViewController *viewController = [[NSClassFromString(str) alloc] init];
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
            navigation.navigationBar.translucent = NO;
            navigation.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            [navigation.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
            [arrayNav addObject:navigation];
            if ([str isEqualToString:@"RootViewController"])
            {
                navigation.tabBarItem.title = @"首页";
                navigation.tabBarItem.image = [UIImage imageNamed:@"icon_home-1"];
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_pre-1"];
            }
            else if([str isEqualToString:@"MallViewController"])
            {
                navigation.tabBarItem.title = @"社区商城";
                navigation.tabBarItem.image = [UIImage imageNamed:@"icon_shangcheng-1"];
                //未标题-1_26
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_shangcheng_pre-1"];
            }
            else if([str isEqualToString:@"CommunityABBSViewController"])
            {
                navigation.tabBarItem.title = @"社区大小事";
                navigation.tabBarItem.image = [UIImage imageNamed:@"icon_community-1"];
                //未标题-1_32
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_community_pre-1"];
            }
            else if([str isEqualToString:@"PersonalCenterViewController"])
            {
                navigation.tabBarItem.title = @"我的";
                navigation.tabBarItem.image = [UIImage imageNamed:@"icon_me-1"];
                //未标题-1_32
                navigation.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_me_pre-1"];
            }

          
            //        navigation.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 30, 30);
        }
        tabbarController.viewControllers = arrayNav;
        //点击之后字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
        tabbarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0.302 green:0.545 blue:0.914 alpha:1.00];
        self.view.window.rootViewController = tabbarController;
    }
    else
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        HousingChoiceViewController *HCController = [[HousingChoiceViewController alloc] init];
        [self.navigationController pushViewController:HCController animated:YES];
    }
}
//忘记密码
- (void) forgetPwdButton:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ForgetPwdViewController *FController = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:FController animated:YES];
}
- (void) viewDidDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField ==_accountTextField) {
        _nameTableView.hidden =NO;

    }

    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    {
        
        
        if(textField ==_accountTextField)
        {
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            
            if (existedLength - selectedLength + replaceLength >= 12) {
                [textField resignFirstResponder];
                
                return NO;
                
                
            }
            
            if([_accountTextField.text stringByReplacingCharactersInRange:range withString:string].length == 0)
            {
                isbool = NO;
                _nameTableView.hidden =NO;
                _nameTableView.frame =CGRectMake(_pwdTextField.left, _accountTextField.bottom,CYScreanW*290.0/375.0 , arrOfName.count*CXCWidth*80);


            }
            else
            {
            
                _nameTableView.hidden =NO;

                isbool = YES;
                _searchResultArray = [[NSMutableArray alloc] init];
                for (NSString * item in arrOfName)
                {
                    
                    //case insensative search - way cool
                    if ([item rangeOfString:[_accountTextField.text stringByReplacingCharactersInRange:range withString:string]options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound)
                    {
                        [_searchResultArray addObject:item];
                    }
                    
                }
                _nameTableView.frame =CGRectMake(_pwdTextField.left, _accountTextField.bottom,CYScreanW*290.0/375.0 , _searchResultArray.count*CXCWidth*80);
                
                [_nameTableView reloadData];

            }//end if-else
            

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        
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
}

//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80*CXCWidth;
    
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!isbool)
        return arrOfName.count;
    else
        return _searchResultArray.count;

}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *ID = @"loginCellId";
      cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[LoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID withType:[NSString stringWithFormat:@"%ld",indexPath.row]];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
    if (!isbool)
        cell.nameStr= arrOfName[indexPath.row];
    else
       cell.nameStr = _searchResultArray[indexPath.row];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _nameTableView.hidden =YES;
    if (!isbool)
        _accountTextField.text =arrOfName[indexPath.row];
    else
        _accountTextField.text =_searchResultArray[indexPath.row];
}

- (void)saveArrWithName:(NSString *)name
{
    NSString *statu =@"0";//设定一个状态0表示没有与数组重复的，1表示有重复的
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    [arr addObjectsFromArray:[CYSmallTools getArrData:@"nameArr"]];
    if(arr.count ==0)//就是第一次登录
    {
        [arr addObject:name];
    
    }else
    {
        
        
        
        
        
        
        
    
        for (NSString *str in arr ) {
            if ([str isEqualToString:name]) {//若有一样的就返回1退出来---若没有直接加进去
                statu =@"1";
                return;
            }
            
        }
        if([statu isEqualToString:@"0"])
        {
            
            [arr addObject:name];
                    }
        

    
    }
    
    [CYSmallTools saveArrData:arr withKey:@"nameArr"];



}

@end
