//
//  PropertyViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PropertyViewController.h"

@interface PropertyViewController ()

@end

@implementation PropertyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPropertyVCStyle];
    
    
}
//设置物业管家样式
- (void) setPropertyVCStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    //海报
    UIImageView *showImmage = [[UIImageView alloc] init];
    showImmage.image = [UIImage imageNamed:@"banner_myHouse"];
    [self.view addSubview:showImmage];
    showImmage.userInteractionEnabled = YES;

    showImmage.frame =CGRectMake(0, 0, CYScreanW, 310*CXCWidth);
    //添加单击手势防范
    UITapGestureRecognizer *housingImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHousingTap:)];
    housingImageTap.numberOfTapsRequired = 1;
    [showImmage addGestureRecognizer:housingImageTap];
    //图标
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.04, showImmage.bottom, CYScreanW * 0.4, CYScreanW * 0.16)];
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setTitle:@"服务内容" forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"icon_title_service"] forState:UIControlStateNormal];
    btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:btnLeft];
    btnLeft.userInteractionEnabled = NO;//不可点击
    //分割线
    UIImageView *segmentationImmage = [[UIImageView alloc] init];
    segmentationImmage.backgroundColor = BGColor;
    [self.view addSubview:segmentationImmage];
    segmentationImmage.frame =CGRectMake(0, btnLeft.bottom, CYScreanW,CXCWidth*1);
     //初始图片数组
   NSArray* _iconPCVArray = [NSArray arrayWithObjects:@"butler_icon_pay",@"butler_icon_report",@"butler_icon_near",@"butler_icon_complaint",@"butler_icon_water",@"butler_icon_live",nil];
    NSArray* promptPCVArray = @[@"物业缴费",@"物业报修",@"周边",@"投诉建议",@"水电煤缴费",@"生活服务"];

    for (int i=0; i<6; i++) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(i%3*CYScreanW/3,segmentationImmage.bottom+i/3*390*CXCWidth,CYScreanW/3,CXCWidth*390)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+10;
        [self.view addSubview:btn];
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(60*CXCWidth,90*CXCWidth,140*CXCWidth,140*CXCWidth)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",_iconPCVArray[i]]];
        [btn addSubview:topImgV];
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*CXCWidth,topImgV.bottom+30*CXCWidth,250*CXCWidth,30*CXCWidth)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:13];
        botLabel.text =[NSString stringWithFormat:@"%@",promptPCVArray[i]];
        [btn addSubview:botLabel];
    }

    
    
    
    for (int i=0; i<3; i++) {
        UIImageView *xianImgV =[[UIImageView alloc]init];
        xianImgV.backgroundColor =BGColor;
        [self.view addSubview:xianImgV];
        xianImgV.frame =CGRectMake(250*CXCWidth+i*CXCWidth*250,segmentationImmage.bottom, CXCWidth, 390*2*CXCWidth);
        if (i==2) {
            xianImgV.frame =CGRectMake(0,390*CXCWidth+segmentationImmage.bottom,CYScreanW, 2*CXCWidth);

        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
//    //按钮
//    self.propertyView = [[PropertyCVCView alloc] initWithFrame:CGRectMake( 0, btnLeft.bottom , CYScreanW, CYScreanW * 0.24 + CYScreanW * 0.25)];
//    self.propertyView.PCVDelegate = self;
//    self.propertyView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.propertyView];
//    
}
-(void)myBtnAciton:(UIButton *)btn
{


  if(btn.tag ==10)
  {
      [self propertyPayment ];
      
  }else if(btn.tag ==11)
  {
      [self propertyManagementService ];

  }else if(btn.tag ==12)
  {
      [self surrounding ];

  }
  else if(btn.tag ==13)
  {
      [self complaintsPCVSuggestions ];

  }
  else if(btn.tag ==14)
  {
      
  }
  else if(btn.tag ==15)
  {
//      [self lifeService];
  }



}
- (void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"物业管家";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//商品点击手势
-(void)handleHousingTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"handleHousingTap");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    MyHousPlistViewController *MyHouseController = [[MyHousPlistViewController alloc] init];
    [self.navigationController pushViewController:MyHouseController animated:YES];
}
//物业缴费
- (void) propertyPayment
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ProPaycostViewController *PPController = [[ProPaycostViewController alloc] init];
    [self.navigationController pushViewController:PPController animated:YES];
}
//物业报修
- (void) propertyManagementService
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PropertyRepairViewController *PRController = [[PropertyRepairViewController alloc] init];
    [self.navigationController pushViewController:PRController animated:YES];
}
//周边
- (void) surrounding
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    PeripheralServicesViewController *PSController = [[PeripheralServicesViewController alloc] init];
    [self.navigationController pushViewController:PSController animated:YES];
}
//投诉建议
- (void) complaintsPCVSuggestions
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    ComplaintsSuggestionsViewController *suggesController = [[ComplaintsSuggestionsViewController alloc] init];
    [self.navigationController pushViewController:suggesController animated:YES];
}
//生活服务
- (void) lifeService
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    LifeServiceViewController *lifeController = [[LifeServiceViewController alloc] init];
    [self.navigationController pushViewController:lifeController animated:YES];
}
//缴费服务
- (void) billPayment
{
    
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
