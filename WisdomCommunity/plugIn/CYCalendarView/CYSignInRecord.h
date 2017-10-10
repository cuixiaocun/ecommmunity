//
//  CYSignInRecord.h
//  WisdomCommunity
//
//  Created by bridge on 17/2/20.
//  Copyright © 2017年 bridge. All rights reserved.
//  签到记录

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "LunarCalendar.h"

typedef void(^DidYearClicked)(NSString *,NSDate *);

@interface CYSignInRecord : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
//{
//    UICollectionView *mainCollectionView;
//}
@property (nonatomic,strong) UICollectionView *mainCollectionView;
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

@property (nonatomic,strong) NSArray *SignInAllDataArray;//签到数据
@property (nonatomic,strong) NSArray *SignInDataArray;//签到数据

//手势
@property (nonatomic,strong) UISwipeGestureRecognizer *leftSwipe;//左划
@property (nonatomic,strong) UISwipeGestureRecognizer *rightSwipe;//右划

@property (nonatomic, copy) DidYearClicked dateYearBlock;


//按钮点击事件
-(void)leftButton;
-(void)rightButton;
//刷新事件
- (void) reloadDataView:(NSDate *)date;

@end
