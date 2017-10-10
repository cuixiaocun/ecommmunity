//
//  ZLCGuidePageView.h
//  GuidePage_Test
//
//  Created by shining3d on 16/6/7.
//  Copyright © 2016年 shining3d. All rights reserved.
//  引导页

#import <UIKit/UIKit.h>

@interface ZLCGuidePageView : UIView<UIScrollViewDelegate>



@property UIPageControl *imagePageControl;
@property UIScrollView  *guidePageView;



- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images;


@end
