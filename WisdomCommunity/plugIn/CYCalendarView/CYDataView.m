//
//  DataView.m
//  collectionview
//
//  Created by HB on 16/1/5.
//  Copyright © 2016年 HB. All rights reserved.
//

#import "CYDataView.h"

@implementation CYDataView

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
    layout.itemSize = CGSizeMake(CYScreanW /10, 50);//？??????
    
    //3\初始化collextionVIewCell
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self addSubview:mainCollectionView];
    mainCollectionView.scrollEnabled = NO;
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [mainCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
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
    [mainCollectionView addGestureRecognizer:self.leftSwipe];
    [mainCollectionView addGestureRecognizer:self.rightSwipe];
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
        //阴历
        NSString* timeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",[self year:self.onclickDate],[self month:self.onclickDate],self.dateInt];
        NSLog(@"%ld-%ld-%ld",[self year:self.onclickDate],[self month:self.onclickDate],self.dateInt);
        NSString *stringPinJie = [NSString stringWithFormat:@"%@ 00:00:00",timeStr];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//创建日期格式1449793788
        NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/BeiJing"];
        [formatter setTimeZone:timezone];
        NSDate* date = [formatter dateFromString:stringPinJie];
        //调用方法
        self.lunarCalendar = [[LunarCalendar alloc] init];
        //    NSLog(@"%d",[self.lunarCalendar GregorianYear]);
        [self.lunarCalendar loadWithDate:date];
        [self.lunarCalendar InitializeValue];
        NSLog(@"年：%@，月：%@，日：%@，节日：%@，生肖:%@。",_lunarCalendar.yearString,_lunarCalendar.monthString,_lunarCalendar.dayString,_lunarCalendar.holidayString,_lunarCalendar.zodiacLunarString);
        if ([_lunarCalendar.dayString isEqualToString:@"1"]) {
            //_cell.dayLabel.text = [NSString stringWithFormat:@"%@月",_lunarCalendar.monthString];;//显示阴历
        }
        else
        {
            int day = [_lunarCalendar.dayString intValue];
            NSLog(@"day = %d",day);
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
            NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:day]];
            NSLog(@"string = %@",string);
            //_cell.dayLabel.text = [NSString stringWithFormat:@"%@",string];;//显示阴历
        }
        
        //显示阳历
        if (self.dateInt <= 9)
        {
            _cell.botlabel.text = [NSString stringWithFormat:@"0%ld",self.dateInt];
        }
        else
            _cell.botlabel.text = [NSString stringWithFormat:@"%ld",self.dateInt];
        self.dateInt ++;
        NSString *text = [NSString stringWithFormat:@"%@",_cell.botlabel.text];
        //当前日期
        if ([text integerValue] == [self day:self.onclickDate])
        {
            _cell.botlabel.textColor = [UIColor redColor];
        }
    }
    else
    {
        //_cell.dayLabel.text = @"";
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
    self.headLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld",[self year:self.onclickDate],[self month:self.onclickDate],[self day:self.onclickDate]];
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
    if (self.dateBlock) {
        self.dateBlock([NSString stringWithFormat:@"%ld-%@-%@",[self year:self.onclickDate],month ,msg]);
    }
    self.headLabel.font = [UIFont fontWithName:@"Arial" size:17];
    [_headerView addSubview:self.headLabel];
}
//左按钮
-(void)leftButton
{
    NSLog(@"左这个月有几天:%ld,第一天是周几:%ld。",[self totaldaysInThisMonth:[self lastMonth:self.onclickDate]],[self firstWeekdayInThisMonth:[self lastMonth:self.onclickDate]]);
    NSLog(@"所在日期：%@",self.onclickDate);
    //显示月开始周几
    self.beginDays = [self firstWeekdayInThisMonth:[self lastMonth:self.onclickDate]];
    //显示月天数
    self.monthDays = [self totaldaysInThisMonth:[self lastMonth:self.onclickDate]];
    //显示数据重新赋值
    self.dateInt = 1;
    //    self.nestInt = 1;
    //点击做按钮，获取下个月数据作为目标主体
    self.onclickDate = [self lastMonth:self.onclickDate];
    //刷新数据
    [mainCollectionView reloadData];
}
//右按钮
-(void)rightButton
{
    NSLog(@"右这个月有几天:%ld,第一天是周几:%ld。",[self totaldaysInThisMonth:[self nextMonth:self.onclickDate]],[self firstWeekdayInThisMonth:[self nextMonth:self.onclickDate]]);
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
    //刷新数据
    [mainCollectionView reloadData];
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
    return CGSizeMake(37*CYScreanW/375, 20*CYScreanW/375);
}
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
        //刷新数据
        [mainCollectionView reloadData];
        
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
        
        //刷新数据
        [mainCollectionView reloadData];
        NSLog(@"右划");
    }
}
@end
