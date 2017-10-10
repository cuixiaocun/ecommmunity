//
//  CZExhibitionDetailsSelectView.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/28.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "CZExhibitionDetailsSelectView.h"

@interface CZExhibitionDetailsSelectView ()



@end



@implementation CZExhibitionDetailsSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.defaultSelect = YES;
        [self initExhibitionDetailsView];
    }
    return self;
}

- (void)initExhibitionDetailsView
{
    self.detailsButton   = [[UIButton alloc] init];
    self.commentsButton  = [[UIButton alloc] init];
    UIView *segmentation = [[UIView alloc] init];
    UIView *bottom       = [[UIView alloc] init];
    self.blueView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0,CYScreanW/2, 1*CXCWidth)];
    
    segmentation.backgroundColor  = [UIColor lightGrayColor];
    bottom.backgroundColor        = [UIColor lightGrayColor];
    [self.detailsButton setTitleColor:self.defaultSelect == YES?TheMass_toneAttune:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.commentsButton setTitleColor:self.defaultSelect == NO?TheMass_toneAttune:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.blueView.backgroundColor = NavColor;
    
    [self.detailsButton addTarget:self action:@selector(detailsDidclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentsButton addTarget:self action:@selector(commentDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    

    [self addSubview:self.detailsButton];
    [self addSubview:self.commentsButton];
    [self addSubview:segmentation];
    [self addSubview:bottom];
    [self addSubview:self.blueView];
    
    
    [self.detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.right.equalTo(segmentation.mas_left);
        make.bottom.equalTo(bottom.mas_top);
    }];
    
    [self.commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(segmentation.mas_right);
        make.bottom.equalTo(bottom.mas_top);
    }];
    
    [segmentation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(bottom.mas_top);
        make.centerX.equalTo(self);
        make.width.mas_offset(0.5);
    }];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_offset(0.5);
    }];

    self.blueView.center = CGPointMake(CYScreanW/4, 79*CXCWidth);
    
    
}


- (void)detailsDidclicked:(UIButton *)sender
{
    if (self.defaultSelect) {
        return;
    }
    self.detailsSelectIndex(sender,1);
    [sender setTitleColor:TheMass_toneAttune forState:UIControlStateNormal];
    [self.commentsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.defaultSelect = YES;
    [self changeBlueView];
}

- (void)setTitleWithOne:(NSString *)one andTwo:(NSString *)two
{
    [self.detailsButton setTitle:one forState:UIControlStateNormal];
    [self.commentsButton setTitle:two forState:UIControlStateNormal];
    
}

- (void)commentDidClicked:(UIButton *)sender
{
    if (!self.defaultSelect) {
        return;
    }
    self.detailsSelectIndex(sender,2);
    [sender setTitleColor:TheMass_toneAttune forState:UIControlStateNormal];
    [self.detailsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.defaultSelect = NO;
    [self changeBlueView];
}

- (void)changeBlueView
{
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = self.blueView.center;
        CGPoint center2 = self.defaultSelect == YES?self.detailsButton.center:self.commentsButton.center;
        self.blueView.center = CGPointMake(center2.x, center.y);
        NSLog(@"%f",self.blueView.center.x);
    }];
 
}



@end
