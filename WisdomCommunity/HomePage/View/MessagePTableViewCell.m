//
//  MessagePTableViewCell.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "MessagePTableViewCell.h"

@implementation MessagePTableViewCell

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
        
        self.backgroundColor =[UIColor whiteColor];
        //图标
        UIImageView *messageImage = [[UIImageView alloc] init];
        messageImage.image = [UIImage imageNamed:@"comments_icon"];
        [self addSubview:messageImage];
        messageImage.frame =CGRectMake(30*CXCWidth, 30*CXCWidth, 120*CXCWidth,120*CXCWidth);
        self.messageImage = messageImage;
        //内容
        UILabel *MessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(180*CXCWidth, 30*CXCWidth,200*CXCWidth , 60*CXCWidth)];
        MessageLabel.textColor = TEXTColor;
        MessageLabel.font = [UIFont systemFontOfSize:16];
        MessageLabel.numberOfLines = 0;
//        MessageLabel.backgroundColor =[UIColor redColor];
        [self addSubview:MessageLabel];
         self.MessageLabel = MessageLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = TextGroColor;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [self addSubview:timeLabel];
        timeLabel.frame =CGRectMake( 400*CXCWidth,30*CXCWidth, 320*CXCWidth, 60*CXCWidth);
        self.timeLabel = timeLabel;
        //详情
        UILabel *detailLabel =[[UILabel alloc] init];
        detailLabel.textColor = TextGroColor;
//        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.font = [UIFont fontWithName:@"Arial" size:14];
        [self addSubview:detailLabel];
        detailLabel.frame =CGRectMake(180*CXCWidth,MessageLabel.bottom, 540*CXCWidth, 60*CXCWidth);
        self.detailLabel = detailLabel;

        
        
        
        //分割线
        UIImageView *segmentationImmage = [[UIImageView alloc] init];
        segmentationImmage.backgroundColor = BGColor;
        [self addSubview:segmentationImmage];
        segmentationImmage.frame =CGRectMake(180*CXCWidth,179*CXCWidth , CYScreanW, CXCWidth);
        
    
    
    }
    return self;
}

- (void) setModel:(MessagePModel *)model
{
    _model = model;
    if ([[NSString stringWithFormat:@"%@",_model.type]isEqualToString:@"1"]) {
        
        _MessageLabel.text =@"订单消息";
        [_messageImage setImage:[UIImage imageNamed:@"icon_dingdan"]];
        
        
    }else if([[NSString stringWithFormat:@"%@",_model.type]isEqualToString:@"2"])
    {
        _MessageLabel.text =@"活动消息";
        [_messageImage setImage:[UIImage imageNamed:@"icon_huodong"]];

    }else
    {
        _MessageLabel.text =@"公告消息";
        [_messageImage setImage:[UIImage imageNamed:@"icon_gonggao-1"]];


    }
    self.detailLabel.text = [NSString stringWithFormat:@"%@",_model.messageString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.timeString];
    
}

@end