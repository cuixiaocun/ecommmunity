//
//  RealNameViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RealNameViewController.h"

@interface RealNameViewController ()

@end

@implementation RealNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setRNameStyle];
    [self initRNameControllers];
    
    
}
//设置样式
- (void) setRNameStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.typeInt == 2)
    {
        self.navigationItem.title = @"真实姓名";
    }
    else if (self.typeInt == 3)
    {
        self.navigationItem.title = @"身份证号";
    }
    else if (self.typeInt == 5)
    {
        self.navigationItem.title = @"年龄";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) initRNameControllers
{
    //提示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.05, CYScreanW * 0.5, (CYScreanH - 64) * 0.06)];
    if (self.typeInt == 2)
    {
        label.text = @"真实姓名";
    }
    else if (self.typeInt == 3)
    {
        label.text = @"身份证号";
    }
    else if (self.typeInt == 5)
    {
        label.text = @"年龄";
    }
    //[NSString stringWithFormat:@"%@",self.promptString];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    //账号输入框
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.11, CYScreanW * 0.9, (CYScreanH - 64) * 0.08)];
    _nameTextField.delegate = self;
    if (self.typeInt == 2)
    {
        _nameTextField.placeholder = @"请输入真实姓名";
    }
    else if (self.typeInt == 3)
    {
        _nameTextField.placeholder = @"请输入身份证号";
    }
    else if (self.typeInt == 5)
    {
        _nameTextField.placeholder = @"请输入年龄";
    }
    _nameTextField.textColor = [UIColor grayColor];
    _nameTextField.text = [NSString stringWithFormat:@"%@",[self.beforeString isEqualToString:@"<null>"] ? @"" : self.beforeString];
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.textAlignment = NSTextAlignmentCenter;
    _nameTextField.layer.borderColor = BGColor.CGColor;
    _nameTextField.layer.borderWidth = 1;
    _nameTextField.layer.cornerRadius = 5;
    _nameTextField.delegate = self;
    [self.view addSubview:_nameTextField];
        //确定
    UIButton *determineButton = [[UIButton alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.23, CYScreanW * 0.9, (CYScreanH - 64) * 0.08)];
//    [determineButton setBackgroundImage:[UIImage imageNamed:@"code_btn"] forState:UIControlStateNormal];
    [determineButton setBackgroundColor:NavColor];
    determineButton.layer.cornerRadius = 7;
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineRButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
    [_nameTextField resignFirstResponder];
}
//确定按钮
- (void) determineRButtonClick
{
    
    if (self.typeInt == 2)
    {
        _nameTextField.placeholder = @"请输入真实姓名";
        if (_nameTextField.text.length > 6)
        {
            [MBProgressHUD showError:@"输入过长" ToView:self.view];
        }
        else
            [self changePersonalInfor:@"trueName"];
    }
    else if (self.typeInt == 3)
    {
        _nameTextField.placeholder = @"请输入身份证号";
        if ([CYSmallTools judgeIdentityStringValid:_nameTextField.text]) {
            [self changePersonalInfor:@"idNo"];
        }
        else
            [MBProgressHUD showError:@"身份证格式不正确" ToView:self.view];
    }
    else if (self.typeInt == 5)
    {
        _nameTextField.placeholder = @"请输入年龄";
        if (_nameTextField.text.length > 2)
        {
            [MBProgressHUD showError:@"长度过长" ToView:self.view];
        }
        else
        {
            if ([CYSmallTools isPureNumandCharacters:_nameTextField.text]) {
                [self changePersonalInfor:@"age"];
            }
            else
                [MBProgressHUD showError:@"只能填写数字" ToView:self.view];
        }
    }
}
//修改个人信息
- (void) changePersonalInfor:(NSString *)key
{
//    isCorrect
    if (self.nameTextField.text.length > 0)
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
        parames[key]  =  [NSString stringWithFormat:@"%@",self.nameTextField.text];
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
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
             NSLog(@"请求失败:%@", error.description);
         }];
    }
    else
        [MBProgressHUD showError:@"数据不完整" ToView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
