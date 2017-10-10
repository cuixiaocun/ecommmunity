//
//  HousingChoiceViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "HousingChoiceViewController.h"

@interface HousingChoiceViewController ()
{
    UILabel *btnLabel;

}
@end

@implementation HousingChoiceViewController
{
    UIScrollView *bgScrollView;//背景scrollview
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setHChoiceStyle];
    [self initHouChoControllers];
    
}
//设置样式
- (void) setHChoiceStyle
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"房屋选择";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self getCommunityHousePlist];
}
- (void) viewWillDisappear:(BOOL)animated
{
    //清空房屋信息
    self.HouseDict = nil;
}
//页面初始化
- (void) initHouChoControllers
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    bgScrollView.scrollEnabled = YES;
    [bgScrollView setBackgroundColor:BGColor];
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];

    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    //选择小区
    UIButton *btnLeft = [[UIButton alloc] init];
    if ([self.InputController isEqualToString:@"MyHousPlistViewController"])
    {
        btnLeft.frame = CGRectMake(CYScreanW * 0.05, (CYScreanH - 64) * 0.05, CYScreanW * 0.4, (CYScreanH - 64) * 0.06);
    }
    else
    {
        btnLeft.frame = CGRectMake(CYScreanW * 0.05, 64 + (CYScreanH - 64) * 0.05, CYScreanW * 0.4, (CYScreanH - 64) * 0.06);
    }
    
    
    
    NSArray*titleArr =@[@"小区",@"楼号",@"单元",@"门牌号"];
    NSArray *houArr =@[@"",@"号楼",@"单元",@"号"];
    for (int i=0; i<4; i++) {
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0,20*CXCWidth+100*CXCWidth*i , CYScreanW, 100*CXCWidth)];
        [bgScrollView addSubview:bgView];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *qianLabel =[[UILabel alloc]initWithFrame:CGRectMake(20*CXCWidth, 0, 300*CXCWidth, 99*CXCWidth)];
        qianLabel.font =[UIFont systemFontOfSize:14];
        qianLabel.text =titleArr[i];
        [bgView addSubview:qianLabel];
        if (i>0)
        {
            UITextField *rightField =[[UITextField alloc]initWithFrame:CGRectMake(350*CXCWidth,0 , 300*CXCWidth, 99*CXCWidth)];
            rightField.font =[UIFont systemFontOfSize:14];
            rightField.delegate = self;
            rightField.placeholder = @"必填";
            rightField.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
            rightField.backgroundColor = [UIColor clearColor];
            rightField.textAlignment = NSTextAlignmentRight;
            rightField.keyboardType =UIKeyboardTypeNumberPad;
            [bgView addSubview:rightField];
            if (i==3) {
                rightField.frame =CGRectMake(350*CXCWidth,0 , 330*CXCWidth, 99*CXCWidth);
                self.houseNumberTextField =rightField;
                self.houseNumberTextField.placeholder = @"必填";
                
                
                //提交
                UIButton *registeredButton = [[UIButton alloc] init];
//                [registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
                [registeredButton setBackgroundColor:NavColor];
                registeredButton.layer.cornerRadius =6*CXCWidth;
                [registeredButton setTitle:@"提交" forState:UIControlStateNormal];
                registeredButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
                [registeredButton addTarget:self action:@selector(AddMyHouseRequest) forControlEvents:UIControlEventTouchUpInside];
                registeredButton.frame=CGRectMake(30*CXCWidth,bgView.bottom+ 105*CXCWidth, 690*CXCWidth, 100*CXCWidth);
                [bgScrollView addSubview:registeredButton];


            }else if(i==2)
            {
                self.unitNumberTextField =rightField;

                self.unitNumberTextField.placeholder = @"非必填";

            }else if (i==1)
            {
                self.buildNumberTextField =rightField;

                self.buildNumberTextField.placeholder = @"必填";

            }
            UILabel*rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(rightField.right+10*CXCWidth, 0, i<3?70*CXCWidth:40*CXCWidth,99*CXCWidth)];
            [bgView addSubview:rightLabel];
            rightLabel.font =[UIFont systemFontOfSize:14];
            rightLabel.text =houArr[i];
        
        
        }else
        {
        
            //选择按钮
            self.selectButton = [[UIButton alloc] initWithFrame:CGRectMake(400*CXCWidth,0 , 320*CXCWidth, 99*CXCWidth)];
            self.selectButton.backgroundColor = [UIColor clearColor];
//            [self.selectButton setImage:[UIImage imageNamed:@"icon_drop_down"] forState:UIControlStateNormal];
            [self.selectButton setTitleColor:[UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00] forState:UIControlStateNormal];
            self.selectButton.titleLabel.font = font;
            self.selectButton.layer.borderColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00].CGColor;
            [self.selectButton addTarget:self action:@selector(selectCommunityButton) forControlEvents:UIControlEventTouchUpInside];
            //    selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [bgView addSubview:self.selectButton];
            

            btnLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280*CXCWidth, 99*CXCWidth)];
            btnLabel.font =[UIFont systemFontOfSize:14];
            btnLabel.text =@"请选择小区";
            btnLabel.textAlignment =NSTextAlignmentRight;
            [_selectButton addSubview:btnLabel];

            UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(290*CXCWidth, 40*CXCWidth,20*CXCWidth , 20*CXCWidth)];
            [imgV setImage:[UIImage imageNamed:@"icon_drop_down"]];
            [_selectButton addSubview:imgV];
            
             
        }
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [bgView addSubview:segmentationImmage];
        segmentationImmage.frame =CGRectMake(20*CXCWidth,99*CXCWidth ,CYScreanW ,CXCWidth );
    }
    
       //填写信息
    if (self.HouseDict)
    {
        NSString *buildString = [NSString stringWithFormat:@"%@",[self.HouseDict objectForKey:@"build"]];
        NSArray *Array = [buildString componentsSeparatedByString:@"#"];//拆分成数组
        if (Array.count == 3)
        {
            self.buildNumberTextField.text = [NSString stringWithFormat:@"%@",Array[0]];
            self.unitNumberTextField.text = [NSString stringWithFormat:@"%@",Array[1]];
            self.houseNumberTextField.text = [NSString stringWithFormat:@"%@",Array[2]];
        }
    }
//    //注册
//    UIButton *registeredButton = [[UIButton alloc] init];
//    [registeredButton setBackgroundImage:[UIImage imageNamed:@"btn_activity_def"] forState:UIControlStateNormal];
//    [registeredButton setTitle:@"提交" forState:UIControlStateNormal];
//    registeredButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
//    [registeredButton addTarget:self action:@selector(AddMyHouseRequest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registeredButton];
//    
    
    //物业公司
    self.SelectComTableView = [[UITableView alloc] init];
    self.SelectComTableView.delegate = self;
    self.SelectComTableView.dataSource = self;
    self.SelectComTableView.showsVerticalScrollIndicator = NO;
    self.SelectComTableView.layer.borderWidth = 1;
    self.SelectComTableView.layer.borderColor = BGColor.CGColor;
    self.SelectComTableView.backgroundColor = BGColor;
    self.SelectComTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.SelectComTableView];
    self.SelectComTableView.hidden = YES;
}
//选择小区
- (void) selectCommunityButton
{
    
    [_buildNumberTextField resignFirstResponder];
    [_unitNumberTextField resignFirstResponder];
    [_houseNumberTextField resignFirstResponder];

    if (self.SelectComTableView.hidden == YES)
    {
        self.SelectComTableView.hidden = NO;
    }
    else
        self.SelectComTableView.hidden = YES;
}
//设置物业公司布局
- (void) setButtonHouseLayout:(NSString *)string
{
    //编辑进入
    if (self.HouseDict)
    {
        //首先遍历有没有要修改小区的数据
        for (NSDictionary *dict in self.communityDataArray)
        {
            if ([[dict objectForKey:@"id"] integerValue] == [[self.HouseDict objectForKey:@"comNo"] integerValue])
            {
                self.selectHouseComDict = dict;//将符合的数据记录下来
                self.selectHouseComId = [NSString stringWithFormat:@"%@",[self.HouseDict objectForKey:@"comNo"]];
                string = [NSString stringWithFormat:@"%@ %@",[self.selectHouseComDict objectForKey:@"city"],[self.selectHouseComDict objectForKey:@"comName"]];
                break;
            }
        }
    }
    CGSize sizeP = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    CGSize sizePImage = [UIImage imageNamed:@"icon_title_heart"].size;
//    [self.selectButton setTitle:string forState:UIControlStateNormal];
    btnLabel.text =string;
    
    self.selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, sizeP.width, 0, - sizeP.width);
    self.selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizePImage.width, 0, sizePImage.width);
}
//提交
- (void) submitHouseData
{
    if ([self.InputController isEqualToString:@"MyHousPlistViewController"])
    {
        [MBProgressHUD showError:@"提交成功" ToView:self.navigationController.view];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NSArray *array = self.navigationController.viewControllers;
        NSLog(@"array = %@",array);
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
    [self.buildNumberTextField resignFirstResponder];
    [self.houseNumberTextField resignFirstResponder];
    [self.unitNumberTextField resignFirstResponder];
}

//高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70*CXCWidth;
}
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组（section）有几行（row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.communityDataArray.count;
}
//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = TEXTColor;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.communityDataArray[indexPath.row]];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    NSString *string = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"city"],[dict objectForKey:@"comName"]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",string];
    
    UIImageView *imgv =[[UIImageView alloc]initWithFrame:CGRectMake(40*CXCWidth, 69*CXCWidth,240*CXCWidth, CXCWidth)];
    [cell.contentView addSubview:imgv];
    imgv.backgroundColor =BGColor;
    
    
    
    
    return cell;
}
//tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.SelectComTableView.hidden = YES;
    self.selectHouseComDict = [NSDictionary dictionaryWithDictionary:self.communityDataArray[indexPath.row]];
    
    self.selectHouseComId = [NSString stringWithFormat:@"%@",[self.selectHouseComDict objectForKey:@"id"]];
    NSString *string = [NSString stringWithFormat:@"%@ %@",[self.selectHouseComDict objectForKey:@"city"],[self.selectHouseComDict objectForKey:@"comName"]];
    CGSize sizeP = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    CGSize sizePImage = [UIImage imageNamed:@"icon_title_heart"].size;
//    [self.selectButton setTitle:string forState:UIControlStateNormal];
    btnLabel.text =string;
    self.selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, sizeP.width, 0, - sizeP.width);
    self.selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, - sizePImage.width, 0, sizePImage.width);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//获取社区列表
- (void) getCommunityHousePlist
{
    [MBProgressHUD showLoadToView:self.view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/community/comList",POSTREQUESTURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStringUTF8 = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStringUTF8 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            self.communityDataArray = [NSArray arrayWithArray:[[JSON objectForKey:@"param"] objectForKey:@"comList"]];
            if (self.communityDataArray.count > 0)
            {
                [self setComTV:self.communityDataArray];
            }
            else
                [MBProgressHUD showError:@"没有社区数据" ToView:self.view];
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}
- (void) setComTV:(NSArray *)array
{
    self.selectHouseComDict = [NSDictionary dictionaryWithDictionary:array[0]];
    self.selectHouseComId = [NSString stringWithFormat:@"%@",[self.selectHouseComDict objectForKey:@"id"]];
//    NSString *string = [NSString stringWithFormat:@"%@ %@",[self.selectHouseComDict objectForKey:@"city"],[self.selectHouseComDict objectForKey:@"comName"]];
    NSString *string = @"请选择小区";
    btnLabel.text=string;
    

    //物业公司
    [self setButtonHouseLayout:string];
    _SelectComTableView.frame =CGRectMake(400*CXCWidth,120*CXCWidth , 320*CXCWidth, (array.count<3? array.count *70*CXCWidth:3 * 70*CXCWidth));

//    [self.SelectComTableView mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.selectButton).offset(-20*CXCWidth);
//         make.right.equalTo(self.selectButton).offset(-20*CXCWidth);
//         make.top.equalTo(self.selectButton.mas_bottom).offset(0);
//         make.height.mas_equalTo(array.count<3? array.count *70*CXCWidth:3 * 70*CXCWidth);
//     }];
    [self.SelectComTableView reloadData];
    
}
//添加我的房屋
- (void) AddMyHouseRequest
{
    if (self.buildNumberTextField.text.length && self.houseNumberTextField.text.length)
    {
        
        if ([CYSmallTools isPureNumandCharacters:self.buildNumberTextField.text] && [CYSmallTools isPureNumandCharacters:self.houseNumberTextField.text])
        {
            [self alertShow];
        }
        else
            [MBProgressHUD showError:@"只能填写数字信息" ToView:self.view];
    }
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
    
}
- (void) alertShow
{
    
    
    if([btnLabel.text isEqualToString:@"请选择小区"])
    {
        [ProgressHUD showError:@"请选择小区"];
        return;
    
    }
    NSString *string = [NSString stringWithFormat:@"请确认房屋信息:%@,%@号楼%@单元%@室",[self.selectHouseComDict objectForKey:@"comName"],self.buildNumberTextField.text,self.unitNumberTextField.text,self.houseNumberTextField.text];
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:  UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          //点击按钮的响应事件；
                      }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          //点击按钮的响应事件；
                          [MBProgressHUD showLoadToView:self.view];
                          //若是添加房屋addMyBuild
                          NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/addMyBuild",POSTREQUESTURL];
                          AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                          manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                          NSMutableDictionary *parames = [NSMutableDictionary dictionary];
                          parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
                          parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
                          parames[@"comNo"]     =  [NSString stringWithFormat:@"%@",self.selectHouseComId];
                          parames[@"build"]     =  [NSString stringWithFormat:@"%@#%@#%@",self.buildNumberTextField.text,self.unitNumberTextField.text.length > 0 ? self.unitNumberTextField.text : @"1",self.houseNumberTextField.text];
                          //若是修改房屋的updateMyBuild
                          if (self.HouseDict) {
                              requestUrl = [NSString stringWithFormat:@"%@/api/account/updateMyBuild",POSTREQUESTURL];
                              parames[@"id"] = [NSString stringWithFormat:@"%@",[self.HouseDict objectForKey:@"id"]];
                          }
                          NSLog(@"parames = %@,requestUrl = %@",parames,requestUrl);
                          
                          [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
                              
                          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                           {
                               [MBProgressHUD hideHUDForView:self.view];
                               NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                               NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
                               if ([[JSON objectForKey:@"success"] integerValue] == 1)
                               {
                                   NSString *stringT = [NSString stringWithFormat:@"%@",[CYSmallTools getDataKey:COMDATA]];
                                   if (stringT.length <= 6)//绑定房屋
                                   {
                                       [CYSmallTools saveData:self.selectHouseComDict withKey:COMDATA];//记录
                                       [CYSmallTools saveDataString:[self.selectHouseComDict objectForKey:@"comTel"] withKey:PROPERTYCPHONE];//手机号
                                   }
                                   [self submitHouseData];
                               }
                               else
                               {
                                   //是否需要重新登录
                                   [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.navigationController.view];
                                   //进入登录页
                                   CYLoginViewController *GoLoController = [[CYLoginViewController alloc] init];
                                   [self.navigationController pushViewController:GoLoController animated:YES];
                               }
                               
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                           {
                               [MBProgressHUD hideHUDForView:self.view];
                               [MBProgressHUD showError:@"加载出错" ToView:self.view];
                               NSLog(@"请求失败:%@", error.description);
                           }];
                      }]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
