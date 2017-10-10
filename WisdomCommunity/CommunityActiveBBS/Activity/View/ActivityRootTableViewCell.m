//
//  ActivityRootTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityRootTableViewCell.h"

@implementation ActivityRootTableViewCell

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
        self.backgroundColor=BGColor;
        UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0*CXCWidth, 20*CXCWidth, CYScreanW, 440*CXCWidth)];
        [self addSubview:bgview];
        bgview.backgroundColor =[UIColor whiteColor];
        
        
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        //活动展示
        UIImageView *showImmage = [[UIImageView alloc] init];
        showImmage.backgroundColor = BGColor;
        [bgview addSubview:showImmage];
        showImmage.frame =CGRectMake(20*CXCWidth, 20*CXCWidth, 710*CXCWidth, 300*CXCWidth);
        self.imageImageView = showImmage;
        showImmage.contentMode =UIViewContentModeScaleAspectFill;
        
        showImmage.clipsToBounds = YES;

        UIImageView *topView = [[UIImageView alloc] init];
        topView.backgroundColor = [UIColor blackColor];
        topView .alpha =0.2;
        [bgview addSubview:topView];
        topView.frame =CGRectMake(20*CXCWidth, 20*CXCWidth, 710*CXCWidth, 300*CXCWidth);

        
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font =[UIFont boldSystemFontOfSize:20];
        [bgview addSubview:titleLabel];
        titleLabel.frame =CGRectMake(20*CXCWidth, 0, CXCWidth*710, 300*CXCWidth);
        titleLabel.textAlignment =NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"03-18 12.32.08";
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.textAlignment =NSTextAlignmentCenter;
        timeLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [bgview addSubview:timeLabel];
        timeLabel.frame =CGRectMake(20*CXCWidth, 170*CXCWidth, CXCWidth*710, 60*CXCWidth);
        self.timeLabel = timeLabel;

        //内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = TextGroColor;
        contentLabel.font = font;
        contentLabel.frame =CGRectMake(20*CXCWidth, showImmage.bottom, 710*CXCWidth, 120*CXCWidth);
        contentLabel.numberOfLines =2;
        [bgview addSubview:contentLabel];
        self.contentLabel = contentLabel;
        //状态
        UIImageView *showTImmage = [[UIImageView alloc] init];
        showTImmage.backgroundColor = [UIColor clearColor];
        [bgview addSubview:showTImmage];
        showTImmage.frame =CGRectMake(20*CXCWidth, 14*CXCWidth, 200*CXCWidth,60*CXCWidth );
        self.showImageView = showTImmage;
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
- (void) setModel:(ActivityRootModel *)model
{
    _model = model;
    NSArray *imageArray = [model.imgAddress componentsSeparatedByString:@","];
    NSMutableArray *imageList = [NSMutableArray array];
    for (int i = 0; i<imageArray.count; i++) {
        if (![imageArray[i] isEqualToString:@""]) {
            [imageList addObject:imageArray[i]];
        }
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@",[imageList firstObject]];//
    [self.imageImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl.length > 6 ? imageUrl : BackGroundImage]];
    
    if ([_model.stateString isEqualToString:@"start"])
    {
        self.showImageView.image = [UIImage imageNamed:@"icon_onGonging"];
    }
    else if ([_model.stateString isEqualToString:@"end"]){
        self.showImageView.image = [UIImage imageNamed:@"icon_edd"];
    }else{
        self.showImageView.image = [UIImage imageNamed:@"icon_onGonging"];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",IsNilString(_model.title)?@"暂无":_model.title];
    if ([_model.flag integerValue] == 1)
    {
        self.contentLabel.text = [NSString stringWithFormat:@"%@",IsNilString(_model.content)?@"暂无":(_model.content)];
    }
    else
        self.contentLabel.text = @"官方活动内容";
    self.timeLabel.text = [NSString stringWithFormat:@"%@",IsNilString(_model.acTime)?@"暂无":(_model.acTime)];
}

@end
