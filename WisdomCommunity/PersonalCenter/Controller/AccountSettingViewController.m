//
//  AccountSettingViewController.m
//  WisdomCommunity
//
//  Created by Admin on 2017/5/2.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "OpinionsSuggestionsViewController.h"
#import "AboutUsViewController.h"
@interface AccountSettingViewController ()
{
    UIScrollView *bgScrollView;//整体的大背景
}
@property (nonatomic,strong) NSArray *dataAccountArray;//账户信息

@end

@implementation AccountSettingViewController

- (void)viewDidLoad
{
    NSLog(@"出现");

    [super viewDidLoad];

    
    [self setAccountStyle];
    
    
    
}
- (void)mainView
{
    
    [bgScrollView removeFromSuperview];
    
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, CXCScreanH)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CYScreanW, 1100*CXCWidth)];

    //上面的image
    UIButton *bgImageV = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CYScreanW, CXCWidth*160)];
    bgImageV.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:bgImageV];
    [bgImageV addTarget:self action:@selector(selfCenter) forControlEvents:UIControlEventTouchUpInside];
    
    
    //头像
    EGOImageView *touImageV = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@""]];
    NSString *headString = [NSString stringWithFormat:@"%@",self.dataAccountArray[0]];

    [touImageV setFrame:CGRectMake(32*CXCWidth, 33*CXCWidth, 94*CXCWidth, 94*CXCWidth)];
    [touImageV setImageURL:[NSURL URLWithString:headString]];
    [touImageV.layer setCornerRadius:94*CXCWidth/2];
    touImageV.tag =3330;
    touImageV.userInteractionEnabled =YES;
    [touImageV.layer setMasksToBounds:YES];
    [bgImageV addSubview:touImageV];
    
    //名字
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(touImageV.right+24*CXCWidth,touImageV.top, 400*CXCWidth, 47*CXCWidth)];
    labe.textColor = [UIColor whiteColor];
    labe.tag =3331;
    labe.text =[NSString stringWithFormat:@"用户名：%@",self.dataAccountArray[1]];
    labe.textAlignment = NSTextAlignmentLeft;
    labe.font = [UIFont boldSystemFontOfSize:16];
    labe.textColor = TEXTColor;
    [bgImageV   addSubview:labe];
    
    //真实姓名
    UILabel *jilabe = [[UILabel alloc]initWithFrame:CGRectMake(touImageV.right+24*CXCWidth,labe.bottom, 400*CXCWidth, 47*CXCWidth)];
    jilabe.textColor = [UIColor whiteColor];
    jilabe.tag =3332;
    jilabe.text=[NSString stringWithFormat:@"真实姓名：%@",self.dataAccountArray[2]];
    jilabe.textAlignment = NSTextAlignmentLeft;
    jilabe.font = [UIFont boldSystemFontOfSize:13];
    jilabe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [bgImageV   addSubview:jilabe];
    
      //右箭头图片
    UIImageView*jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*CXCWidth, jilabe.top-30*CXCWidth, 32*CXCWidth, 52*CXCWidth)];
    [bgImageV addSubview:jiantou];
//    [jiantou setBackgroundColor:[UIColor redColor]];
    
    [jiantou setImage:[UIImage imageNamed:@"icon_shezhi_next"]];
  NSArray*  wenziArr =@[@"身份证号",@"性别",@"年龄",@"手机号",@"我的签到",@"收货地址管理",@"意见与建议",@"关于",@"退出",@"",@"",@"",@"",@"",];
    for (int i=0; i<9; i++) {
        
        
        //大按钮
        UIButton *cell = [[UIButton alloc]init];
        if(i<4)
        {
            cell.frame = CGRectMake(0, bgImageV.bottom+20*CXCWidth+i*100*CXCWidth, CYScreanW, 100*CXCWidth);
        }else if(i==4||i==5)
        {
            cell.frame = CGRectMake(0, bgImageV.bottom+40*CXCWidth+i*100*CXCWidth, CYScreanW, 100*CXCWidth);//空格20*CXCWidth
        }else if(i==8)
        {
            cell.frame = CGRectMake(0, bgImageV.bottom+80*CXCWidth+i*100*CXCWidth, CYScreanW, 100*CXCWidth);//空格20*CXCWidth

        
        }else
        {
            cell.frame = CGRectMake(0, bgImageV.bottom+60*CXCWidth+i*100*CXCWidth, CYScreanW, 100*CXCWidth);//空格20*CXCWidth

        }
        [cell addTarget:self action:@selector(cellBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor whiteColor];
        [bgScrollView addSubview:cell];
        //左边文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32*CXCWidth, 0, 400*CXCWidth, 99*CXCWidth)];
        label.text = wenziArr[i];
        label.textColor = TEXTColor;
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        
        //右边文字
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(250*CXCWidth, 0, 420*CXCWidth, 99*CXCWidth)];
        label2.text = [NSString stringWithFormat:@"%@",self.dataAccountArray[i+3]];
        label2.textColor = TextGroColor;
        label2.textAlignment =NSTextAlignmentRight;
        label2.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label2];
        if ((i!=3)) {
            if (i!=8) {
                UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*CXCWidth, 25*CXCWidth,30*CXCWidth , 50*CXCWidth)];
                [cell addSubview:jiantou];
                [jiantou setImage:[UIImage imageNamed:@"icon_shezhi_next"]];

            }
            
        }
        
        UIImageView *imagV3 = [[UIImageView alloc]initWithFrame:CGRectMake(20*CXCWidth, 99*CXCWidth,710*CXCWidth,1*CXCWidth)];
        [imagV3 setBackgroundColor:BGColor];
        [cell addSubview:imagV3];
        
        if (i==5) {
            NSLog(@"cell.frame.origin.y=%f",cell.frame.origin.y);
        }
        cell.tag =990+i;
        
        
        
        
        
        
    }
    
    
    
    
    
    

}
- (void)cellBtnPressed:(UIButton*)btn
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];


    if (btn.tag==990) {
        [self personalChange:self.dataAccountArray[3] withRow:3];
    }else if(btn.tag ==991)
    {
        SelectSexViewController *SSController = [[SelectSexViewController alloc] init];
        SSController.sexString = [NSString stringWithFormat:@"%@",self.dataAccountArray[4]];
        [self.navigationController pushViewController:SSController animated:YES];

    
    }else if(btn.tag ==992)
    {
        [self personalChange:self.dataAccountArray[5] withRow:5];

        
    }else if(btn.tag ==994)
    {
        SeeSignInRecordViewController *SSIRController = [[SeeSignInRecordViewController alloc] init];
        [self.navigationController pushViewController:SSIRController animated:YES];
        
    }else if(btn.tag ==995)
    {
        AddressManagementViewController *adController = [[AddressManagementViewController alloc] init];
        [self.navigationController pushViewController:adController animated:YES];

        
    }else if(btn.tag ==996)
    {
        OpinionsSuggestionsViewController *OSController = [[OpinionsSuggestionsViewController alloc] init];
        [self.navigationController pushViewController:OSController animated:YES];

        
    }else if(btn.tag ==997)
    {
        AboutUsViewController *AUController = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:AUController animated:YES];

        
        
    }else if(btn.tag ==998)
    {
        
        UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",@"您确定要退出？"] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
        [customAlertView show];
        

        
    }else if(btn.tag ==999)
    {
        
        
    }else if(btn.tag ==999)
    {
        
        
    }


}
-(void)viewWillDisappear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden=YES;


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        return;
        
    }else
    {
        NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/logout",POSTREQUESTURL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [MBProgressHUD showLoadToView:self.view];
        // 拼接请求参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
        parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
        NSLog(@"parames = %@",parames);
        
        NSString *urlStringUTF8 = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:urlStringUTF8 parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:self.view];
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"退出登录请求成功JSON:%@,%@", JSON,[JSON objectForKey:@"error"]);
            //退出成功或者提示异常
            if ([[JSON objectForKey:@"success"] integerValue] == 1 || [CYSmallTools whetherLoginFails:[JSON objectForKey:@"error"] withResult:[JSON objectForKey:@"success"]])
            {
                CYLoginViewController *GoLoController = [[CYLoginViewController alloc] init];
                [self.navigationController pushViewController:GoLoController animated:YES];
            }
            else
                [MBProgressHUD showError:[JSON objectForKey:@"error"] ToView:self.view];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"退出登录请求失败:%@", error.description);
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"加载出错" ToView:self.view];
        }];
        
        
        
    }
    
    
    
    
}

//设置样式
- (void) setAccountStyle
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账户设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;

    NSLog(@"将要出现");
    [self getAccountData];

    [self.tabBarController.tabBar setHidden:YES];
}
- (void) getAccountData
{
    
    NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
    NSLog(@"dict = %@",dictT);
    if ([[dictT objectForKey:@"success"] integerValue] == 1)
    {
        
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
        ;

        self.dataAccountArray = @[[dict objectForKey:@"imgAddress"],
                                  
                                  IsNilString(([NSString stringWithFormat:@"%@",[dict objectForKey:@"nickName"]]))?@"暂无":[NSString stringWithFormat:@"%@",[dict objectForKey:@"nickName"]],
                                   IsNilString(([NSString stringWithFormat:@"%@",[dict objectForKey:@"trueName"]]))?@"暂无":[NSString stringWithFormat:@"%@", [dict objectForKey:@"trueName"]],
                                  IsNilString(([NSString stringWithFormat:@"%@",[dict objectForKey:@"idNo"]]))?@"请修改身份证":[NSString stringWithFormat:@"%@",[dict objectForKey:@"idNo"]],
                                  [[NSString stringWithFormat:@"%@",[dict objectForKey:@"sex"]]isEqualToString:@"1"]?@"男":@"女",
                                  IsNilString(([NSString stringWithFormat:@"%@",[dict objectForKey:@"age"]]))?@"请修改年龄":[NSString stringWithFormat:@"%@",[dict objectForKey:@"age"]],

                                  [NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:ACCOUNT]],
                                  @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    else
    {
        dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:PERSONALDATA]];
        self.dataAccountArray = @[[dictT objectForKey:@"imgAddress"],
                                  
                                  IsNilString(([NSString stringWithFormat:@"%@",[dictT objectForKey:@"nickName"]]))?@"暂无":[NSString stringWithFormat:@"%@",[dictT objectForKey:@"nickName"]],
                                  IsNilString(([NSString stringWithFormat:@"%@",[dictT objectForKey:@"trueName"]]))?@"暂无":[NSString stringWithFormat:@"%@", [dictT objectForKey:@"trueName"]],
                                  IsNilString(([NSString stringWithFormat:@"%@",[dictT objectForKey:@"idNo"]]))?@"请修改身份证":[NSString stringWithFormat:@"%@",[dictT objectForKey:@"idNo"]],
                                  [[NSString stringWithFormat:@"%@",[dictT objectForKey:@"sex"]]isEqualToString:@"1"]?@"男":@"女",
                                  IsNilString(([NSString stringWithFormat:@"%@",[dictT objectForKey:@"age"]]))?@"请修改年龄":[NSString stringWithFormat:@"%@",[dictT objectForKey:@"age"]],
                                  
                                  [NSString stringWithFormat:@"%@",[CYSmallTools getDataStringKey:ACCOUNT]],
                                  @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    }
    [self mainView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) personalChange:(NSString *)oldString withRow:(NSInteger)row
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    

    RealNameViewController *RNController = [[RealNameViewController alloc] init];
    RNController.typeInt = row;
    RNController.beforeString = [NSString stringWithFormat:@"%@",oldString];
    [self.navigationController pushViewController:RNController animated:YES];
}
- (void)selfCenter
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    

    SettingViewController *RNController = [[SettingViewController alloc] init];
    RNController.arry =self.dataAccountArray;
    [self.navigationController pushViewController:RNController animated:YES];

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
