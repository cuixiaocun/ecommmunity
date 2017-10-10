//
//  PropertyRepairViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PropertyRepairViewController.h"
#import "YBImgPickerViewController.h"
#import "ShowBigPicController.h"
@interface PropertyRepairViewController ()<YBImgPickerViewControllerDelegate>
{

    UIScrollView *bgScrollView;//背景scrollview
    int timeCount;//上传图片请求
    UIView *bottomView;


}
@end

@implementation PropertyRepairViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _picArr =[[NSMutableArray alloc]init];
    _picUrlArr =[[NSMutableArray alloc]init];
    _picIdArr =[[NSMutableArray alloc]init];
    _uploadImageVArray =[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tupian:) name:@"tupian" object:nil];


    
    
    
    
    
    
    
    
    
    
    
    [self setRepairStyle];
    [self initRepairController];
    
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}
//设置样式
- (void) setRepairStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物业报修";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//初始化控件
- (void) initRepairController
{
    
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView .userInteractionEnabled = YES;
    bgScrollView.scrollEnabled = YES;
//    [bgScrollView setBackgroundColor:BGColor];
    [bgScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgScrollView];
    NSArray *leftArr =@[@"报修人",@"电话",@"楼宇号"];
    NSArray *rightArr =@[@"请输入报修人姓名",@"请输入联系电话",@"请输入楼宇号"];

    for (int i=0; i<3; i++) {
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.frame =CGRectMake(30*CXCWidth,i*96*CXCWidth, 300*CXCWidth, 96*CXCWidth);
        promptLabel.textColor = TEXTColor;
        [bgScrollView addSubview:promptLabel];
        
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.frame =CGRectMake(25*CXCWidth,95*CXCWidth*(i+1), CYScreanW, 1*CXCWidth);
        [bgScrollView addSubview:segmentationImmage];
        //提示文字
        promptLabel.font = [UIFont systemFontOfSize:14];
        promptLabel.text =leftArr[i];
        //内容（右边）
        UITextField *rightLabel = [[UITextField alloc] initWithFrame:CGRectMake(300*CXCWidth,i*96*CXCWidth , 420*CXCWidth, 96*CXCWidth)];
        rightLabel.textColor = TextGroColor;
        rightLabel.tag =110+i;
        rightLabel.placeholder =@"q";
        rightLabel.textAlignment =NSTextAlignmentRight;
        rightLabel.font = [UIFont fontWithName:@"Arial" size:14];
        rightLabel.delegate =self;
        [bgScrollView addSubview:rightLabel];
        segmentationImmage.backgroundColor = BGColor;
        [bgScrollView addSubview:segmentationImmage];
       
        
        
        
        
        
        
        if(i==0)
        {
        
            _nameTextField =rightLabel;
            _nameTextField.placeholder = @"请输入姓名";

        }else if (i==1)
        {
            _phonePRTextField=rightLabel;
            _phonePRTextField.placeholder = @"请输入联系电话";

        }else if (i==2)
        {
            _addressPRTextField =rightLabel;
            _addressPRTextField.placeholder = @"请输入地址";

        }
        
    }
    
    //活动内容
    self.proRepairTextView = [[UITextView alloc] init];
    self.proRepairTextView.textColor= [UIColor lightGrayColor];//设置提示内容颜色
    self.proRepairTextView.text=NSLocalizedString(@"详细描述一下您的问题", nil);//提示语
    self.proRepairTextView.selectedRange = NSMakeRange(0,0) ;//光标起始位置
    self.proRepairTextView.delegate = self;
    self.proRepairTextView.font = [UIFont fontWithName:@"Arial" size:15];
    self.proRepairTextView.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:self.proRepairTextView];
    _proRepairTextView.frame =CGRectMake(30*CXCWidth, 300*CXCWidth, 690*CXCWidth, 200*CXCWidth);

    
    
    //中间信息
    UIView *zhongView = [[UIView alloc]initWithFrame:CGRectMake(0,_proRepairTextView.bottom+10*CXCWidth,CYScreanW, 250*CXCWidth)];
    [bgScrollView addSubview:zhongView];
    //    zhongView.backgroundColor =[UIColor grayColor];
    zhongView.userInteractionEnabled =YES;
    zhongView.tag = 101;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*CXCWidth, 30*CXCWidth, 190*CXCWidth, 190*CXCWidth)];
    [btn setImage:[UIImage imageNamed:@"icon_insert_pic"] forState:UIControlStateNormal];
    btn.userInteractionEnabled =YES;
    [btn addTarget:self action:@selector(xuanzhong) forControlEvents:UIControlEventTouchUpInside];
    btn.tag =200;
    [zhongView addSubview:btn];
    //地址及以下
    bottomView =[[UIView alloc]initWithFrame:CGRectMake(0,zhongView.bottom,CYScreanW, 520*CXCWidth)];
    //    bottomView.backgcroundColor =[UIColor redColor];
    [bgScrollView addSubview:bottomView];
    

    //报修
    UIButton *complaintsButton = [[UIButton alloc] init];
        [complaintsButton setTitle:@"立即报修" forState:UIControlStateNormal];
        [complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        complaintsButton.layer.cornerRadius = 5;
        complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
    [complaintsButton addTarget:self action:@selector(launchedDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:complaintsButton];
        complaintsButton.frame =CGRectMake((30*CXCWidth), 100*CXCWidth,CXCWidth*690 , 100*CXCWidth);
    //    [complaintsButton mas_makeConstraints:^(MASConstraintMaker *make)
    //     {
    //         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
    //         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
    //         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.06);
    //         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
    //     }];
        //提示
        UIButton *promptButton = [[UIButton alloc] init];
        [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
        [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
        [promptButton setImage:[UIImage imageNamed:@"icon_pro_tel"] forState:UIControlStateNormal];
        promptButton.backgroundColor = [UIColor clearColor];
        [promptButton addTarget:self action:@selector(callPropertyPhone) forControlEvents:UIControlEventTouchUpInside];
        promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        promptButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [bottomView addSubview:promptButton];
        promptButton.frame =CGRectMake((30*CXCWidth), 230*CXCWidth,CXCWidth*690 , 40*CXCWidth);
    //    [promptButton mas_makeConstraints:^(MASConstraintMaker *make)
    //     {
    //         make.width.mas_equalTo(CYScreanW);
    //         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
    //         make.top.equalTo(complaintsButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
    //         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
    //     }];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

//    for (int i=0; i<3; i++) {
//        
//    }
//    
//    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
//    NSArray *promptArray = @[@"报  修  人:",@"手       机:",@"楼  宇  号:",@"问题描述 :"];
//    NSArray *iconArray = @[@"pro_repair_person",@"56user",@"building_number",@"question_des"];
//    for (NSInteger i = 0; i < promptArray.count; i ++)
//    {
//        //图标
//        UIImageView *showImmage = [[UIImageView alloc] init];
//        showImmage.image = [UIImage imageNamed:iconArray[i]];
//        [bgScrollView addSubview:showImmage];
//        showImmage.frame =CGRectMake((CYScreanW * 0.02), ((CYScreanH - 64) * 0.045 + i * (CYScreanH - 64) * 0.08), (CYScreanW * 0.045),((CYScreanH - 64) * 0.03));
////        [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
////         {
////             make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
////             make.width.mas_equalTo(CYScreanW * 0.045);
////             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.045 + i * (CYScreanH - 64) * 0.08);
////             make.height.mas_equalTo((CYScreanH - 64) * 0.03);
////         }];
//        //提示文字
//        UILabel *promptLabel = [[UILabel alloc] init];
//        promptLabel.textColor = [UIColor colorWithRed:0.620 green:0.620 blue:0.620 alpha:1.00];
////        promptLabel.textAlignment = NSTextAlignmentCenter;
//        promptLabel.font = font;
//        promptLabel.text = [NSString stringWithFormat:@"%@",promptArray[i]];
//        [bgScrollView addSubview:promptLabel];
//        promptLabel.frame =CGRectMake(showImmage.right+CYScreanW*1/32,((CYScreanH - 64) * 0.045 + i * (CYScreanH - 64) * 0.08),  (CYScreanW * 0.23), ((CYScreanH - 64) * 0.03));
//        
////        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
////         {
////             make.left.equalTo(showImmage.mas_right).offset(0);
////             make.width.mas_equalTo(CYScreanW * 0.23);
////             make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03 + i * (CYScreanH - 64) * 0.08);
////             make.height.mas_equalTo((CYScreanH - 64) * 0.06);
////         }];
//    }
//    
//    UIColor *graColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.00];
////    //报修人
//    _nameTextField = [[UITextField alloc] init];
//    NSLog(@"djwelfhawl%@",[CYSmallTools getDataKey:PERSONALDATA]);
//    
//
//    if(!([[[CYSmallTools getDataKey:PERSONALDATA] objectForKey:@"trueName"] isEqual:[NSNull null]]))// 如果这个不为空
//    {
//        _nameTextField.text =[[CYSmallTools getDataKey:PERSONALDATA] objectForKey:@"trueName"];
//    }
//    _nameTextField.placeholder = @"请输入姓名";
//    _nameTextField.delegate = self;
//    _nameTextField.layer.cornerRadius = 5;
//    _nameTextField.layer.borderColor = BGColor.CGColor;
//    _nameTextField.layer.borderWidth = 1;
//    _nameTextField.font = font;
//    _nameTextField.returnKeyType = UIReturnKeyDone;
//    _nameTextField.textColor = graColor;
//    _nameTextField.backgroundColor = [UIColor clearColor];
//    _nameTextField.textAlignment = NSTextAlignmentCenter;
//    [bgScrollView addSubview:_nameTextField];
//    
//    _nameTextField.frame=CGRectMake(CYScreanW*0.25+CYScreanW*1/16,((CYScreanH - 64) * 0.035 + 0 * (CYScreanH - 64) * 0.08),  (CYScreanW * 0.6), ((CYScreanH - 64) * 0.06));
//    
//    
//    
//    
////    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make)
////     {
////         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.3);
////         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
////         make.top.equalTo(self.view.mas_top).offset((CYScreanH - 64) * 0.03);
////         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
////     }];
//        //联系方式
//    _phonePRTextField = [[UITextField alloc] init];
//    if(!IsNilString([[CYSmallTools getDataKey:PERSONALDATA] objectForKey:@"account"]))// 如果这个不为空
//    {
//        _phonePRTextField.text =[[CYSmallTools getDataKey:PERSONALDATA] objectForKey:@"account"];
//    }
//
//    _phonePRTextField.placeholder = @"请输入手机号";
//    _phonePRTextField.delegate = self;
//    _phonePRTextField.font = font;
//    _phonePRTextField.returnKeyType = UIReturnKeyDone;
//    _phonePRTextField.layer.cornerRadius = 5;
//    _phonePRTextField.layer.borderColor = BGColor.CGColor;
//    _phonePRTextField.layer.borderWidth = 1;
//    _phonePRTextField.textColor = graColor;
//    _phonePRTextField.backgroundColor = [UIColor clearColor];
//    _phonePRTextField.textAlignment = NSTextAlignmentCenter;
//    [bgScrollView addSubview:_phonePRTextField];
//    _phonePRTextField.frame=CGRectMake(CYScreanW*0.25+CYScreanW*1/16,_nameTextField.bottom+CYScreanW*0.025,  (CYScreanW * 0.6), ((CYScreanH - 64) * 0.06));
//    //楼宇号
//    _addressPRTextField = [[UITextField alloc] init];
////    if(!IsNilString([[CYSmallTools getDataKey:COMDATA] objectForKey:@"address"]))// 如果这个不为空
////    {
////        _addressPRTextField.text =[[CYSmallTools getDataKey:COMDATA] objectForKey:@"address"];
////    }
//    _addressPRTextField.placeholder = @"如：1号楼1单元101室";
//    _addressPRTextField.delegate = self;
//    _addressPRTextField.font = font;
//    _addressPRTextField.returnKeyType = UIReturnKeyDone;
//    _addressPRTextField.layer.cornerRadius = 5;
//    _addressPRTextField.layer.borderColor = BGColor.CGColor;
//    _addressPRTextField.layer.borderWidth = 1;
//    _addressPRTextField.textColor = graColor;
//    _addressPRTextField.backgroundColor = [UIColor clearColor];
//    _addressPRTextField.textAlignment = NSTextAlignmentCenter;
//    [bgScrollView addSubview:_addressPRTextField];
//    _addressPRTextField.frame=CGRectMake(CYScreanW*0.25+CYScreanW*1/16,_phonePRTextField.bottom+CYScreanW*0.025,  (CYScreanW * 0.6), ((CYScreanH - 64) * 0.06));
//;
//    //问题描述
//    _proRepairTextView = [[UITextView alloc] init];
//    _proRepairTextView.delegate = self;
//    _proRepairTextView.layer.cornerRadius = 5;
//    _proRepairTextView.layer.borderColor = BGColor.CGColor;
//    _proRepairTextView.layer.borderWidth = 1;
//    _proRepairTextView.font = font;
////    _proRepairTextView.keyboardType = UIKeyboardTypeDefault;
//    _proRepairTextView.returnKeyType = UIReturnKeyDone;
//    _proRepairTextView.textColor = graColor;
//    _proRepairTextView.backgroundColor = [UIColor clearColor];
//    _proRepairTextView.textAlignment = NSTextAlignmentLeft;
//    [bgScrollView addSubview:_proRepairTextView];
//    _proRepairTextView.frame=CGRectMake(CYScreanW*0.25+CYScreanW*1/16,_addressPRTextField.bottom+CYScreanW*0.03,  (CYScreanW * 0.6), ((CYScreanH - 64) * 0.1));;
////    //拍照
//    UIImageView *showImmage = [[UIImageView alloc] init];
//    showImmage.image = [UIImage imageNamed:@"icon_camera"];
//    showImmage.userInteractionEnabled = YES;
//    [bgScrollView addSubview:showImmage];
//    showImmage.frame =CGRectMake( (CYScreanW * 0.02), _proRepairTextView.bottom+((CYScreanH - 64) * 0.125), ((CYScreanH - 64) * 0.15),((CYScreanH - 64) * 0.15));
////    [showImmage mas_makeConstraints:^(MASConstraintMaker *make)
////     {
////         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
////         make.top.equalTo(_proRepairTextView.mas_bottom).offset((CYScreanH - 64) * 0.125);
////         make.height.mas_equalTo((CYScreanH - 64) * 0.15);
////         make.width.mas_equalTo((CYScreanH - 64) * 0.15);
////     }];
//    //添加单击手势防范
//    UITapGestureRecognizer *showImmageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOpertationSet)];
//    showImmageTap.numberOfTapsRequired = 1;
//    [showImmage addGestureRecognizer:showImmageTap];
//    //展示
//    self.showPicRepImmage = [[UIImageView alloc] init];
//    _showPicRepImmage.layer.borderColor = BGColor.CGColor;
//    _showPicRepImmage.layer.borderWidth = 1;
//    //    self.showPicRepImmage.image = [UIImage imageNamed:@"que_recline"];
//    self.showPicRepImmage.userInteractionEnabled = YES;
//    [bgScrollView addSubview:self.showPicRepImmage];
//
//    _showPicRepImmage.frame =CGRectMake(CYScreanW*0.25+CYScreanW*1/16,_proRepairTextView.bottom+CYScreanW*0.03,  (CYScreanW * 0.6), (CYScreanW * 0.6));
//    
//    
////    [self.showPicRepImmage mas_makeConstraints:^(MASConstraintMaker *make)
////     {
////         make.left.equalTo(showImmage.mas_right).offset(CYScreanW * 0.18);
////         make.top.equalTo(_proRepairTextView.mas_bottom).offset((CYScreanH - 64) * 0.05);
////         make.height.mas_equalTo((CYScreanH - 64) * 0.3);
////         make.width.mas_equalTo(CYScreanW * 0.45);
////     }];
//    //添加单击手势防范
//    UITapGestureRecognizer *showImmageSHTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePRTap:)];
//    showImmageSHTap.numberOfTapsRequired = 1;
//    [self.showPicRepImmage addGestureRecognizer:showImmageSHTap];
//    //报修
//    UIButton *complaintsButton = [[UIButton alloc] init];
//    [complaintsButton setTitle:@"立即报修" forState:UIControlStateNormal];
//    [complaintsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    complaintsButton.layer.cornerRadius = 5;
//    complaintsButton.backgroundColor = [UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00];
//    [complaintsButton addTarget:self action:@selector(RequestRepair) forControlEvents:UIControlEventTouchUpInside];
//    [bgScrollView addSubview:complaintsButton];
//    complaintsButton.frame =CGRectMake((CYScreanW * 0.02), _showPicRepImmage.bottom+CYScreanW*1/8,CYScreanW*0.96 , ((CYScreanH - 64) * 0.06));
////    [complaintsButton mas_makeConstraints:^(MASConstraintMaker *make)
////     {
////         make.left.equalTo(self.view.mas_left).offset(CYScreanW * 0.02);
////         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
////         make.bottom.equalTo(self.view.mas_bottom).offset(-(CYScreanH - 64) * 0.06);
////         make.height.mas_equalTo((CYScreanH - 64) * 0.06);
////     }];
//    //提示
//    UIButton *promptButton = [[UIButton alloc] init];
//    [promptButton setTitle:@"有疑问请致电物业管理部门" forState:UIControlStateNormal];
//    [promptButton setTitleColor:[UIColor colorWithRed:0.639 green:0.635 blue:0.639 alpha:1.00] forState:UIControlStateNormal];
//    [promptButton setImage:[UIImage imageNamed:@"icon_pro_tel"] forState:UIControlStateNormal];
//    promptButton.backgroundColor = [UIColor clearColor];
//    [promptButton addTarget:self action:@selector(callPropertyPhone) forControlEvents:UIControlEventTouchUpInside];
//    promptButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
//    promptButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [bgScrollView addSubview:promptButton];
//    promptButton.frame =CGRectMake(CYScreanW*0.2 ,complaintsButton.bottom+CYScreanW*1/16, (CYScreanW)*0.77, ((CYScreanH - 64) * 0.04));
////    [promptButton mas_makeConstraints:^(MASConstraintMaker *make)
////     {
////         make.width.mas_equalTo(CYScreanW);
////         make.right.equalTo(self.view.mas_right).offset(-CYScreanW * 0.03);
////         make.top.equalTo(complaintsButton.mas_bottom).offset((CYScreanH - 64) * 0.01);
////         make.height.mas_equalTo((CYScreanH - 64) * 0.04);
////     }];
//    //展示图片
//    self.fullScreenRepImmage = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CYScreanW, CYScreanH)];
//    self.fullScreenRepImmage.userInteractionEnabled = YES;
//    [self.navigationController.view addSubview:self.fullScreenRepImmage];
//    self.fullScreenRepImmage.hidden = YES;
//    //添加单击手势防范
//    UITapGestureRecognizer *fullScreenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullSceenRTap:)];
//    fullScreenTap.numberOfTapsRequired = 1;
//    [self.fullScreenRepImmage addGestureRecognizer:fullScreenTap];
//    [bgScrollView setContentSize:CGSizeMake(CYScreanW,promptButton.bottom+CYScreanW*0.1)];

}
//拨打电话
- (void) callPropertyPhone
{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@", [CYSmallTools getDataStringKey:PROPERTYCPHONE]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [bgScrollView addSubview:callWebview];
}
// -- - - -- - - -- - - -- - - - -- - - - -- - - -- - - 函数 -- - - -- - - -- - - -- - - - -- - - - -- - - -- -
//商品点击手势
-(void)handlePRTap:(UITapGestureRecognizer *)sender
{
    if (self.fullScreenRepImmage.image)
    {
        self.fullScreenRepImmage.hidden = NO;
    }
}
-(void)fullSceenRTap:(UITapGestureRecognizer *)sender
{
    self.fullScreenRepImmage.hidden = YES;
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
    [_phonePRTextField resignFirstResponder];
    [_proRepairTextView resignFirstResponder];
    [_addressPRTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"详细描述一下您的问题", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location =
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"详细描述一下您的问题", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
}
//内容将要发生改变编辑,编辑完使用return退出

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if ([textView.text isEqualToString:@""])
        {
            textView.textColor=[UIColor lightGrayColor];
            textView.text=NSLocalizedString(@"详细描述一下您的问题", nil);
        }
        
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"详细描述一下您的问题", nil);
    }
}
//  -- - - - -- -  -- - - - -- - - - -- - - - -- - - - -- - - - -- - 拍照  -- - - - -- - - - -- - - - --- -- - - - -- -  -- - - - -- - - - -- - - - -- -
////响应函数
//-(void)tapOpertationSet
//{
//    if (IOS7)
//    {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        //判断是否支持相机，模拟器没有相机
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
//                                            {
//                                                //相机
//                                                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//                                                imagePickerController.delegate = self;
//                                                imagePickerController.allowsEditing = YES;
//                                                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//                                                [self presentViewController:imagePickerController animated:YES completion:^{}];
//                                            }];
//            [alertController addAction:defaultAction];
//        }
//        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //相册
//            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//            imagePickerController.delegate = self;
//            imagePickerController.allowsEditing = YES;
//            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            [self presentViewController:imagePickerController animated:YES completion:^{}];
//        }];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
//                                       {
//                                           
//                                       }];
//        
//        [alertController addAction:cancelAction];
//        [alertController addAction:defaultAction1];
//        //弹出试图，使用UIViewController的方法
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//    else
//    {
//        UIActionSheet *sheet;
//        //判断是否支持相机，模拟器没有相机
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
//        }
//        else
//        {
//            sheet = [[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
//        }
//        [sheet showInView:self.view];
//    }
//    
//}
//-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSInteger sourctType = 0;
//    //判断是否支持相机
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        switch (buttonIndex) {
//            case 1:
//                sourctType = UIImagePickerControllerSourceTypeCamera;
//                break;
//            case 2:
//                sourctType = UIImagePickerControllerSourceTypePhotoLibrary;
//                break;
//            default:
//                break;
//        }
//    }
//    else
//    {
//        if (buttonIndex == 1)
//        {
//            sourctType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        }
//    }
//    //跳转到相机或者相册页面
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.allowsEditing = YES;
//    imagePickerController.sourceType = sourctType;
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//    
//    
//}
//保存图片
- (void) savePRImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1.0);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
//IOS7以上的都要调用方法，选择完成后调用该方法
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    //保存图片至本地，上传图片到服务器需要使用
//    [self savePRImage:image withName:@"avatar.png"];
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    //设置图片显示
//    [self.showPicRepImmage setImage:savedImage];
//    [self.fullScreenRepImmage setImage:savedImage];
//    //上传图片 //异步加载
//    [MBProgressHUD showLoadToView:self.view];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        self.imgageUrl = [CYLRDataReuest uploadImage:savedImage withView:self.view];
//        NSLog(@"self.imageUrl = %@",self.imgageUrl);
//    });
////    [self uploadImage:savedImage];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}//保存图片
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1.0);//1为不缩放保存,取值（0.0-1.0）
    //获取沙沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

//IOS7都要调用方法，按取消按钮用该方法
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击发布按钮
- (void)launchedDidClicked:(UIButton *)sender
{
    [self LaunchedCampaignRequest];
    
}


#pragma mark 发起活动网络请求(先上传图片)
- (void)LaunchedCampaignRequest
{
    timeCount=1;
    _uploadImageVArray =[[NSMutableArray alloc]init];
    
    
    for(NSInteger i = 0; i < self.picIdArr.count; i++)
    {
        NSData * imageData = [self.picUrlArr objectAtIndex: i];
        [_uploadImageVArray addObject:@""];
        
        [self uploadImage:imageData withInt:i];
        
    }
    if(_picIdArr.count==0)
    {
        [self RequestRepair ];
        
    }
    
    
    
    
    
}


#pragma mark 图片上传请求
//上传图片
- (void) uploadImage:(NSData *)imageDate withInt:(NSInteger)index
{
    
    
    
    NSString *postUrl = [NSString stringWithFormat:@"%@/api/upload/uploadImg",POSTREQUESTURL];
    NSLog(@"postUrl = %@",postUrl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"account" forKey:@"12345678912"];
    [manager POST:postUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
        NSData *eachImgData = UIImageJPEGRepresentation(_picIdArr[index], 0.1);
        
        
        //        使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //
        [formData appendPartWithFileData :eachImgData name : @"file" fileName : fileName mimeType : @"image/jpg/png/jpeg" ];
        //        使用日期生成图片名称
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        formatter.dateFormat = @"yyyyMMddHHmmss";
        //        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //        //二进制文件，接口key值，文件路径，图片格式
        //        [formData appendPartWithFileData:imageDate name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"请求成功:%@", responseObject);
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"图片请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1)
        {
            //            [_uploadImageVArray insertObject:[[JSON objectForKey:@"param"] objectForKey:@"url"] atIndex:index];
            [_uploadImageVArray replaceObjectAtIndex:index withObject:[[JSON objectForKey:@"param"] objectForKey:@"url"]];
            
            NSLog(@"%@",self.uploadImageVArray);
            
            if (timeCount==_picIdArr.count) {
                
                
                [self RequestRepair];
                
                
            }
            timeCount++;
            
        }
        else
            [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"加载出错" ToView:self.view];
        NSLog(@"请求失败:%@", error.description);
    }];
}
//报修
- (void) RequestRepair
{
    
    for (NSString *str in self.uploadImageVArray) {
        NSInteger index = [self.uploadImageVArray indexOfObject:str];
        if (![str isEqualToString:@""]) {
            if (index == 0) {
                self.imageAddress = [NSString stringWithFormat:@"%@",str];
            }else{
                self.imageAddress = [NSString stringWithFormat:@"%@,%@",self.imageAddress,str];
            }
        }
    }
    

    if (self.phonePRTextField.text.length && self.proRepairTextView.text.length && self.nameTextField.text.length && self.addressPRTextField.text.length)
    {
        if (![CYWhetherPhone isValidPhone:self.phonePRTextField.text])
        {
            [MBProgressHUD showError:@"手机号格式不正确" ToView:self.view];
            return;
        }
        [MBProgressHUD showLoadToView:self.view];
        NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
        //数据请求   设置请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]     =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]       =  [CYSmallTools getDataStringKey:TOKEN];
        parames[@"comNo"]       =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
        parames[@"user"]        =  self.nameTextField.text;//
        parames[@"phone"]       =  self.phonePRTextField.text;
        parames[@"build"]       =  self.addressPRTextField.text;//
        parames[@"reason"]      =  self.proRepairTextView.text;
        if (![self.imageAddress isEqualToString:@""] && self.imageAddress != nil) {
            [parames setObject:_imageAddress forKey:@"imgAddress"];
        }
        NSLog(@"parames = %@",parames);
        //url
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/property/buildRepair",POSTREQUESTURL];
        NSLog(@"requestUrl = %@",requestUrl);
        [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
             if ([[JSON objectForKey:@"success"] integerValue] == 1)
             {
                 NSLog(@"报修成功");
                 [MBProgressHUD showError:@"提交成功" ToView:self.navigationController.view];
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
    {
        [MBProgressHUD showError:@"信息不完整" ToView:self.view];
    }
}
-(void)xuanzhong
{
    //    UIActionSheet *photoSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    //    [photoSheet showInView:self.view];
    YBImgPickerViewController * next = [[YBImgPickerViewController alloc]init];
    
    //    [next showInViewContrller:self choosenNum:0 delegate:self];
//    [next showInViewContrller:self choosenNum:0 delegate:self withArr:_picIdArr];//6个的时候
    
    [next showInViewContrller:self choosenNum:0 delegate:self withArr:_picIdArr withNum:5];//一张照片的时候
    

    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];//进入照相界面
            
        }
            break;
        case 1:
        {
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            
            pickerImage.delegate = self;
            pickerImage.allowsEditing = NO;
            [self presentViewController:pickerImage animated:YES completion:nil];//进入照相界面
        }
            break;
            
        default:
            break;
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // 把头像图片存到本地
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Img.png"]];   // 保存文件的名称
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:filePath atomically:YES];
    
    CGSize originalSize = image.size;
    
    CGFloat maxSize = 250;
    
    CGFloat width =originalSize.width;
    CGFloat height=originalSize.height ;
    
    
    if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
        width = maxSize;
        height = width*originalSize.height /originalSize.width;
    }
    
    if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
        height = maxSize;
        width= height*originalSize.width /originalSize.height;
    }
    
    
    CGSize newSize = CGSizeMake(width, height);
    
    UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
    
    [_picIdArr addObject:sacelImg];
    [_picUrlArr addObject:imageData];
    
    
    
    
    //    UIButton *btnq= (UIButton*)[self.view viewWithTag:200];
    //    [btnq setImage:_picIdArr[0] forState:UIControlStateNormal];
    
    
    
    
}
-(void)xianshi
{
    UIView *zhong= (UIView*)[self.view viewWithTag:101];
    for (UIView *buton in  [zhong subviews]) {
        
        if ([buton isKindOfClass:[UIButton class]]) {
            [buton removeFromSuperview];
        }
        
    }
    
    NSLog(@"%lu",(unsigned long)_picIdArr.count);
    for (int i=0; i<_picIdArr.count+1; i++) {
        if (i<3) {
            
            zhong.frame =CGRectMake(0,self.proRepairTextView.bottom+CXCWidth*10,CYScreanW, 250*CXCWidth);
            bottomView.frame =CGRectMake(0,zhong.bottom,CYScreanW, 520*CXCWidth);
            [bgScrollView setContentSize:CGSizeMake(CYScreanW, bottomView.bottom+CYScreanW*0.2)];
            
            
        }else
        {
            zhong.frame =CGRectMake(0,self.proRepairTextView.bottom+CXCWidth*10,CYScreanW, 470*CXCWidth);
            bottomView.frame =CGRectMake(0,zhong.bottom,CYScreanW, 520*CXCWidth);
            [bgScrollView setContentSize:CGSizeMake(CYScreanW, bottomView.bottom+CYScreanW*0.2)];
            
            
        }
        if (i<_picIdArr.count) {
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*CXCWidth+i%3*CXCWidth*235, i<3? 30*CXCWidth:250*CXCWidth, 190*CXCWidth, 190*CXCWidth)];
            [btn setImage:_picIdArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(datu:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag =400+i;
            [ zhong  addSubview:btn];
            
            
            UIButton *xBtn = [[UIButton alloc]initWithFrame:CGRectMake(-40*CXCWidth, -40*CXCWidth, 80*CXCWidth, 80*CXCWidth)];
            [xBtn setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
            [xBtn setImageEdgeInsets:UIEdgeInsetsMake(20*CXCWidth, 20*CXCWidth, 20*CXCWidth, 20*CXCWidth)];
            xBtn.userInteractionEnabled =YES;
            [xBtn addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
            xBtn.tag =44400+i;
            [btn addSubview:xBtn];
            
            
            
            
        }else
        {//6张时候<6
            if (i<1) {
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(45*CXCWidth+i%3*CXCWidth*235, i<3? 30*CXCWidth:250*CXCWidth, 190*CXCWidth, 190*CXCWidth)];
                [btn setImage:[UIImage imageNamed:@"icon_insert_pic"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(xuanzhong) forControlEvents:UIControlEventTouchUpInside];
                btn.tag =400+i;
                [ zhong  addSubview:btn];
                
                
            }
            
        }
        
    }
    
    
    
}
-(void)shanchu:(UIButton *)btn
{
    [_picIdArr removeObjectAtIndex:btn.tag-44400];
    [self xianshi];
    
    
}

//选图回来
- (void)YBImagePickerDidFinishWithImages:(NSMutableArray *)imageArray {
    //    for (UIImage * image in imageArray) {
    //
    //    }
    [_picIdArr addObjectsFromArray:imageArray ];
    [self xianshi];//多张
    
    
    [self zhuanhuanTupian];
    
    
    //    [self addMorePhoto:photoArr];
}
- (void)zhuanhuanTupian
{
    _picUrlArr = [[NSMutableArray alloc]init];
    _picArr= [[NSMutableArray alloc]init];
    for (int i=0; i<_picIdArr.count; i++) {
        UIImage *image = _picIdArr[i];
        // 把头像图片存到本地
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Img.png"]];   // 保存文件的名称
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [imageData writeToFile:filePath atomically:YES];
        
        CGSize originalSize = image.size;
        
        CGFloat maxSize = 250;
        
        CGFloat width =originalSize.width;
        CGFloat height=originalSize.height ;
        
        
        if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
            width = maxSize;
            height = width*originalSize.height /originalSize.width;
        }
        
        if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
            height = maxSize;
            width= height*originalSize.width /originalSize.height;
        }
        
        
        CGSize newSize = CGSizeMake(width, height);
        
        UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
        
        [_picArr addObject:sacelImg];
        [_picUrlArr addObject:imageData];
        
        
        
    }
    
    
    
    
}
//删除回来
- (void)tupian:(NSNotification *)not
{
    _picIdArr = not.object;
    
    [self xianshi];
    
    
    [self zhuanhuanTupian];
    
}
- (NSString*)getMyImage:(UIImage*)image{
    CGSize originalSize = image.size;
    
    CGFloat maxSize = 500;
    
    CGFloat width =originalSize.width;
    CGFloat height=originalSize.height;
    if (originalSize.width >originalSize.height && originalSize.width > maxSize) {
        width = maxSize;
        height = width*originalSize.height /originalSize.width;
    }
    
    if (originalSize.height > originalSize.width && originalSize.height > maxSize) {
        height = maxSize;
        width= height*originalSize.width /originalSize.height;
    }
    
    CGSize newSize = CGSizeMake(width, height);
    UIImage *sacelImg = [self imageWithImageSimple:image scaledToSize:newSize];
    
    // 保存图片至本地，方法见下文
    NSData *dd =UIImageJPEGRepresentation(sacelImg, 1.0);
    return [dd base64EncodedStringWithOptions:0];
    
}
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (void)datu:(UIButton *)btn
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ShowBigPicController *showP = [[ShowBigPicController alloc]init];
    showP.picUrlArr =_picIdArr;
    showP.isXiangce = YES;
    
    
    [self.navigationController pushViewController:showP animated:YES];
    
}


@end
