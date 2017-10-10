//
//  AddressMangeTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/22.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "AddressMangeTableViewCell.h"

@implementation AddressMangeTableViewCell

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
        self.backgroundColor = [UIColor whiteColor];
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        //
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00];
        nameLabel.font = font;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(CYScreanW * 0.03);
             make.top.equalTo(self.mas_top).offset((CYScreanH - 64) * 0.01);
             make.width.mas_equalTo (CYScreanW * 0.6);
             make.height.mas_equalTo((CYScreanH - 64) * 0.04);
         }];
        self.nameLabel = nameLabel;
//        nameLabel.backgroundColor =[UIColor redColor];
        
        
        UIButton*btn =[[UIButton alloc]init ];
        btn.frame =CGRectMake(CYScreanW*0.85, 0,((CYScreanH - 64) * 0.1) ,  (CYScreanH - 64) * 0.12);
//        [btn mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
//             make.top.equalTo(nameLabel.mas_bottom).offset(0);
//             make.height.equalTo(nameLabel);
//             make.width.mas_equalTo((CYScreanH - 64) * 0.1);
//         }];
//        btn.backgroundColor =[UIColor redColor];
        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(editTap) forControlEvents:UIControlEventTouchUpInside];
        
        //编辑
        UIImageView *editImage = [[UIImageView alloc] init];
        editImage.image = [UIImage imageNamed:@"icon_my_post-1"];
        editImage.userInteractionEnabled = YES;
        [self.contentView addSubview:editImage];
        [editImage mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.right.equalTo(self.mas_right).offset(-CYScreanW * 0.03);
            make.top.equalTo(nameLabel.mas_bottom).offset(0);
            make.height.equalTo(nameLabel);
            make.width.mas_equalTo((CYScreanH - 64) * 0.04);
        }];
        self.eidtImageView = editImage;
        //添加单击手势防范
        UITapGestureRecognizer *postingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTap)];
        postingTap.numberOfTapsRequired = 1;
        [self.eidtImageView addGestureRecognizer:postingTap];
        //地址
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.00];
        addressLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.contentView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.and.height.equalTo(nameLabel);
             make.top.equalTo(nameLabel.mas_bottom).offset(0);
             make.right.equalTo(editImage.mas_left).offset(-CYScreanW * 0.03);
         }];
        self.addressLabel = addressLabel;
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self.contentView addSubview:segmentationImmage];
        [segmentationImmage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.mas_left).offset(0);
             make.right.equalTo(self.mas_right).offset(0);
             make.top.equalTo(self.mas_bottom).offset(0);
             make.height.mas_equalTo(1);
         }];
    }
    return self;
}

- (void) setModel:(AddressMangeModel *)model
{
    _model = model;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",_model.nameString,_model.phoneString];
    
    if ([_model.defaultString integerValue] > 0)
    {
        self.addressLabel.text = [NSString stringWithFormat:@"【默认】%@",_model.addressString];
        NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:self.addressLabel.text];
        [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.310 green:0.57 blue:0.914 alpha:1.00] range:NSMakeRange(0,4)];
        self.addressLabel.attributedText = sendMessageString;
    }
    else
    {
        self.addressLabel.text = [NSString stringWithFormat:@"%@",_model.addressString];
    }
}
//手势
-(void) editTap{
    [self.delegate ClickEditImage:_model.idString];
}

@end
