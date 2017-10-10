//
//  GoodsTypeTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "GoodsTypeTableViewCell.h"

@implementation GoodsTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//这个方法在Cell被选中或者被取消选中时调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectButton.backgroundColor = [UIColor redColor];
}
//这个方法在用户按住Cell时被调用
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super  setHighlighted:highlighted animated:animated];
    self.selectButton.backgroundColor = [UIColor redColor];
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //分类描述
        UILabel *promptLabel = [[UILabel alloc] init];
        promptLabel.textColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
        promptLabel.numberOfLines = 0;
        [promptLabel sizeToFit];
        promptLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [self.contentView addSubview:promptLabel];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.02);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.04);
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.02);
         }];
        self.promptLabel = promptLabel;
        
        //商品数量
        UIButton *selectNumberButton = [[UIButton alloc] init];
        selectNumberButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:11];
        [selectNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectNumberButton.backgroundColor = [UIColor redColor];
        selectNumberButton.layer.cornerRadius = 8;
        [self.contentView addSubview:selectNumberButton];
        [selectNumberButton mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.01);
             make.width.mas_equalTo(CYScreanH * 0.05);
             make.top.equalTo(self.mas_top).offset(0);
             make.height.mas_equalTo(CYScreanH * 0.025);
         }];
        self.selectButton = selectNumberButton;
    }
    return self;
}

- (void) setModel:(GoodsTypeModel *)model
{
    _model = model;
    //商品分类
    if (_model.promptString.length > 6)
    {
        self.promptLabel.text = [NSString stringWithFormat:@"%@...",[_model.promptString substringToIndex:6]];
    }
    else
        self.promptLabel.text = [NSString stringWithFormat:@"%@",_model.promptString];
    //控制显示
    if ([_model.selectGoodsNumber integerValue] > 0)
    {
        self.selectButton.hidden = NO;
        [self.selectButton setTitle:[NSString stringWithFormat:@"%@",_model.selectGoodsNumber] forState:UIControlStateNormal];
    }
    else
    {
        self.selectButton.hidden = YES;
    }
}
@end
