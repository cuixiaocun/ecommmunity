//
//  PropertyCVCView.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "PropertyCVCView.h"

@implementation PropertyCVCView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self collectionCV];
    return self;
}
-(void)collectionCV
{
    //初始化图片数组
    _iconPCVArray = [NSArray arrayWithObjects:@"icon_propertyfee",@"icon_repair",@"icon_aroundarea",@"icon_advise",@"icon_life-service",@"icon_payment_disabled",nil];
    self.promptPCVArray = @[@"物业缴费",@"物业报修",@"周边",@"投诉建议",@"生活服务",@"缴费服务"];
    //设置背景颜色
    self.backgroundColor = [UIColor clearColor];
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionview滚动方向
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(0, 0);
    
    
    //3\初始化collextionVIewCell
    mainPCVCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self addSubview:mainPCVCollectionView];
    [mainPCVCollectionView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"底色"]]];
    
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [mainPCVCollectionView registerClass:[PropertyCollectionViewCell class] forCellWithReuseIdentifier:@"cellPCVId"];
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [mainPCVCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置代理
    mainPCVCollectionView.delegate = self;
    mainPCVCollectionView.dataSource = self;
    
    mainPCVCollectionView.scrollEnabled = NO;
    
    
}

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }
    else
        return 2;
    
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CYScreanW * 0.12,CYScreanW * 0.12 + (CYScreanH - 64) * 0.06);
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CYScreanW * 0.104;
}
//设置每个item四周的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake( 0, CYScreanW * 0.104, 0, CYScreanW * 0.104);
}

//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = (PropertyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellPCVId" forIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        _cell.topPImage.image = [UIImage imageNamed:_iconPCVArray[indexPath.row]];
        _cell.promtpPLabel.text = [NSString stringWithFormat:@"%@",self.promptPCVArray[indexPath.row]];
    }
    else
    {
        _cell.topPImage.image = [UIImage imageNamed:_iconPCVArray[indexPath.row + 4]];
        _cell.promtpPLabel.text = [NSString stringWithFormat:@"%@",self.promptPCVArray[indexPath.row + 4]];
    }
    
    
    _cell.backgroundColor = [UIColor clearColor];
    return _cell;
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
    
    //    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            [self.PCVDelegate propertyPayment];
        }
        else if (indexPath.row == 1)
        {
            [self.PCVDelegate propertyManagementService];
        }
        else if (indexPath.row == 2)
        {
            [self.PCVDelegate surrounding];
        }
        else if (indexPath.row == 3)
        {
            [self.PCVDelegate complaintsPCVSuggestions];
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            [self.PCVDelegate lifeService];
        }
        else if (indexPath.row == 1)
        {
            [self.PCVDelegate billPayment];
        }
    }
    
}


@end
