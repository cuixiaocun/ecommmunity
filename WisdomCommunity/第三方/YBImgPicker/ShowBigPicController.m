//
//  ShowBigPicController.m
//  Demo_simple
//
//  Created by Developer on 15/11/3.
//  Copyright (c) 2015年 rain. All rights reserved.
//

#import "ShowBigPicController.h"
@interface ShowBigPicController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    NSInteger index ;
}
@end

@implementation ShowBigPicController
{
//    NSArray *picUrlArr;
    UIImageView *topImageView;
    
    UIScrollView *bigScrollView;//展示大图
    UILabel *pageLabel;//显示页码
    CGFloat lastScale;

}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =NO;

}
- (void)returnBtnAction
{
    
    
    if (_isXiangce ==YES) {
        //发通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tupian" object:_picUrlArr];

    }else
    {
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tupian" object:_picUrlArr];

    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    
    index =1;
    [super viewDidLoad];
    //替代导航栏的imageview
    topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CYScreanW,64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:.8];
    [self.view addSubview:topImageView];
    //nameArr = @[@"版本检测",@"意见反馈",@"用户帮助",@"用户协议",@"隐私条款"];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(5, 20, 44, 44);
//    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 10,6, 90)];    //    returnBtn.backgroundColor = [UIColor cyanColor];
    [returnBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    //    [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 20, CYScreanW, 44)];
    [navTitle setText:@"相册展示"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont systemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    
    
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setFrame:CGRectMake(260/320.0*CYScreanW, 20, 55, 44)];
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //                [btn setImage:[UIImage imageNamed:@"navigation_jiantou"] forState:UIControlStateNormal];
    //            [btn addSubview:jiantouImg];
    [btn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    [self.view addSubview:navTitle];
        
    
    bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topImageView.bottom, CYScreanW, self.view.height-topImageView.height)];
    bigScrollView.contentSize = CGSizeMake(CYScreanW*_picUrlArr.count, bigScrollView.height);

    bigScrollView.backgroundColor = [UIColor blackColor];
    bigScrollView.pagingEnabled = YES;
    bigScrollView.delegate = self;
    for (int i=0; i<_picUrlArr.count; i++) {
        EGOImageView *picImageV = [[EGOImageView alloc]initWithFrame:CGRectMake(CYScreanW*i, 0, CYScreanW, bigScrollView.height)];
        if (_isXiangce==YES) {
//            [picImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_picUrlArr[i]]]];
            [picImageV setImage:_picUrlArr[i]];
        }else
        {
            [picImageV setImageURL:_picUrlArr[i]];
            

        }
        
        picImageV.contentMode = UIViewContentModeScaleAspectFit;
    
        [bigScrollView addSubview:picImageV];
    }
    
    pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.height-50, CYScreanW, 40)];
    pageLabel.text = [NSString stringWithFormat:@"1/%d",_picUrlArr.count];
//    pageLabel.backgroundColor = [UIColor redColor];
    pageLabel.textColor = [UIColor whiteColor];
    pageLabel.font = [UIFont systemFontOfSize:18];
    pageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bigScrollView];
    [self.view addSubview:pageLabel];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%.1f",scrollView.contentOffset.x);
    NSInteger offSet = scrollView.contentOffset.x;
     index = offSet/CYScreanW+1;
    pageLabel.text = [NSString stringWithFormat:@"%d/%d",index,_picUrlArr.count];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)rightBtnPressed
{
    if (_picUrlArr.count==0) {
        [self returnBtnAction];
        return;
    }
    [_picUrlArr removeObjectAtIndex: index-1];
    [bigScrollView removeFromSuperview];

//    [[NSNotificationCenter defaultCenter]postNotificationName:@"tupian" object:[NSString stringWithFormat:@"%d",index]];//注销

    
    bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topImageView.bottom, CYScreanW, self.view.height-topImageView.height)];
    bigScrollView.contentSize = CGSizeMake(CYScreanW*_picUrlArr.count, bigScrollView.height);
    index=1;
    bigScrollView.backgroundColor = [UIColor blackColor];
    bigScrollView.pagingEnabled = YES;
    bigScrollView.delegate = self;
    for (int i=0; i<_picUrlArr.count; i++) {
        
        EGOImageView *picImageV = [[EGOImageView alloc]initWithFrame:CGRectMake(CYScreanW*i, 0, CYScreanW, bigScrollView.height)];
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaGesture:)];
        [pinchRecognizer setDelegate:self];
        [picImageV addGestureRecognizer:pinchRecognizer];
        picImageV.contentMode =UIViewContentModeScaleAspectFit;
        picImageV.userInteractionEnabled =YES;
        


        if (_isXiangce==YES) {
            //            [picImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_picUrlArr[i]]]];
            [picImageV setImage:_picUrlArr[i]];
        }else
        {
            //            [picImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_URL,_picUrlArr[i]]]];
            [picImageV setImageURL:_picUrlArr[i]];

        }
        
        picImageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [bigScrollView addSubview:picImageV];
    }
    
    pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.height-50, CYScreanW, 40)];
    pageLabel.text = [NSString stringWithFormat:@"1/%d",_picUrlArr.count];
    //    pageLabel.backgroundColor = [UIColor redColor];
    pageLabel.textColor = [UIColor whiteColor];
    pageLabel.font = [UIFont systemFontOfSize:18];
    pageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bigScrollView];
    [self.view addSubview:pageLabel];

    
    
    
    
}
//3.在加入这个手势的执行方法
-(void)scaGesture:(id)sender {
    [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
    //当手指离开屏幕时,将lastscale设置为1.0
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [[(UIPinchGestureRecognizer*)sender view]setTransform:newTransform];
    lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

//4. 加入手势的代理方法
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
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
