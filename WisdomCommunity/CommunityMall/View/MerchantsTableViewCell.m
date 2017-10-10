//
//  MerchantsTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MerchantsTableViewCell.h"

@implementation MerchantsTableViewCell

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
        //图片
        UIImageView *showImage = [[UIImageView alloc] init];
        [self.contentView addSubview:showImage];
        [showImage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.01);
             make.width.mas_equalTo(CYScreanW * 0.2);
             make.top.equalTo(self.mas_top).offset(CYScreanH * 0.015);
             make.height.mas_equalTo(CYScreanH * 0.12);
         }];
        showImage.contentMode =  UIViewContentModeScaleAspectFill;
        showImage.clipsToBounds = YES;
        

        self.goodsImage = showImage;
        //名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.25);
             make.top.equalTo(self.mas_top).offset(CYScreanH * 0.02);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
             make.height.mas_equalTo(CYScreanH * 0.03);
         }];
        self.nameLabel = nameLabel;
        //内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
        contentLabel.font = [UIFont fontWithName:@"Arial" size:10];
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.25);
             make.top.equalTo(nameLabel.mas_bottom).offset(CYScreanH * 0.01);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
         }];
        self.contentLabel = contentLabel;
        //价格
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textColor = [UIColor colorWithRed:0.965 green:0.494 blue:0.000 alpha:1.00];
        moneyLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [self.contentView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.25);
             make.bottom.equalTo(self.mas_bottom).offset(- CYScreanH * 0.01);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.4);
             make.height.mas_equalTo(CYScreanH * 0.025);
         }];
        self.moneyLabel = moneyLabel;
        //
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor blackColor];
        promptLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [self.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(moneyLabel.mas_right).offset(0);
             make.bottom.equalTo(self.mas_bottom).offset(- CYScreanH * 0.01);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.3);
             make.height.mas_equalTo(CYScreanH * 0.025);
         }];
        self.numberLabel = promptLabel;
        //加减按钮
        self.hideButtonStepper = [[PKYStepper alloc] init];
        [self.contentView addSubview:self.hideButtonStepper];
        [_hideButtonStepper mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
             make.width.mas_equalTo(CYScreanW * 0.25);
             make.bottom.equalTo(self.mas_bottom).offset(- CYScreanH * 0.005);
             make.height.mas_equalTo(CYScreanH * 0.04);
         }];
        self.hideButtonStepper.maximum = 100000.0f;
        self.hideButtonStepper.hidesDecrementWhenMinimum = YES;
        self.hideButtonStepper.hidesIncrementWhenMaximum = YES;
        self.hideButtonStepper.buttonWidth = CYScreanH * 0.05;
        
        [self.hideButtonStepper setBorderWidth:0.0f];
        
        self.hideButtonStepper.countLabel.layer.borderWidth = 0.0f;
        self.hideButtonStepper.countLabel.textColor = [UIColor blackColor];
        
        //增按钮
        [self.hideButtonStepper.incrementButton setImage:[UIImage imageNamed:@"icon_add_03"] forState:UIControlStateNormal];
        [self.hideButtonStepper.incrementButton setTitle:@"" forState:UIControlStateNormal];
        self.hideButtonStepper.incrementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //减按钮
        [self.hideButtonStepper.decrementButton setImage:[UIImage imageNamed:@"icon_des_03"] forState:UIControlStateNormal];
        [self.hideButtonStepper.decrementButton setTitle:@"" forState:UIControlStateNormal];
        self.hideButtonStepper.decrementButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.hideButtonStepper setButtonTextColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //创建一个本地变量
//        Singleton *goodsSing = [Singleton getSingleton];
        
        __weak typeof(self) weakSelf = self;
        
        //增
        self.hideButtonStepper.incrementCallback = ^(PKYStepper *stepper, float count)
        {
            NSLog(@"count = %.0f",count);
            if (count != 0)
            {
                stepper.countLabel.text = [NSString stringWithFormat:@"%ld",[stepper.countLabel.text integerValue] + 1];
                stepper.value = [stepper.countLabel.text floatValue];
                [weakSelf setCarMerData];
//                [weakSelf.delegate JoinCartAnimationWithRect:<#(CGRect)#>];
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
                [weakSelf setCarMerData];
            }
            else
            {
                stepper.countLabel.text = @"";
                [weakSelf setCarMerData];
            }
        };
//        self.hideButtonStepper.valueChangedCallback = ^(PKYStepper *stepper, float count)
//        {
//            //设置显示数据
//            if (count == 0)
//            {
//                stepper.countLabel.text = @"";
//            }
//            else
//            {
//                stepper.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
//            }
//            //是否有选择了的上篇
//            if ([stepper.countLabel.text integerValue] > 0)
//            {
//                goodsSing.whetherBeginSelect = YES;
//            }
//            if (goodsSing.whetherBeginSelect == YES)
//            {
//                //保存商品数据和商品数量
//                NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
//                parames[@"goods"] = weakSelf.model;
//                parames[@"number"] = [NSNumber numberWithInteger:count];
//                //遍历已选择商家数据
//                if (goodsSing.SelectMerchantsGArray.count)
//                {
//                    //用于记录是否已存在选择的商品id
//                    BOOL whetherProductId = YES;
//                    //遍历总数组,如果已有数据则直接进行替换,如果没有则进如添加语句
//                    for (NSInteger i = 0; i < goodsSing.SelectMerchantsGArray.count; i ++)
//                    {
//                        NSDictionary *goodsDict = [NSDictionary dictionaryWithDictionary:goodsSing.SelectMerchantsGArray[i]];
//                        MerchantsModel *model = [goodsDict objectForKey:@"goods"];
//                        //获取数组中的所有商品数据
////                        NSLog(@"weakSelf.model.goodsId = %@，[goodsDict objectForKey:@id] = %@",weakSelf.model.goodsId,model.goodsId);
//                        //获取存入的商品id
//                        if ([weakSelf.model.goodsId integerValue]  == [model.goodsId integerValue])
//                        {
//                            //首先判断是否已有此id的商品
//                            if (count == 0)
//                            {
//                                //如果为0则删除本条记录:可能之前有，但是操作之后数量变为0就没有了
//                                [goodsSing.SelectMerchantsGArray removeObjectAtIndex:i];
//                            }
//                            else
//                            {
//                                //如果已经存在就替换
//                                [goodsSing.SelectMerchantsGArray replaceObjectAtIndex:i withObject:parames];
//                            }
//                            whetherProductId = NO;
//                            break;
//                        }
//                    }
//                    //如果没有添加过,在此处进行数据添加
//                    if (whetherProductId == YES)
//                    {
//                        NSLog(@"parames = %@",parames);
//                        if (count > 0)
//                        {
//                            //将选择的数据添加到总的数据中
//                            [goodsSing.SelectMerchantsGArray addObject:parames];
//                            //将没存在的商品数据存进来
//                            [weakSelf addModelToSID:parames];
//                        }
//                    }
//                }
//                else
//                {
//                    //将选择的数据添加到总的数据中
//                    [goodsSing.SelectMerchantsGArray addObject:parames];
//                    //将没存在的商品数据存进来
//                    [weakSelf addModelToSID:parames];
//                }
//            }
//            NSLog(@"goodsSing.SelectMerchantsGArray = %@,model.goodsId = %@",goodsSing.SelectMerchantsGArray,weakSelf.model.goodsId);
//            
//            
//            // 通知代理（调用代理的方法）
//            // respondsToSelector:能判断某个对象是否实现了某个方法
//            if ([weakSelf.delegate respondsToSelector:@selector(MerchantsTableViewCellButton:)])
//            {
//                [weakSelf.delegate MerchantsTableViewCellButton:weakSelf];
//            }
//        };
        [self.hideButtonStepper setup];
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.bottom.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];
    }
    return self;
}
//设置购物车数据
- (void) setCarMerData
{
    Singleton *goodsSing = [Singleton getSingleton];
    BOOL whetherFirst = NO;//是否有数据
    //遍历已选择商家数据
    for (NSInteger i = 0; i < goodsSing.SelectMerchantsGArray.count; i ++)
    {
        NSDictionary *goodsDict = [NSDictionary dictionaryWithDictionary:goodsSing.SelectMerchantsGArray[i]];
        MerchantsModel *model = [goodsDict objectForKey:@"goods"];
        //获取存入的商品id
        if ([model.goodsId integerValue]  == [self.model.goodsId integerValue])
        {
            whetherFirst = YES;
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
            }
        }
    }
    //没有则添加进去
    if (whetherFirst == NO)
    {
        //保存商品数据和商品数量
        NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
        parames[@"goods"] = _model;
        parames[@"number"] = self.hideButtonStepper.countLabel.text;
        
        [goodsSing.SelectMerchantsGArray addObject:parames];
        [self addModelToSID:parames];
    }

    // respondsToSelector:能判断某个对象是否实现了某个方法
    if ([self.delegate respondsToSelector:@selector(MerchantsTableViewCellButton:)])
    {
        [self.delegate MerchantsTableViewCellButton:self];
    }
}
//将没有的id添加进来
- (void) addModelToSID:(NSDictionary *)parames
{
    Singleton *goodsSing = [Singleton getSingleton];
    BOOL whether = NO;
    for (NSDictionary *dict in goodsSing.SelectIdGArray)
    {
        MerchantsModel *model = [dict objectForKey:@"goods"];
        if ([model.goodsId integerValue] == [self.model.goodsId integerValue])
        {
            whether = YES;
        }
    }
    if (whether == NO)
    {
        [goodsSing.SelectIdGArray addObject:parames];
    }
}
//设置数据源
- (void) setModel:(MerchantsModel *)model
{
    _model = model;
    
//    self.numberLabel.text = [NSString stringWithFormat:@"已售%@单",_model.numberString];
    if (_model.goodsImage.length)
    {
        [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:_model.goodsImage]];
    }
    else
        self.goodsImage.image = [UIImage imageNamed:@"p_pic"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",_model.nameString];
    
    if (_model.contentString.length > 30)
    {
        self.contentLabel.text = [NSString stringWithFormat:@"%@...",[_model.contentString substringToIndex:30]];
    }
    else
        self.contentLabel.text = [NSString stringWithFormat:@"%@",_model.contentString];
    
    
    if (_model.moneyString.length > 0)
    {
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",_model.moneyString];
    }
    else
        self.moneyLabel.text = @"";
    
    
    Singleton *goodsSing = [Singleton getSingleton];
    
    if (_model.nameString.length)
    {
        self.hideButtonStepper.hidden = NO;
    }
    else
        self.hideButtonStepper.hidden = YES;
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
        }
        for (NSInteger j = 0; j < goodsSing.RemoveArray.count; j ++)
        {
            NSDictionary *parames = [NSDictionary dictionaryWithDictionary:goodsSing.RemoveArray[j]];
            MerchantsModel *model2 = [parames objectForKey:@"goods"];
            if ([model2.goodsId integerValue]  == [model.goodsId integerValue])
            {
                [goodsSing.RemoveArray removeObjectAtIndex:j];
            }
        }
    }
    NSLog(@"goodsSing.RemoveArray = %@,goodsSing.SelectMerchantsGArray = %@",goodsSing.RemoveArray,goodsSing.SelectMerchantsGArray);
    //将还存在的移除
    for (NSInteger j = 0; j < goodsSing.RemoveArray.count; j ++)
    {
        NSDictionary *parames = [NSDictionary dictionaryWithDictionary:goodsSing.RemoveArray[j]];
        MerchantsModel *model = [parames objectForKey:@"goods"];
        if ([self.model.goodsId integerValue]  == [model.goodsId integerValue])
        {
            self.hideButtonStepper.value = 0.0;
            self.hideButtonStepper.countLabel.text = @"";
        }
    }
    
}

@end
