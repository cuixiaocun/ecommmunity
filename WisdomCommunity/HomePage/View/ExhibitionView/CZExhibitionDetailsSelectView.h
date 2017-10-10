//
//  CZExhibitionDetailsSelectView.h
//  WisdomCommunity
//
//  Created by mac on 2016/12/28.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DetailsDidCliceked)(UIButton *, NSInteger);

@interface CZExhibitionDetailsSelectView : UIView

@property ( nonatomic, copy)DetailsDidCliceked detailsSelectIndex;
@property ( nonatomic, assign) BOOL     defaultSelect;
@property ( nonatomic, strong) UIButton *detailsButton;
@property ( nonatomic, strong) UIButton *commentsButton;
@property ( nonatomic, strong) UIView   *blueView;
- (void)setTitleWithOne:(NSString *)one andTwo:(NSString *)two;

- (void)changeBlueView;

@end
