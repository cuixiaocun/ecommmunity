//
//  MyHouseVC.m
//  WisdomCommunity
//
//  Created by Admin on 2017/5/5.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "MyHouseCell.h"

@implementation MyHouseCell
{
    UIImageView *image;
    UILabel *contentLabel;
    UILabel *auditLabel;
    UILabel *timeLabel;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =BGColor;
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(2*CXCWidth, 20*CXCWidth, 746*CXCWidth, 186*CXCWidth)];
        image.tag =110;
        [self addSubview:image];
        
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(18*CXCWidth,0 ,712*CXCWidth ,170*CXCWidth )];
        [image addSubview:bgView];
        bgView.layer.cornerRadius=3*CXCWidth;
        [bgView setBackgroundColor:[UIColor whiteColor]];
        image.image=  [image.image stretchableImageWithLeftCapWidth:20 topCapHeight:20];

        //内容label
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(16*CXCWidth, 20*CXCWidth, 400*CXCWidth,65*CXCWidth )];
        contentLabel.font = [UIFont fontWithName:@"Arial" size:15];
        contentLabel.backgroundColor = [UIColor whiteColor];
        contentLabel.textColor = TEXTColor;
        [bgView addSubview:contentLabel];
        //审核情况
        auditLabel = [[UILabel alloc] initWithFrame:CGRectMake(450*CXCWidth, 20*CXCWidth, 244*CXCWidth, 65*CXCWidth)];
        auditLabel.font = [UIFont fontWithName:@"Arial" size:15];
        auditLabel.backgroundColor = [UIColor whiteColor];
        auditLabel.textAlignment = NSTextAlignmentRight;
        auditLabel.textColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.404 alpha:1.00];
        [bgView addSubview:auditLabel];
        //
        timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont fontWithName:@"Arial" size:15];
        timeLabel.backgroundColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = TEXTColor;
        [bgView addSubview:timeLabel];
        timeLabel.frame =CGRectMake(16*CXCWidth,contentLabel.bottom,500*CXCWidth, 65*CXCWidth);
        
        

    }

    return self;

}
- (void)setDic:(NSDictionary *)dic
{
    _dic=dic;
    image.image = [UIImage imageNamed:@""];
    contentLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"comName"]];
    
    NSString *stateString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
    if ([stateString integerValue] == 1)
    {
        auditLabel.text = @"审核通过";
        auditLabel.textColor = NavColor;
        image.image = [UIImage imageNamed:@"icon_shadow_tongguo"];

    }
    else if ([stateString integerValue] == 2)
    {
        auditLabel.text = @"未通过";
        auditLabel.textColor = [UIColor grayColor];
        image.image = [UIImage imageNamed:@"icon_shadow_weitonguo"];

    }
    else
    {
        auditLabel.text = @"正在审核";
        auditLabel.textColor = [UIColor orangeColor];
        image.image = [UIImage imageNamed:@"icon_shadow_shenhezhong"];

    }

    NSString *build = [NSString stringWithFormat:@"%@",[dic objectForKey:@"build"]];
    //字符串转变为数组2
    NSMutableArray * array = [NSMutableArray arrayWithArray:[build componentsSeparatedByString:@"#"]];
    NSLog(@"array = %@,cout = %ld",array,array.count);

    timeLabel.text = [NSString stringWithFormat:@"%@号楼-%@单元-%@号",array[0],array[1],array[2]];




}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  }

@end
