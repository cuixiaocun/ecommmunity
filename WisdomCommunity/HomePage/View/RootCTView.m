//
//  RootCTView.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "RootCTView.h"

@implementation RootCTView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self collection];
    return self;
}
-(void)collection
{
    //初始化图片数组
    _iconArray = [NSArray arrayWithObjects:@"icon_PropertyManager",@"icon_mall",@"icon_repair",@"icon_notice",@"icon_advise",@"icon_forum",nil];
    self.promptArray = @[@"物业管家",@"社区商城",@"物业报修",@"社区公告",@"投诉建议",@"社区大小事"];
    //设置背景颜色
    self.backgroundColor = [UIColor clearColor];
    //1\初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionview滚动方向
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //2\设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(0, 0);
    
    
    //3\初始化collextionVIewCell
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self addSubview:mainCollectionView];
    [mainCollectionView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"底色"]]];
    
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier必须和cellForItemAtIndexPath方法中一致，必须为cellId
    [mainCollectionView registerClass:[RootCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView 此处的ReuseiDentifier必须个cellForItemAtIndexPath方法中一致，均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
    mainCollectionView.scrollEnabled = NO;
    
    
}

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//返回section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
//设置每个方块的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CYScreanW * 0.34 / 3,(CYScreanH - 64) * 0.14);
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CYScreanW * 0.165;
}
//设置每个item四周的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake( 0, CYScreanW * 0.145, 0, CYScreanW * 0.145);
}

//每个cell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = (RootCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        _cell.topImage.image = [UIImage imageNamed:_iconArray[indexPath.row]];
        _cell.promtpLabel.text = [NSString stringWithFormat:@"%@",self.promptArray[indexPath.row]];
    }
    else
    {
        _cell.topImage.image = [UIImage imageNamed:_iconArray[indexPath.row + 3]];
        _cell.promtpLabel.text = [NSString stringWithFormat:@"%@",self.promptArray[indexPath.row + 3]];
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
            [self.delegate propertyHousekeeper];
        }
        else if (indexPath.row == 1)
        {
            [self.delegate communityMall];
        }
        else if (indexPath.row == 2)
        {
            [self.delegate propertyService];
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            [self.delegate communityPAnnouncement];
        }
        else if (indexPath.row == 1)
        {
            [self.delegate complaintsSuggestions];
        }
        else if (indexPath.row == 2)
        {
            [self.delegate CommunityActiveBBS];
        }
    }
 
}



@end
