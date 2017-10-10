//
//  ShopListTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/21.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ShopListTableViewCell.h"

@implementation ShopListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
             make.top.equalTo(self.mas_top).offset(0);
             make.width.mas_equalTo (CYScreanW * 0.45);
             make.bottom.equalTo(self.mas_bottom).offset(0);
         }];
        self.nameLabel = nameLabel;
        //
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        moneyLabel.textColor = [UIColor colorWithRed:0.902 green:0.306 blue:0.000 alpha:1.00];
        moneyLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [self.contentView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(nameLabel.mas_right).offset(CYScreanW * 0.05);
             make.top.equalTo(self.mas_top).offset(0);
             make.width.mas_equalTo(CYScreanW * 0.2);
             make.bottom.equalTo(self.mas_bottom).offset(0);
         }];
        self.moneyLabel = moneyLabel;
        //加减按钮
        self.hideButtonStepper = [[PKYStepper alloc] init];
        [self.contentView addSubview:self.hideButtonStepper];
        [_hideButtonStepper mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.01);
             make.width.mas_equalTo(CYScreanW * 0.25);
             make.bottom.equalTo(self.mas_bottom).offset(0);
             make.top.equalTo(self.mas_top).offset(0);
         }];
        self.hideButtonStepper.maximum = 100000.0f;
        self.hideButtonStepper.hidesDecrementWhenMinimum = YES;
        self.hideButtonStepper.hidesIncrementWhenMaximum = YES;
        self.hideButtonStepper.buttonWidth = CYScreanH * 0.05;
        
        [self.hideButtonStepper setBorderWidth:0.0f];
        
        self.hideButtonStepper.countLabel.layer.borderWidth = 0.0f;
        self.hideButtonStepper.countLabel.textColor = [UIColor blackColor];

        [self.hideButtonStepper.incrementButton setImage:[UIImage imageNamed:@"icon_add_03"] forState:UIControlStateNormal];
        [self.hideButtonStepper.incrementButton setTitle:@"" forState:UIControlStateNormal];
        self.hideButtonStepper.incrementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //减按钮
        [self.hideButtonStepper.decrementButton setImage:[UIImage imageNamed:@"icon_des_03"] forState:UIControlStateNormal];
        [self.hideButtonStepper.decrementButton setTitle:@"" forState:UIControlStateNormal];
        self.hideButtonStepper.decrementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [self.hideButtonStepper setButtonTextColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //创建一个本地变量
        
        __weak typeof(self) weakSelf = self;
        //增
        self.hideButtonStepper.incrementCallback = ^(PKYStepper *stepper, float count)
        {
            NSLog(@"count = %.0f",count);
            if (count != 0)
            {
                stepper.countLabel.text = [NSString stringWithFormat:@"%ld",[stepper.countLabel.text integerValue] + 1];
                stepper.value = [stepper.countLabel.text floatValue];
                [weakSelf setCarData];
            }
        };
        //减
        self.hideButtonStepper.decrementCallback = ^(PKYStepper *stepper, float count)
        {
            NSLog(@"count = %.0f",count);
            if (count != 0.0)
            {
                stepper.countLabel.text = [NSString stringWithFormat:@"%ld",[stepper.countLabel.text integerValue] - 1];
                stepper.value = [stepper.countLabel.text floatValue];
                [weakSelf setCarData];
            }
            else
            {
                stepper.countLabel.text = @"";
                [weakSelf setCarData];
            }
        };
        [self.hideButtonStepper setup];
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.02);
             make.bottom.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];
    }
    return self;
    
}

- (void) setModel:(MerchantsModel *)model
{
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",_model.nameString];

    
    
    Singleton *goodsSing = [Singleton getSingleton];
    //遍历总数组,如果已有数据则直接进行替换,如果没有则进如添加语句
    for (NSInteger i = 0; i < goodsSing.SelectMerchantsGArray.count; i ++)
    {
        NSDictionary *goodsDict = [NSDictionary dictionaryWithDictionary:goodsSing.SelectMerchantsGArray[i]];
        MerchantsModel *model = [goodsDict objectForKey:@"goods"];
        NSLog(@"goodsSing.SelectMerchantsGArray = %@",goodsSing.SelectMerchantsGArray);
        //获取存入的商品id
        if ([self.model.goodsId integerValue]  == [model.goodsId integerValue])
        {
            self.hideButtonStepper.value = [[goodsDict objectForKey:@"number"] floatValue];
            self.hideButtonStepper.countLabel.text = [NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"number"]];
            //根据选择的商品数量计算价格
            self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[_model.moneyString floatValue] * [[goodsDict objectForKey:@"number"]  integerValue]];
        }
    }
}
//设置购物车数据
- (void) setCarData
{
    Singleton *goodsSing = [Singleton getSingleton];
    //遍历已选择商家数据
    for (NSInteger i = 0; i < goodsSing.SelectMerchantsGArray.count; i ++)
    {
        NSDictionary *goodsDict = [NSDictionary dictionaryWithDictionary:goodsSing.SelectMerchantsGArray[i]];
        MerchantsModel *model = [goodsDict objectForKey:@"goods"];
        //获取存入的商品id
        if ([self.model.goodsId integerValue]  == [model.goodsId integerValue])
        {
            if ([self.hideButtonStepper.countLabel.text integerValue] > 0)
            {
                //保存商品数据和商品数量
                NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
                parames[@"goods"] = model;
                parames[@"number"] = self.hideButtonStepper.countLabel.text;
                [goodsSing.SelectMerchantsGArray replaceObjectAtIndex:i withObject:parames];
            }
            else
            {
                //如果为0则删除本条记录:可能之前有，但是操作之后数量变为0就没有了
                [goodsSing.SelectMerchantsGArray removeObjectAtIndex:i];
                // respondsToSelector:能判断某个对象是否实现了某个方法
                if ([self.delegate respondsToSelector:@selector(uploadLoadButtonClicked:)])
                {
                     [self.delegate uploadLoadButtonClicked:self];
                }
            }
        }
    }

    NSLog(@"goodsSing.SelectMerchantsGArray = %@",goodsSing.SelectMerchantsGArray);
    // respondsToSelector:能判断某个对象是否实现了某个方法
    if ([self.delegate respondsToSelector:@selector(valueChangedCallbackButtonClicked:)])
    {
        [self.delegate valueChangedCallbackButtonClicked:self];
    } 
}
@end
