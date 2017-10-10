//
//  OpinionsSuggestionsViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/17.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "OpinionsSuggestionsViewController.h"

@interface OpinionsSuggestionsViewController ()

@end

@implementation OpinionsSuggestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSuggestionsStyle];
    [self initSuggestionsController];
    
    [self setNotification];
}
//设置样式
- (void) setSuggestionsStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见与建议";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

//初始化控件
- (void) initSuggestionsController
{
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"如果您有任何意见与建议，可以在这里提交给我们。";
    promptLabel.font = [UIFont fontWithName:@"Arial" size:16];
    promptLabel.textColor = TextGroColor;
    promptLabel.numberOfLines =0;
    promptLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(10);
         make.width.mas_equalTo (CYScreanW-20);
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.1);
     }];
    //输入框
    self.inputSuggestionsTextView = [[UITextView alloc] initWithFrame:CGRectMake( CYScreanW * 0.05, (CYScreanH - 64) * 0.15, CYScreanW * 0.9, (CYScreanH - 64) * 0.3)];
    self.inputSuggestionsTextView.layer.borderColor = [UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00].CGColor;
    self.inputSuggestionsTextView.layer.borderWidth = 1;
    self.inputSuggestionsTextView.layer.cornerRadius = 5;
    self.inputSuggestionsTextView.delegate = self;
    self.inputSuggestionsTextView.returnKeyType = UIReturnKeyDone;
    self.inputSuggestionsTextView.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.00];
    self.inputSuggestionsTextView.font = [UIFont fontWithName:@"Arial" size:17];
    [self.view addSubview:self.inputSuggestionsTextView];
    //提交按钮
    UIButton *queryButton = [[UIButton alloc] init];
    [queryButton setTitle:@"提交" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queryButton.layer.cornerRadius = 5;
    queryButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [queryButton addTarget:self action:@selector(submitOSButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryButton];
    [queryButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.width.mas_equalTo(CYScreanW * 0.9);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.05);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.1);
         make.height.mas_equalTo((CYScreanH - 64) * 0.08);
     }];
}
//增加监听，当键盘出现或改变时收出消息
- (void) setNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//自定义键盘高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyBoardHeight = keyboardRect.size.height;
    //    int width = keyboardRect.size.width;
//    self.view.frame = CGRectMake(0.0f, - keyBoardHeight + 64, self.view.frame.size.width, self.view.frame.size.height);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
//    self.view.frame = CGRectMake( 0, 64, self.view.frame.size.width, self.view.frame.size.height);
}
//提交
- (void) submitOSButton
{
    
    if (self.inputSuggestionsTextView.text.length)
    {
        [MBProgressHUD showLoadToView:self.view];
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/advise/addAdvise",POSTREQUESTURL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"content"]     =  [NSString stringWithFormat:@"%@",self.inputSuggestionsTextView.text];
        dict[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
        dict[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
        NSLog(@"dict = %@",dict);
        
        [manager POST:requestUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
                 [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
             NSLog(@"失败:%@", error.description);
         }];
    }
    else
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
}
// - - - - -- - - - - - - - - - - - - - -- - - -- - -  -- - - - -  --
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//内容将要发生改变编辑,编辑完使用return退出
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//屏幕点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.inputSuggestionsTextView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
