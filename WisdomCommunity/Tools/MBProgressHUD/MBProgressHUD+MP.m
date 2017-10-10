//
//  NSObject+MP.m
//  MobileProject
//
//  Created by wujunyang on 16/7/9.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "MBProgressHUD+MP.h"

@implementation MBProgressHUD (MP)

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error ToView:(UIView *)view{
    [self showCustomIcon:@"MBHUD_Error" Title:error ToView:view];
}

+ (void)showSuccess:(NSString *)success ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Success" Title:success ToView:view];
}

+ (void)showInfo:(NSString *)Info ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Info" Title:Info ToView:view];
}

+ (void)showWarn:(NSString *)Warn ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Warn" Title:Warn ToView:view];
}

#pragma mark 显示一些信息
//+ (MBProgressHUD *)showMessage:(NSString *)message ToView:(UIView *)view {
//    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
//    
//    //动态图
//    UIImageView *gitImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"an_001"]];
//    gitImgView.animationImages = [NSArray arrayWithArray:[CYSmallTools getArrData:LOADANIMATION]];;//将序列帧数组赋给UIImageView的animationImages属性
//    gitImgView.animationDuration = 0.5;//设置动画时间
//    gitImgView.animationRepeatCount = 0;//设置动画次数 0 表示无限
//    [gitImgView startAnimating];//开始播放动画
//    UIView *customerView = [[UIView alloc]initWithFrame:CGRectMake(CYScreanW * 0.4, CYScreanH * 0.5, gitImgView.frame.size.width, gitImgView.frame.size.width)];
//    [customerView addSubview:gitImgView];
//    // 快速显示一个提示信息
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.mode=MBProgressHUDModeCustomView;
//    hud.customView = customerView;
////    hud.labelText=message;
////    hud.labelFont=[UIFont fontWithName:@"Heiti SC" size:15];
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    //代表需要蒙版效果
//    hud.dimBackground = NO;
//    //hud.labelColor = [UIColor grayColor];
//    //任务进行中
//    hud.taskInProgress = YES;
//    [hud show:YES];
//    //自定义显示的view
//    hud.customView = customerView;
//    //透明度
//    hud.opacity = 0.0;
//    //设置HUD和customerView的边距（默认是20）
//    hud.margin = 10.0f;
//    hud.yOffset = -20.0f;
//    
//    
//    return hud;
//}

//加载视图
+(void)showLoadToView:(UIView *)view{
//    [self showMessage:@"加载中..." ToView:view];
}


/**
 *  进度条View
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view Text:(NSString *)text{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText=text;
    hud.labelFont=[UIFont fontWithName:@"Heiti SC" size:15];
    // 代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}


//快速显示一条提示信息
+ (void)showAutoMessage:(NSString *)message{
    
    [self showAutoMessage:message ToView:nil];
}


//自动消失提示，无图
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view{
    [self showMessage:message ToView:view RemainTime:1 Model:MBProgressHUDModeText];
}

//自定义停留时间，有图
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeIndeterminate];
}

//自定义停留时间，无图
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeText];
}

+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time Model:(MBProgressHUDMode)model{
    
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText=message;
    hud.labelFont=[UIFont fontWithName:@"Heiti SC" size:15];
    //模式
    hud.mode = model;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 代表需要蒙版效果
    hud.dimBackground = YES;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // X秒之后再消失
    [hud hide:YES afterDelay:time];
    
}
+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText=title;
    hud.detailsLabelText = title;

    hud.detailsLabelFont=[UIFont fontWithName:@"Heiti SC" size:15];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 代表需要蒙版效果
    hud.dimBackground = NO;
    
    // 3秒之后再消失
    [hud hide:YES afterDelay:1];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


@end
