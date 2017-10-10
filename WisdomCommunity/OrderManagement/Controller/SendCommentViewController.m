//
//  SendCommentViewController.m
//  WisdomCommunity
//
//  Created by bridge on 17/2/4.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "SendCommentViewController.h"

@interface SendCommentViewController ()

@end

@implementation SendCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSendComStyle];
    [self initSendComControllers];
}
//设置样式
- (void) setSendComStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发表评论";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.productStar = @"0";
    self.serveStar = @"0";
}
//初始化控件
- (void) initSendComControllers
{
    //帖子内容
    self.postContentTextView = [[UITextView alloc] init];
    self.postContentTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.postContentTextView.text=NSLocalizedString(@"现在你可以评价了，请写下你对宝贝的感受吧，对他人帮助很大哦!", nil);//提示语
    self.postContentTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.postContentTextView.delegate = self;
    self.postContentTextView.font = [UIFont fontWithName:@"Arial" size:17];
    self.postContentTextView.backgroundColor = [UIColor clearColor];
//    self.postContentTextView.textColor = [UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1.00];
    [self.view addSubview:self.postContentTextView];
    [self.postContentTextView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03);
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.45);
     }];
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [self.view addSubview:segmentationImmage];
    [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.bottom.equalTo(self.postContentTextView.mas_bottom).offset(0);
         make.height.mas_equalTo(1);
     }];
    //提示
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.textColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    promptLabel.textAlignment = NSTextAlignmentLeft;
    promptLabel.text = @"商品评价";
    promptLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.top.equalTo(segmentationImmage.mas_bottom).offset((CYScreanH - 64) * 0.05);
         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
         make.width.mas_equalTo(CYScreanW * 0.4);
     }];
    //评分
    UILabel *FWCommentLabel = [[UILabel alloc] init];
    FWCommentLabel.textColor = [UIColor grayColor];
    FWCommentLabel.textAlignment = NSTextAlignmentLeft;
    FWCommentLabel.text = @"服务态度";
    FWCommentLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:FWCommentLabel];
    [FWCommentLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.top.equalTo(promptLabel.mas_bottom).offset((CYScreanH - 64) * 0.03);
         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
         make.width.mas_equalTo(CYScreanW * 0.3);
     }];
    //商品评分
    UILabel *SPCommentLabel = [[UILabel alloc] init];
    SPCommentLabel.textColor = [UIColor grayColor];
    SPCommentLabel.textAlignment = NSTextAlignmentLeft;
    SPCommentLabel.text = @"商品评分";
    SPCommentLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:SPCommentLabel];
    [SPCommentLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.top.equalTo(FWCommentLabel.mas_bottom).offset((CYScreanH - 64) * 0.02);
         make.height.mas_equalTo((CYScreanH - 64) * 0.05);
         make.width.mas_equalTo(CYScreanW * 0.3);
     }];
    for (NSInteger i = 0 ; i < 2; i ++)
    {
        //黑色星星
        UIView *blackStart = [[UIView alloc] init];
        blackStart.backgroundColor = [UIColor clearColor];
        [self.view addSubview:blackStart];
        if (i == 0)
        {
            [blackStart mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(FWCommentLabel.mas_right).offset(CYScreanW * 0.3);
                make.top.and.height.equalTo(FWCommentLabel);
                make.width.mas_equalTo(CYScreanW * 0.3);
            }];
        }
        else
        {
            [blackStart mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(SPCommentLabel.mas_right).offset(CYScreanW * 0.3);
                make.top.and.height.equalTo(SPCommentLabel);
                make.width.mas_equalTo(CYScreanW * 0.3);
            }];
        }
        
        for (NSInteger i = 0; i < 5; i ++)
        {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.06 * i, (CYScreanH - 64) * 0.005, CYScreanW * 0.06, (CYScreanH - 64) * 0.04)];
            image.image = [UIImage imageNamed:@"start2"];
            image.userInteractionEnabled = YES;
            [blackStart addSubview:image];
        }
        if (i == 0)
        {
            //金色星星
            _redStartOne = [[UIView alloc] init];
            _redStartOne.backgroundColor = [UIColor clearColor];
            _redStartOne.clipsToBounds = YES;//超出部分不显示
            [self.view addSubview:_redStartOne];
            [_redStartOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.top.and.height.equalTo(blackStart);
                make.width.mas_equalTo(0);
            }];
            for (NSInteger i = 0; i < 5; i ++)
            {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.06 * i, (CYScreanH - 64) * 0.005, CYScreanW * 0.06, (CYScreanH - 64) * 0.04)];
                image.image = [UIImage imageNamed:@"start1"];
                [_redStartOne addSubview:image];
            }
        }
        else
        {
            //金色星星
            _redStartTwo = [[UIView alloc] init];
            _redStartTwo.backgroundColor = [UIColor clearColor];
            _redStartTwo.clipsToBounds = YES;//超出部分不显示
            [self.view addSubview:_redStartTwo];
            [_redStartTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.top.and.height.equalTo(blackStart);
                make.width.mas_equalTo(0);
            }];
            for (NSInteger i = 0; i < 5; i ++)
            {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake( CYScreanW * 0.06 * i, (CYScreanH - 64) * 0.005, CYScreanW * 0.06, (CYScreanH - 64) * 0.04)];
                image.image = [UIImage imageNamed:@"star"];
                [_redStartTwo addSubview:image];
            }
        }
        
        //手势图片
        UIImageView *startImageView = [[UIImageView alloc] init];
        startImageView.backgroundColor = [UIColor clearColor];
        startImageView.layer.cornerRadius = 5;
        startImageView.tag = i + 1111;
        startImageView.userInteractionEnabled = YES;
        [self.view addSubview:startImageView];
        [startImageView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.view.mas_left).offset(0);
             make.right.equalTo(self.view.mas_right).offset(0);
             make.top.and.height.equalTo(blackStart);
         }];
        
        //添加单击手势防范
        UITapGestureRecognizer *singleTapImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapImageView.numberOfTapsRequired = 1;
        [startImageView addGestureRecognizer:singleTapImageView];
        
        UISwipeGestureRecognizer *recognizerLeft;
        recognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [startImageView addGestureRecognizer:recognizerLeft];
        UISwipeGestureRecognizer *recognizerRight;
        recognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [startImageView addGestureRecognizer:recognizerRight];
    }
    UIButton *sendCommentButton = [[UIButton alloc] init];
    sendCommentButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    sendCommentButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:17];
    [sendCommentButton setTitle:@"发表评论" forState:UIControlStateNormal];
    [sendCommentButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sendCommentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendCommentButton.layer.cornerRadius = 5;
    [self.view addSubview:sendCommentButton];
    [sendCommentButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.03);
         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.1);
         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
         make.width.mas_equalTo(CYScreanW * 0.94);
     }];
}

//商品点击手势
-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"1 handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    if (sender.view.tag == 1111)
    {
        NSLog(@"1111");
        if (point.x < CYScreanW * 0.6)
        {
            _redStartOne.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.61, 0, (CYScreanH - 64) * 0.05);
            //清空
        }
        else if (point.x < CYScreanW * 0.66)
        {
            _redStartOne.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.615, CYScreanW * 0.06, (CYScreanH - 64) * 0.05);
            self.serveStar = @"1";
            //1
        }
        else if (point.x < CYScreanW * 0.72)
        {
            _redStartOne.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.61, CYScreanW * 0.12, (CYScreanH - 64) * 0.05);
            self.serveStar = @"2";
            //2
        }
        else if (point.x < CYScreanW * 0.8)
        {
            _redStartOne.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.61, CYScreanW * 0.18, (CYScreanH - 64) * 0.05);
            self.serveStar = @"3";
            //3
        }
        else if (point.x < CYScreanW * 0.86)
        {
            _redStartOne.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.61, CYScreanW * 0.24, (CYScreanH - 64) * 0.05);
            self.serveStar = @"4";
            //4
        }
        else
        {
            _redStartOne.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.61, CYScreanW * 0.3, (CYScreanH - 64) * 0.05);
            self.serveStar = @"5";
            //5
        }
    }
    else
    {
        if (point.x < CYScreanW * 0.6)
        {
            _redStartTwo.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.68, 0, (CYScreanH - 64) * 0.05);
            
            //清空
        }
        else if (point.x < CYScreanW * 0.66)
        {
            _redStartTwo.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.68, CYScreanW * 0.06, (CYScreanH - 64) * 0.05);
            self.productStar = @"1";
            //1
        }
        else if (point.x < CYScreanW * 0.72)
        {
            _redStartTwo.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.68, CYScreanW * 0.12, (CYScreanH - 64) * 0.05);
            self.productStar = @"2";
            //2
        }
        else if (point.x < CYScreanW * 0.8)
        {
            _redStartTwo.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.68, CYScreanW * 0.18, (CYScreanH - 64) * 0.05);
            self.productStar = @"3";
            //3
        }
        else if (point.x < CYScreanW * 0.86)
        {
            _redStartTwo.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.68, CYScreanW * 0.24, (CYScreanH - 64) * 0.05);
            self.productStar = @"4";
            //4
        }
        else
        {
            _redStartTwo.frame = CGRectMake( CYScreanW * 0.63, (CYScreanH - 64) * 0.68, CYScreanW * 0.3, (CYScreanH - 64) * 0.05);
            self.productStar = @"5";
            //5
        }
        NSLog(@"1112");
    }
}
//滑动手势
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self.view];
    NSLog(@"1 handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
}
// - - - - -- - - -- - - - - -- - - -- - - - - -- - - --   代理  - - - - -- - - -- - - - - -- - - -- - - - - -- - - -- - - - - -- - - --
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"现在你可以评价了，请写下你对宝贝的感受吧，对他人帮助很大哦!", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"现在你可以评价了，请写下你对宝贝的感受吧，对他人帮助很大哦!", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = NSLocalizedString(@"现在你可以评价了，请写下你对宝贝的感受吧，对他人帮助很大哦!", nil);
    }
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.postContentTextView resignFirstResponder];
}

//发表评论
- (void) sendButtonClick:(UIButton *)sender
{
    //评价不为空
    if (self.postContentTextView.text.length > 0 && self.postContentTextView.text.length <= 200 && ![self.postContentTextView.text isEqual:@"现在你可以评价了，请写下你对宝贝的感受吧，对他人帮助很大哦!"])
    {
        [MBProgressHUD showLoadToView:self.view];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]         =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]           =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"shopId"]          =  [NSString stringWithFormat:@"%@",self.shopId];
        parames[@"evaluate"]        =  [NSString stringWithFormat:@"%@",self.postContentTextView.text];
        parames[@"productStar"]     =  [NSString stringWithFormat:@"%@",self.productStar];
        parames[@"serveStar"]       =  [NSString stringWithFormat:@"%@",self.serveStar];
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/product/evaluatePro",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"获取订单数请求成功JSON = %@",JSON);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 [MBProgressHUD showError:@"评价完成" ToView:self.navigationController.view];
                 //评价完直接返回
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
                 [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [MBProgressHUD hideHUDForView:self.view];
             [MBProgressHUD showError:@"加载出错" ToView:self.view];
         }];
    }
    else
    {
        [MBProgressHUD showError:@"评价长度不符合" ToView:self.view];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
