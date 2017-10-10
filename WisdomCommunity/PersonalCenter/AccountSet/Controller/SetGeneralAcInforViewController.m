//
//  SetGeneralAcInforViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "SetGeneralAcInforViewController.h"

@interface SetGeneralAcInforViewController ()

@end

@implementation SetGeneralAcInforViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSGAStyle];
    [self initSGAControllers];
    
    
}
//设置样式
- (void) setSGAStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改用户名";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) initSGAControllers
{
    //提示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.05, CYScreanW * 0.5, (CYScreanH - 64) * 0.06)];
    label.text = @"用户名";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    //账号输入框
    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.11, CYScreanW * 0.9, (CYScreanH - 64) * 0.08)];
    _accountTextField.delegate = self;
    _accountTextField.placeholder = @"请输入用户名";
    NSLog(@"self.promptString = %@",self.promptString);
    _accountTextField.text = [NSString stringWithFormat:@"%@",[self.promptString isEqual:[NSNull null]] ? @"" : self.promptString];
    _accountTextField.textColor = [UIColor grayColor];
    _accountTextField.backgroundColor = [UIColor whiteColor];
    _accountTextField.textAlignment = NSTextAlignmentCenter;
    _accountTextField.layer.borderColor = BGColor.CGColor;
    _accountTextField.layer.borderWidth = 1;
    _accountTextField.layer.cornerRadius = 5;
    [self.view addSubview:_accountTextField];
    //提示
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.2, CYScreanW * 0.9, (CYScreanH - 64) * 0.04)];
    promptLabel.text = @"建议以数字或者英文字母开头,长度为2-10位";
    promptLabel.font = [UIFont fontWithName:@"Arial" size:10];
    promptLabel.textColor = [UIColor colorWithRed:0.765 green:0.765 blue:0.765 alpha:1.00];
    [self.view addSubview:promptLabel];
    //确定
    UIButton *determineButton = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.25, CYScreanW * 0.9, (CYScreanH - 64) * 0.08)];
//    [determineButton setBackgroundImage:[UIImage imageNamed:@"code_btn"] forState:UIControlStateNormal];
    [determineButton setBackgroundColor:NavColor];
    determineButton.layer.cornerRadius = 7;
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(changePersonalName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineButton];
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
    [_accountTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//修改个人信息
- (void) changePersonalName
{
    if (self.accountTextField.text.length >= 2 && self.accountTextField.text.length <= 10)
    {
        [MBProgressHUD showLoadToView:self.view];
        NSDictionary *dict = [CYSmallTools getDataKey:PERSONALDATA];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"id"]        =  [dict objectForKey:@"id"];
        parames[@"nickName"]  =  [NSString stringWithFormat:@"%@",self.accountTextField.text];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/updateAccInfo",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [CYSmallTools saveData:JSON withKey:ACCOUNTDATA];//记录账号数据
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
                 [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"请求失败:%@", error.description);
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
         }];
    }
    else
        [MBProgressHUD showError:@"用户名长度不符合" ToView:self.view];
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
