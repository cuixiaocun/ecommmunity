//
//  PersonalCenterViewController.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "SettingViewController.h"
@interface PersonalCenterViewController ()
{
    BOOL isSing;//是否签到  是1 否0
    UIScrollView *bgScrollView;//整体的大背景
}
@end

@implementation PersonalCenterViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];

//    self.navigationController.navigationBarHidden=NO;
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setPersonalStyle];//导航栏
    [self mainView];//主界面
    
  }
- (void)mainView
{
    
    
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, CYScreanW, CXCScreanH+20)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CYScreanW, 1200*CXCWidth)];

    
    //上面的image
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CYScreanW, CXCWidth*350)];
    bgImageV.backgroundColor = [UIColor blueColor];
    [bgImageV setImage:[UIImage imageNamed:@"bg_wo_top"]];
    [bgScrollView addSubview:bgImageV];
    
    
    //个人中心
    UILabel *labe1 = [[UILabel alloc]initWithFrame:CGRectMake(0,10, CYScreanW, 64)];
    labe1.textColor = [UIColor whiteColor];
    labe1.text =@"个人中心";
    labe1.textAlignment = NSTextAlignmentCenter;
    labe1.font = [UIFont boldSystemFontOfSize:18];
    labe1.textColor = [UIColor whiteColor];
    [bgImageV   addSubview:labe1];
    
    
//    //设置按钮
//    UIButton *btn = [[UIButton alloc]init];
//    [btn setFrame:CGRectMake(670*CXCWidth, 60*CXCWidth,80*CXCWidth, 60*CXCWidth )];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(-5, -5, -5, -5)];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [btn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
//    [bgScrollView addSubview:btn];
//    //设置图片
//    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,42*CXCWidth , 54*CXCWidth)];
//    img.userInteractionEnabled = YES;
//    [img setImage:[UIImage imageNamed:@"icon_shezhi"]];
//    [btn addSubview:img];
    
    NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
    NSString *headString;
    NSString *nameString;
    if ([[dictT objectForKey:@"success"] integerValue] == 1)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
        headString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgAddress"]];
        nameString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickName"]];
    }
    else
    {
        dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:PERSONALDATA]];
        headString = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"imgAddress"]];
        nameString = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"nickName"]];
    }
    
    NSLog(@"dict = %@",dictT);
    //头像外环
    UIImageView *bgtouImg =[[UIImageView alloc]init] ;
    [bgtouImg setFrame:CGRectMake(35*CXCWidth, 140*CXCWidth, 112*CXCWidth, 112*CXCWidth)];
    bgtouImg.userInteractionEnabled =YES;
    [bgtouImg setBackgroundColor:[UIColor colorWithRed:133/255.0 green:203/255.0 blue:254/255.0 alpha:1]];
    [bgImageV addSubview:bgtouImg];
    [bgtouImg.layer setCornerRadius:112*CXCWidth/2];
    [bgtouImg.layer setMasksToBounds:YES];
    
    //头像
    EGOImageView *touImageV = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@""]];
    [touImageV setFrame:CGRectMake(9*CXCWidth, 9*CXCWidth, 94*CXCWidth, 94*CXCWidth)];
    [touImageV setImageURL:[NSURL URLWithString:headString]];
    [touImageV.layer setCornerRadius:94*CXCWidth/2];
    touImageV.tag =3330;
    touImageV.userInteractionEnabled =YES;
    [touImageV.layer setMasksToBounds:YES];
    [bgtouImg addSubview:touImageV];
    
    //名字
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+24*CXCWidth,bgtouImg.top, 400*CXCWidth, 60*CXCWidth)];
    labe.textColor = [UIColor whiteColor];
    labe.tag =3331;
    labe.text =nameString;
    labe.textAlignment = NSTextAlignmentLeft;
    labe.font = [UIFont boldSystemFontOfSize:15];
    labe.textColor = [UIColor whiteColor];
    [bgImageV   addSubview:labe];
    
    //积分
    UILabel *jilabe = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+24*CXCWidth,labe.bottom, 400*CXCWidth, 60*CXCWidth)];
    jilabe.textColor = [UIColor whiteColor];
    jilabe.tag =3332;
    jilabe.textAlignment = NSTextAlignmentLeft;
    jilabe.font = [UIFont boldSystemFontOfSize:15];
    jilabe.textColor = [UIColor whiteColor];
    [bgImageV   addSubview:jilabe];
    
    //头像按钮
    UIButton *topbtn =[[UIButton alloc]initWithFrame:CGRectMake(0,130*CXCWidth,CYScreanW, 210*CXCWidth)];
    [bgScrollView addSubview:topbtn];
    [topbtn addTarget:self action:@selector(selfCenter) forControlEvents:UIControlEventTouchUpInside];
    //右箭头图片
    UIImageView*jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(672*CXCWidth, jilabe.top-30*CXCWidth, 32*CXCWidth, 52*CXCWidth)];
    [bgImageV addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"icon_wo_next"]];
    //放中间四个按钮
    UIView * middleView1 =[[UIView alloc]initWithFrame:CGRectMake(0, bgImageV.bottom, CYScreanW, 160*CXCWidth)];
    middleView1.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:middleView1];
    
    //初始化图片数组
    NSArray* iconArray = [NSArray arrayWithObjects:@"icon_wo_dingdan",@"icon_wo_mingxi",@"icon_wo_weidian",@"icon_wo_qiandao",@"icon_advise",@"icon_forum",nil];
    NSArray* promptArray = @[@"我的订单",@"积分明细",@"我要开微店",@"签到"];
    for (int i=0; i<4; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(CXCWidth*62+CXCWidth*(62+110)*i,0,110*CXCWidth,CXCWidth*160)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+330;
        [middleView1 addSubview:btn];
        //上边图片
        UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*CXCWidth,45*CXCWidth,50*CXCWidth,50*CXCWidth)];
        topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",iconArray[i]]];
        topImgV.tag =1100+i;
        [btn addSubview:topImgV];
        //下边文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(-25*CXCWidth,topImgV.bottom+18*CXCWidth,160*CXCWidth,30*CXCWidth)];
        botLabel.textAlignment=NSTextAlignmentCenter;
        botLabel.font =[UIFont systemFontOfSize:13];
        botLabel.textColor =[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        botLabel.text =[NSString stringWithFormat:@"%@",promptArray[i]];
        [btn addSubview:botLabel];
    }
    
    //下边六个按钮
    NSArray * phoneArr =[[NSArray  alloc]init];
    phoneArr  = @[@"icon_wo_huodong",@"icon_wo_tiezi",@"icon_wo_pinglun",@"icon_wo_fangwu",@"icon_wo_baoiu",@"icon_wo_tousu"];
    NSArray*  wenArr =[[NSArray  alloc]init];
    wenArr  = @[@"我的活动",@"我的帖子",@"我的评论",@"我的房屋",@"我的报修",@"我的投诉"];
    
    for (int i =0; i<wenArr.count; i++) {
        //大按钮
        UIButton *cell = [[UIButton alloc]init];
        if(i<3)
        {
            cell.frame = CGRectMake(0, middleView1.bottom+20*CXCWidth+i*100*CXCWidth, CYScreanW, 100*CXCWidth);
        }else
        {
            cell.frame = CGRectMake(0, middleView1.bottom+40*CXCWidth+i*100*CXCWidth, CYScreanW, 100*CXCWidth);//空格20*CXCWidth
        }
        [cell addTarget:self action:@selector(cellBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor whiteColor];
        [bgScrollView addSubview:cell];
        //左边图片
        UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 30*CXCWidth, 40*CXCWidth, 40*CXCWidth)];
        [imagV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",phoneArr[i]]]];
        [cell addSubview:imagV];
        //右边文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80*CXCWidth, 0, 400*CXCWidth, 100*CXCWidth)];
        label.text = wenArr[i];
        label.textColor = TEXTColor;
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        
        UIImageView *imagV3 = [[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 99*CXCWidth,710*CXCWidth,1*CXCWidth)];
        [imagV3 setBackgroundColor:BGColor];
        [cell addSubview:imagV3];
        
        if (i==5) {
            NSLog(@"cell.frame.origin.y=%f",cell.frame.origin.y);
        }
        cell.tag =990+i;
    }




}
//设置样式
- (void) setPersonalStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    /*缓存的所有 包括清除缓存、计算缓存的大小*/

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths lastObject];
//        
//    //获取缓存大小。。
//    CGFloat fileSize = [self folderSizeAtPath:path];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.navigationItem.title= [NSString stringWithFormat:@"%.2fMB",fileSize];
// 
//    });
    
    
                       
}

- (CGFloat)folderSizeAtPath:(NSString *)folderPath
    {
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:folderPath]) {
            return 0;
        }
        
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
        
        NSString *fileName = nil;
        long long folderSize = 0;
        while ((fileName = [childFilesEnumerator nextObject]) != nil) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
            NSLog(@"缓存大小%lld",folderSize);
        }
        return folderSize/(1024.0*1024.0);
    }
                       
- (long long)fileSizeAtPath:(NSString *)filePath
    {
        NSFileManager* manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:filePath]){
            return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        }
        return 0;
        
    }
-(void)viewDidAppear:(BOOL)animated
{


}
- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController setNavigationBarHidden:YES animated:animated];

//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    //目的：实时更新积分
    [self signIn:@"checkTodaySign"];
    //显示
    [self.tabBarController.tabBar setHidden:NO];
    //签到
    if ([[CYSmallTools getDataStringKey:WHETHERSIGNIN] integerValue] == 1)//未签到
    {
        
    }
    else
    {
        self.integralLabel.text = [NSString stringWithFormat:@"%@ 积分",[CYSmallTools getDataStringKey:CURRENTINTEGRAL]];
    }
    
    
    
    [self getAccountData];
    
    
    
}
//设置
- (void)setting
{

    SettingViewController *setting =[[SettingViewController   alloc]init];
    [self.navigationController   pushViewController:setting animated:YES];


}

//签到
- (void) signIn:(NSString *)type
{
    [MBProgressHUD showLoadToView:self.view];
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/%@",POSTREQUESTURL,type];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@,error = %@", JSON,[JSON objectForKey:@"error"]);
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"param"]];

             if ([type isEqualToString:@"doSign"])
             {
                 UIImageView *image =[self.view viewWithTag:1103] ;
                 [image setImage:[UIImage imageNamed:@"icon_wo_qiandao"]];
                 isSing =1;
                 [MBProgressHUD showSuccess:@"签到成功" ToView:self.view];
                 UILabel*jifen =[self.view viewWithTag:3332];
                 jifen.text = [NSString stringWithFormat:@"%ld 积分",([[CYSmallTools getDataStringKey:CURRENTINTEGRAL] integerValue]+1)];
                 

            }
             else
             {
                 if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"canSign"]] isEqualToString:@"0"]) {//已签到
                     isSing =1;
                     UIImageView *image =[self.view viewWithTag:1103] ;
                     [image setImage:[UIImage imageNamed:@"icon_wo_qiandao"]];
                 }else
                 {
                     isSing=0;//未签到
                     UIImageView *image =[self.view viewWithTag:1103] ;
                     [image setImage:[UIImage imageNamed:@"icon_wo_qiandao_wei"]];

                 }
                 
                 
                 
                 [CYSmallTools saveDataString:[dict objectForKey:@"canSign"] withKey:WHETHERSIGNIN];
                 [CYSmallTools saveDataString:[dict objectForKey:@"score"] withKey:CURRENTINTEGRAL];
                 UILabel*jifen =[self.view viewWithTag:3332];
                 jifen.text = [NSString stringWithFormat:@"%@ 积分",[dict objectForKey:@"score"]];
                 

             }
         }
         else
         {
             //如果是签到失败，还可以继续签到
             if ([type isEqualToString:@"doSign"])
             {
                 
                 isSing=0;//未签到
                 UIImageView *image =[self.view viewWithTag:1103] ;
                 [image setImage:[UIImage imageNamed:@"icon_wo_qiandao_wei"]];

                 
                 
             }
             [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD hideHUDForView:self.view];
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
         NSLog(@"请求失败:%@", error.description);
         if ([type isEqualToString:@"doSign"])
         {
         }
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)myBtnAciton:(UIButton *)btn
{
    if (btn.tag== 330)
    {
    OrderMViewController *OrderController = [[OrderMViewController alloc] init];
        self.navigationController.navigationBarHidden =NO;
    [self.navigationController pushViewController:OrderController animated:YES];
    }else if (btn.tag == 331)
    {
    IntegralCommunityViewController *IntegralController = [[IntegralCommunityViewController alloc] init];
    [self.navigationController pushViewController:IntegralController animated:YES];
    }
else if (btn.tag == 332)
{
    SmallShopViewController *smallController = [[SmallShopViewController alloc] init];
    [self.navigationController pushViewController:smallController animated:YES];
}
else if (btn.tag == 333)
{
        if (isSing==1) {
            UIImageView *image =[self.view viewWithTag:1103] ;
            [image setImage:[UIImage imageNamed:@"icon_wo_qiandao"]];
            [MBProgressHUD showError:@"您今天已经签到过了。" ToView:self.view];
            
    }else
    {
    
        [self signIn:@"doSign"];

    }
    
}else if (btn.tag == 996)
{
    OpinionsSuggestionsViewController *OSController = [[OpinionsSuggestionsViewController alloc] init];
    [self.navigationController pushViewController:OSController animated:YES];
}
else if (btn.tag == 997)
{
    AboutUsViewController *AUController = [[AboutUsViewController alloc] init];
    [self.navigationController pushViewController:AUController animated:YES];
}
    

    }
//下边六个按钮
- (void)cellBtnPressed:(UIButton *)btn
{
    
    if (btn.tag == 990)
    {
        NeighborhoodActivitiesViewController *NAController = [[NeighborhoodActivitiesViewController alloc] init];
        [self.navigationController pushViewController:NAController animated:YES];
    }
    else if (btn.tag == 991)
    {
        MyBBSViewController *MBBSController = [[MyBBSViewController alloc] init];
        [self.navigationController pushViewController:MBBSController animated:YES];
    }
    else if (btn.tag == 992)
    {
        MyCommentViewController *MComController = [[MyCommentViewController alloc] init];
        [self.navigationController pushViewController:MComController animated:YES];
    }
    if (btn.tag == 993)
    {
        MyHousPlistViewController *MHController = [[MyHousPlistViewController alloc] init];
        [self.navigationController pushViewController:MHController animated:YES];
    }
    else if (btn.tag == 994)
    {
        MyRepairViewController *MRController = [[MyRepairViewController alloc] init];
        [self.navigationController pushViewController:MRController animated:YES];
    }
    else if (btn.tag == 995)
    {
        MyComplaintsViewController *MCController = [[MyComplaintsViewController alloc] init];
        [self.navigationController pushViewController:MCController animated:YES];
    }
  
}
//个人中心
- (void)selfCenter
{

    AccountSettingViewController *MCController = [[AccountSettingViewController alloc] init];
    [self.navigationController pushViewController:MCController animated:YES];
}
- (void) getAccountData
{
    NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
    NSLog(@"dict = %@",dictT);
    if ([[dictT objectForKey:@"success"] integerValue] == 1)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
        self.arry = @[[dict objectForKey:@"imgAddress"],
                                  [dict objectForKey:@"nickName"],
                                  [dict objectForKey:@"trueName"],
                                  [NSString stringWithFormat:@"%@",[dict objectForKey:@"idNo"]],
                                  [[NSString stringWithFormat:@"%@",[dict objectForKey:@"sex"]]isEqualToString:@"1"]?@"男":@"女",
                                  [NSString stringWithFormat:@"%@",[dict objectForKey:@"age"]],
                                  [NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:ACCOUNT]],
                                  @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    else
    {
        dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:PERSONALDATA]];
         self.arry = @[[dictT objectForKey:@"imgAddress"],
                                  [dictT objectForKey:@"nickName"],
                                  [dictT objectForKey:@"trueName"],
                                  [NSString stringWithFormat:@"%@",[dictT objectForKey:@"idNo"]],
                                  [[NSString stringWithFormat:@"%@",[dictT objectForKey:@"sex"]]isEqualToString:@"1"]?@"男":@"女",
                                  [NSString stringWithFormat:@"%@",[dictT objectForKey:@"age"]],
                                  [NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:ACCOUNT]],
                                  @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    UIImageView *img =[self.view viewWithTag:3330];
    UILabel *label =[self.view viewWithTag:3331];
//    UILabel *label2 =[self.view viewWithTag:3332];
    [img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_arry[0]]]]];
//    [img setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",_arry[0]]]];
    [label setText:[NSString stringWithFormat:@"%@",_arry[1]]];
//    [label2 setText:[NSString stringWithFormat:@"%@",_arry[2]]];
    
    
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
