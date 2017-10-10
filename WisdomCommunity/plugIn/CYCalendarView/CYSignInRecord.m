//
//  CYSignInRecord.m
//  WisdomCommunity
//
//  Created by bridge on 17/2/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "CYSignInRecord.h"

@implementation CYSignInRecord

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.294 green:0.533 blue:0.871 alpha:1.00];
    }
    [self collection];
    return self;
}
-(void)collection
{
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionview滚动方向
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 40);
    //该方法也可以设置itemSize
    layout.itemSize = CGSizeMake(CYScreanW /10, 50);//底下调整了上面的就不管用了
    
    //3\初始化collextionVIewCell
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self addSubview:_mainCollectionView];
    _mainCollectionView.scrollEnabled = NO;
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [_mainCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    
    //初始化数据
    NSDate *date = [NSDate date];
    self.onclickDate = [NSDate date];
    //初始化为1
    self.dateInt = 1;//日历要显示的数据
    //    self.nestInt = 1;//下一个月的灰色数据
    self.beginDays = [self firstWeekdayInThisMonth:date];//显示月的第一天周几
    self.monthDays = [self totaldaysInThisMonth:date];//显示月的天数
    //添加手势事件
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;//滑动方向:左
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;//滑动方向:右
    [_mainCollectionView addGestureRecognizer:self.leftSwipe];
    [_mainCollectionView addGestureRecognizer:self.rightSwipe];
    
    
    
    
    //    NSLog(@"day:%ld,month:%ld,year:%ld",[self day:date],[self month:date],[self year:date]);
    //    NSLog(@"lastMonth:%@",[self lastMonth:date]);
    //    NSLog(@"nextMonth:%@",[self nextMonth:date]);
    //    NSLog(@"上有几天:%ld,第一天是周几:%ld。",[self totaldaysInThisMonth:[self lastMonth:date]],[self firstWeekdayInThisMonth:[self lastMonth:date]]);
    //    NSLog(@"下有几天:%ld,第一天是周几:%ld。",[self totaldaysInThisMonth:[self nextMonth:date]],[self firstWeekdayInThisMonth:[self nextMonth:date]]);
    
}


//代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 49;
}
//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    //星期数据源
    NSArray *arrayWeak = [NSArray arrayWithObjects: @"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    _cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    _cell.botlabel.textColor = [UIColor colorWithRed:0.514 green:0.541 blue:0.541 alpha:1.00];
    _cell.botlabel.font = font;
    //隐藏背景
    _cell.backImageView.hidden = YES;
    if (indexPath.row < 7)
    {
        _cell.botlabel.text = arrayWeak[indexPath.row];
        _cell.botlabel.textColor = [UIColor colorWithRed:0.514 green:0.541 blue:0.541 alpha:1.00];
        _cell.dayLabel.text = @"";
    }
    else if (indexPath.row < self.beginDays + 7)
    {
        _cell.botlabel.text = @"";
        _cell.dayLabel.text = @"";
    }
    else if(self.dateInt <= self.monthDays)
    {
        //显示阳历
        if (self.dateInt <= 9)
        {
            _cell.botlabel.text = [NSString stringWithFormat:@"0%d",self.dateInt];
        }
        else
            _cell.botlabel.text = [NSString stringWithFormat:@"%d",self.dateInt];
        self.dateInt ++;
        NSString *text = [NSString stringWithFormat:@"%@",_cell.botlabel.text];
        //将签到日期显示出来
        if([self.SignInDataArray containsObject: text])
        {
            NSLog(@"text = %@",text);
            _cell.backImageView.hidden = NO;
            _cell.botlabel.textColor = [UIColor whiteColor];
        }
    }
    else
    {
        _cell.dayLabel.text = @"";
        _cell.botlabel.text = [NSString stringWithFormat:@""];
    }
    return _cell;
}
//每次刷新都是走，通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *view in self.headerView.subviews)//防止复用，先将之前的清除
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
        }
    }
    self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    _headerView.backgroundColor = [UIColor grayColor];
    //日期显示
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headerView.bounds.size.width * 0.25, 5 , _headerView.bounds.size.width * 0.5, 30)];
    if ([self month:self.onclickDate] < 10)
    {
        self.headLabel.text = [NSString stringWithFormat:@"%ld-0%ld",[self year:self.onclickDate],[self month:self.onclickDate]];
    }
    else
        self.headLabel.text = [NSString stringWithFormat:@"%ld-%ld",[self year:self.onclickDate],[self month:self.onclickDate]];
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    self.headLabel.font = [UIFont fontWithName:@"Arial" size:17];
    [_headerView addSubview:self.headLabel];
    //左右按钮
    self.lastButton = [[UIButton alloc] initWithFrame:CGRectMake(_headerView.bounds.size.width * 0.05, 0, _headerView.bounds.size.width * 0.2, 40)];
    [self.lastButton setImage:[UIImage imageNamed:@"bt_previous.png"] forState:UIControlStateNormal];
    [self.lastButton addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:self.lastButton];
    
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(_headerView.bounds.size.width * 0.75, 0, _headerView.bounds.size.width * 0.2, 40)];
    [self.nextButton setImage:[UIImage imageNamed:@"bt_next.png"] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:self.nextButton];
    return _headerView;
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.botlabel.text;
    NSLog(@"msg = %@",msg);
    
    //改变点中的时间颜色
    //    for (UIView *view in self.cell.subviews)
    //    {
    //        cell.botlabel.backgroundColor = [UIColor clearColor];
    //        if ([cell.botlabel.text integerValue] != [msg integerValue]) {
    //            cell.botlabel.backgroundColor = [UIColor whiteColor];
    //        }
    //    }
    
    //因为此处点击不牵扯到刷新问题，所以可以将之前的清除然后新建
    for (UIView *view in self.headerView.subviews)//防止复用，先将之前的清除
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
        }
    }
    //日期显示
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headerView.bounds.size.width * 0.25, 5 , _headerView.bounds.size.width * 0.5, 30)];
    self.headLabel.text = [NSString stringWithFormat:@"%ld-%ld-%@",[self year:self.onclickDate],[self month:self.onclickDate],msg];
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    NSString *month = [self month:self.onclickDate] > 9 ? [NSString stringWithFormat:@"%ld",[self month:self.onclickDate]] : [NSString stringWithFormat:@"0%ld",[self month:self.onclickDate]];
    self.headLabel.font = [UIFont fontWithName:@"Arial" size:17];
    [_headerView addSubview:self.headLabel];
    
    
    
}
//手势事件函数
-(void) handleSwipes:(UISwipeGestureRecognizer *)sender
{
    //判断左划
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        //显示月开始周几
        self.beginDays = [self firstWeekdayInThisMonth:[self nextMonth:self.onclickDate]];
        //显示月的天数
        self.monthDays = [self totaldaysInThisMonth:[self nextMonth:self.onclickDate]];
        //显示数据重新赋值
        self.dateInt = 1;
        self.nestInt = 1;
        //点击按钮，使点击月为目的主体
        self.onclickDate = [self nextMonth:self.onclickDate];
        [self SetSignInData];//设置签到记录数据
        //刷新数据
        [_mainCollectionView reloadData];
        
        NSLog(@"左划");
    }
    //判断右划
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        //显示月开始周几
        self.beginDays = [self firstWeekdayInThisMonth:[self lastMonth:self.onclickDate]];
        //显示月天数
        self.monthDays = [self totaldaysInThisMonth:[self lastMonth:self.onclickDate]];
        //显示数据重新赋值
        self.dateInt = 1;
        //    self.nestInt = 1;
        //点击做按钮，获取下个月数据作为目标主体
        self.onclickDate = [self lastMonth:self.onclickDate];
        [self SetSignInData];//设置签到记录数据
        //刷新数据
        [_mainCollectionView reloadData];
        NSLog(@"右划");
    }
    if (self.dateYearBlock)
    {
        self.dateYearBlock([NSString stringWithFormat:@"%d",[self year:self.onclickDate]],self.onclickDate);
    }
}

//左按钮
-(void)leftButton
{
    //显示月开始周几
    self.beginDays = [self firstWeekdayInThisMonth:[self lastMonth:self.onclickDate]];
    //显示月天数
    self.monthDays = [self totaldaysInThisMonth:[self lastMonth:self.onclickDate]];
    //显示数据重新赋值
    self.dateInt = 1;
    //    self.nestInt = 1;
    //点击做按钮，获取下个月数据作为目标主体
    self.onclickDate = [self lastMonth:self.onclickDate];
    [self SetSignInData];//设置签到记录数据
    //刷新数据
    [_mainCollectionView reloadData];
    if (self.dateYearBlock)
    {
        self.dateYearBlock([NSString stringWithFormat:@"%d",[self year:self.onclickDate]],self.onclickDate);
    }
}

//右按钮
-(void)rightButton
{
    NSLog(@"所在日期：%@",self.onclickDate);
    //显示月开始周几
    self.beginDays = [self firstWeekdayInThisMonth:[self nextMonth:self.onclickDate]];
    //显示月的天数
    self.monthDays = [self totaldaysInThisMonth:[self nextMonth:self.onclickDate]];
    //显示数据重新赋值
    self.dateInt = 1;
    self.nestInt = 1;
    //点击按钮，使点击月为目的主体
    self.onclickDate = [self nextMonth:self.onclickDate];
    [self SetSignInData];//设置签到记录数据
    //刷新数据
    [_mainCollectionView reloadData];
    if (self.dateYearBlock)
    {
        self.dateYearBlock([NSString stringWithFormat:@"%d",[self year:self.onclickDate]],self.onclickDate);
    }
}
//刷新
- (void) reloadDataView:(NSDate *)date
{
    //初始化为1
    self.dateInt = 1;//日历要显示的数据
    //    self.nestInt = 1;//下一个月的灰色数据
    self.beginDays = [self firstWeekdayInThisMonth:date];//显示月的第一天周几
    self.monthDays = [self totaldaysInThisMonth:date];//显示月的天数
    [self SetSignInData];//设置签到记录数据
    //刷新数据
    [_mainCollectionView reloadData];
}
//设置签到记录数据
- (void) SetSignInData
{
    self.SignInDataArray = [[NSArray alloc] init];
    for (NSDictionary *dict in self.SignInAllDataArray)
    {
//        NSDictionary *dict = @{@"Year":year,@"YearData":yearArray};
        if ([[dict objectForKey:@"Year"] integerValue] == [self year:self.onclickDate])
        {
            NSMutableArray *arrayYear = [dict objectForKey:@"YearData"];//年数据
            for (NSDictionary *yearDict in arrayYear)
            {
                if ([[yearDict objectForKey:@"month"] integerValue] == [self month:self.onclickDate])
                {
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    [array addObjectsFromArray:[yearDict objectForKey:@"data"]];
                    self.SignInDataArray = [NSArray arrayWithArray:array];
                }
            }
        }
    }
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(([UIScreen mainScreen].bounds.size.height == 480)||([UIScreen mainScreen].bounds.size.width == 320))
    {
        return CGSizeMake(30*CYScreanW/375, 20*CYScreanW/375);
        
        
        
    }else if(([UIScreen mainScreen].bounds.size.width == 375))
    {
        
        return CGSizeMake(36*CYScreanW/375, 20*CYScreanW/375);
        
        
    }

    return CGSizeMake(37*CYScreanW/375, 20*CYScreanW/375);}
//设置每个item四周的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5*CYScreanW/375, 10*CYScreanW/375, 5*CYScreanW/375, 10*CYScreanW/375);
}

//这个月的第一天是周几
-(NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)  fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}
//这个月有几天
-(NSInteger)totaldaysInThisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth =[[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

//现在是这个月的第几天天
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//现在是今年的第几个月
- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}
//现在是哪一年
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
//上个月的,对应今天
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
//下个月的，对应今天
- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


@end
