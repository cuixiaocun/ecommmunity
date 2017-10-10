//
//  CollectionViewCell.h
//  collectionview
//
//  Created by HB on 16/1/5.
//  Copyright © 2016年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *botlabel;//显示日期数据
@property (nonatomic,strong) UILabel *dayLabel;//显示阴历和传统节日
@property (nonatomic,strong) UIImageView *backImageView;//背景图片


@end
