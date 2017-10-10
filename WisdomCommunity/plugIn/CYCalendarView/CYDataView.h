//
//  DataView.h
//  collectionview
//
//  Created by HB on 16/1/5.
//  Copyright © 2016年 HB. All rights reserved.
//  发帖子使用日期选择器

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "LunarCalendar.h"

typedef void(^DidClicked)(NSString *);

@interface CYDataView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mainCollectionView;
}
//获取阴历日期和节日
@property (nonatomic,strong) LunarCalendar *lunarCalendar;
@property (nonatomic,strong) UICollectionReusableView *headerView;//collectionView头部
@property (nonatomic,strong) CollectionViewCell  *cell;//collectionCell
@property (nonatomic,assign) NSInteger dateInt;//日历显示的天数数据
@property (nonatomic,assign) NSInteger againInt;//一个月上面的数据
@property (nonatomic,assign) NSInteger nestInt;//一个月下面的数据

@property (nonatomic,strong) UILabel *headLabel;//头部显示时间
//左右按钮
@property (nonatomic,strong) UIButton *lastButton;//左
@property (nonatomic,strong) UIButton *nextButton;//右

@property (nonatomic,assign) NSInteger monthDays;//每个月有几天
@property (nonatomic,assign) NSInteger beginDays;//每个月的第一天

@property (nonatomic,strong) NSDate *onclickDate;//所点击变化的月份

//@property (nonatomic,strong) NSArray *SignInDataArray;//签到数据

//手势
@property (nonatomic,strong) UISwipeGestureRecognizer *leftSwipe;//左划
@property (nonatomic,strong) UISwipeGestureRecognizer *rightSwipe;//右划

@property (nonatomic, copy) DidClicked dateBlock;


//按钮点击事件
-(void)leftButton;
-(void)rightButton;
@end
