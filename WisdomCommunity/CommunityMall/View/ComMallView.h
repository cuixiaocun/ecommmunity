//
//  ComMallView.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/7.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区商城按钮

#import <UIKit/UIKit.h>
#import "ComMallCollectionViewCell.h"
//协议
@protocol OnClickCMallDelegate <NSObject>
- (void) TakeOutFood;//外卖
- (void) supermarketFunction;//超市
- (void) microShop;//微店
- (void) groupPurchase;//团购
- (void) foodMarket;//菜市场
@end
@interface ComMallView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mainCMallCollectionView;
}



@property (nonatomic,strong) ComMallCollectionViewCell  *cell;
@property (nonatomic,weak) id<OnClickCMallDelegate> CMallDelegate;//协议

//图片数组
@property (nonatomic,strong) NSArray *iconMCVArray;
@property (nonatomic,strong) NSArray *promptMCVArray;

@end
