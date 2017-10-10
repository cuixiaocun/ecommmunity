//
//  SettingViewController.m
//  WisdomCommunity
//
//  Created by Admin on 2017/4/29.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "SettingViewController.h"
#import "OpinionsSuggestionsViewController.h"
#import "AboutUsViewController.h"
@interface SettingViewController ()
{

    UIView *bgview ;
}

@end

@implementation SettingViewController
-(void)viewWillAppear:(BOOL)animated
{

    [self.tabBarController.tabBar setHidden:YES];
    [self getAccountData ];


}
- (void)mainView
{

    bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CYScreanH, CXCScreanH)];
    [self.view addSubview:bgview];
    
    
    self.view.backgroundColor = BGColor;
    self.navigationItem.title = @"个人信息";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSArray *wzBtnArray = @[@"头像",@"用户名",@"真实姓名"];
    for (int i =0; i<3; i++) {
        //按钮
        UIButton *gnBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [gnBtn setFrame:CGRectMake(0,20*CXCWidth+CXCWidth*100*i,CYScreanW,CXCWidth*100)];
        [gnBtn setBackgroundColor:[UIColor whiteColor]];
        [gnBtn setTag:i+10];
        [gnBtn addTarget:self action:@selector(shezhi:) forControlEvents:UIControlEventTouchUpInside];
        gnBtn.tag =i+444;
        [bgview addSubview:gnBtn];
        //左边
        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(32*CXCWidth,0, 500*CXCWidth, 99*CXCWidth)];
        labe.textColor = TEXTColor;
        labe.text = wzBtnArray[i];
        labe.font = [UIFont systemFontOfSize:16];
        [gnBtn   addSubview:labe];
        //箭头
        UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*CXCWidth, 25*CXCWidth,30*CXCWidth , 50*CXCWidth)];
        [gnBtn addSubview:jiantou];
        [jiantou setImage:[UIImage imageNamed:@"icon_shezhi_next"]];
        
        UIView *hengxian = [[UIView alloc]initWithFrame:CGRectMake(32*CXCWidth,99*CXCWidth, CYScreanW, 1*CXCWidth)];
        [gnBtn addSubview:hengxian];
        hengxian.backgroundColor = BGColor;
        
        //右边
        if (i==0) {
            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(600*CXCWidth, 18*CXCWidth, 64*CXCWidth, 64*CXCWidth)];
            NSString *headString = [NSString stringWithFormat:@"%@",self.arry[0]];
            [img sd_setImageWithURL:[NSURL URLWithString:headString.length > 6 ? headString : @""] placeholderImage:nil];
            img.layer.cornerRadius =32*CXCWidth;
            [gnBtn addSubview:img];
        }else
        {
            //右边文字
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(300*CXCWidth, 0, 370*CXCWidth, 99*CXCWidth)];
            label2.text = [NSString stringWithFormat:@"%@",self.arry[i]];
            label2.textColor = TextGroColor;
            label2.textAlignment =NSTextAlignmentRight;
            label2.font = [UIFont systemFontOfSize:15];
            [gnBtn addSubview:label2];
            
            
        }
        
        
        
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [bgview removeFromSuperview];
    
    
}
-(void)shezhi:(UIButton*)btn
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    

    if (btn.tag==444) {
        SetHeadViewController *SHAController = [[SetHeadViewController alloc] init];
        SHAController.headString = [NSString stringWithFormat:@"%@",_arry[0]];
        [self.navigationController pushViewController:SHAController animated:YES];

    }else if (btn.tag == 445)
    {
        SetGeneralAcInforViewController *SGAController = [[SetGeneralAcInforViewController alloc] init];
        SGAController.promptString = self.arry[1];
        [self.navigationController pushViewController:SGAController animated:YES];
    }else
    {
        [self personalChange:self.arry[2] withRow:2];

        
        
       }

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) getAccountData
{
    NSDictionary *dictT = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:ACCOUNTDATA]];
    NSLog(@"dict = %@",dictT);
    if ([[dictT objectForKey:@"success"] integerValue] == 1)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[dictT objectForKey:@"returnValue"]];
        self.arry= @[[dict objectForKey:@"imgAddress"],
                     
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
        self.arry= @[[dictT objectForKey:@"imgAddress"],
                     
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
