//
//  ProPayTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ProPayTableViewCell.h"

@implementation ProPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIFont *font = [UIFont fontWithName:@"Arial" size:14];
        //提示
        self.promptBtn = [[UIButton alloc] init];
        self.promptBtn.backgroundColor = [UIColor clearColor];
        self.promptBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [self.promptBtn setTitleColor:[UIColor colorWithRed:0.306 green:0.557 blue:0.910 alpha:1.00] forState:UIControlStateNormal];
        [self.promptBtn setImage:[UIImage imageNamed:@"mingxi_icon_month"] forState:UIControlStateNormal];
        self.promptBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.promptBtn.imageEdgeInsets = UIEdgeInsetsMake(35*CXCWidth, 0, 35*CXCWidth, 5);
        self.promptBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.contentView addSubview:self.promptBtn];
        _promptBtn.frame =CGRectMake(CYScreanW * 0.04, 0, (CYScreanW * 0.4), 100*CXCWidth);
        
        //选择阅读协议按钮
        _AgreementButton = [[UIButton alloc] init];
        [_AgreementButton setBackgroundImage:[UIImage imageNamed:@"agree_default"] forState:UIControlStateNormal];
        [_AgreementButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState: UIControlStateSelected];
        self.AgreementButton.tag = 0;
        [_AgreementButton addTarget:self action:@selector(agreementOnClickButton:) forControlEvents:UIControlEventTouchUpInside];
        _AgreementButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_AgreementButton];
        
        
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self addSubview:segmentationImmage];
        segmentationImmage.frame =CGRectMake(0*CXCWidth,99*CXCWidth , CYScreanW, 1);
        _AgreementButton.frame =CGRectMake(680*CXCWidth,_AgreementButton.top+22*CXCWidth , 40*CXCWidth, 40*CXCWidth);
        _AgreementButton.selected = NO;
        //已支付
        UILabel *payLabel = [[UILabel alloc] init];
        payLabel.text = @"已支付";
        payLabel.textColor = [UIColor colorWithRed:0.514 green:0.514 blue:0.514 alpha:1.00];
        payLabel.font = [UIFont fontWithName:@"Arial" size:15];
        payLabel.textAlignment = NSTextAlignmentRight;
        payLabel.hidden = YES;//初始隐藏
        [self.contentView addSubview:payLabel];
        payLabel.frame =CGRectMake(564*CXCWidth,_AgreementButton.top+22*CXCWidth , 156*CXCWidth, 56*CXCWidth);
        self.alreadyPay = payLabel;
        NSArray *array = @[@"停车管理费",@"垃圾处理费",@"绿化处理费",@"物业费"];
        for (NSInteger i = 0; i < array.count; i ++)
        {
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = TEXTColor;
            label.font = font;
            label.text = [NSString stringWithFormat:@"%@",array[i]];
            [self.contentView addSubview:label];
           
            label.frame =CGRectMake(30*CXCWidth,100*CXCWidth*(i+1) , 300*CXCWidth,99*CXCWidth );
            
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textAlignment = NSTextAlignmentRight;
            label2.textColor = TextGroColor;
            label2.font = font;
            [self.contentView addSubview:label2];
            label2.frame =CGRectMake(350*CXCWidth,100*CXCWidth*(i+1) , 370*CXCWidth,99*CXCWidth );

            
            //分割线
            UIImageView *segmentationImmage = [[UIImageView alloc] init];
            segmentationImmage.backgroundColor = BGColor;
            [self.contentView addSubview:segmentationImmage];
            segmentationImmage.frame =CGRectMake(30*CXCWidth,99*CXCWidth , CYScreanW, 1);
            
            if (i == 0)
            {
                self.labelOne = label2;
            }
            else if (i == 1)
            {
                self.labelTwo = label2;
            }
            else if (i == 2)
            {
                self.labelThree = label2;
            }
            else if (i == 3)
            {
                self.labelFour = label2;
            }
        }
        
        
    }
    
    return self;
}
- (void) setModel:(ProPayModel *)model
{
    _model = model;
    
    [self.promptBtn setTitle:[NSString stringWithFormat:@"%@月",_model.timeString] forState:UIControlStateNormal];
    self.labelOne.text = [NSString stringWithFormat:@"￥%@",_model.costOneString];
    self.labelTwo.text = [NSString stringWithFormat:@"￥%@",_model.costTwoString];
    self.labelThree.text = [NSString stringWithFormat:@"￥%@",_model.costThreeString];
    self.labelFour.text = [NSString stringWithFormat:@"￥%@",_model.costFourString];
    if ([_model.stateString integerValue] == 1)
    {
        self.alreadyPay.hidden = NO;
        self.AgreementButton.hidden = YES;
        self.AgreementButton.userInteractionEnabled = NO;
    }
    else
    {
        self.alreadyPay.hidden = YES;
        self.AgreementButton.hidden = NO;
        self.AgreementButton.userInteractionEnabled = YES;
    }
    Singleton *ProPaySing = [Singleton getSingleton];
    NSLog(@"ProPaySing.selectProPayMonthArray = %@",ProPaySing.selectProPayMonthArray);
    if ([ProPaySing.selectProPayMonthArray containsObject: _model.timeString])
    {
        self.AgreementButton.selected = YES;
    }
    else
    {
        self.AgreementButton.selected = NO;
    }
}

//是否遵循协议按钮
- (void) agreementOnClickButton:(UIButton *)sender
{
    Singleton *ProPaySing = [Singleton getSingleton];
    if (sender.selected == YES)//+
    {
        sender.selected = NO;
        [ProPaySing.selectProPayMonthArray removeObject:_model.timeString];
        [self.delegate remComputingMoney:_model];
        
    }
    else// -
    {
        _AgreementButton.selected = YES;
        [ProPaySing.selectProPayMonthArray addObject:_model.timeString];
        [self.delegate addComputingMoney:_model];
        
    }
    NSLog(@"ProPaySing.selectProPayMonthArray = %@",ProPaySing.selectProPayMonthArray);
}


@end
