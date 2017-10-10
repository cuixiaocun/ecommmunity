//
//  ScoreTableViewCell.m
//  WisdomCommunity
//
//  Created by Admin on 2017/5/3.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ScoreTableViewCell.h"

@implementation ScoreTableViewCell
{
    UILabel* countlabel ;//详情
    UILabel* scoreLabel ;//分数
    UIImageView *img;//图标
    //时间
    UILabel  *timeLabe;
    //内容
    UILabel *typeLabel;
    

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withType:(NSString *)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        //姓名
        countlabel = [[UILabel alloc]init];
        NSString *titleContent = @"啊呜的西瓜";
        countlabel.frame =   CGRectMake(30*CXCWidth, 20*CXCWidth, 300*CXCWidth, 50*CXCWidth);
        [self addSubview:countlabel];
        countlabel.textColor =TEXTColor;
        countlabel.font =[UIFont systemFontOfSize:15];
        
        //图标
        img = [[UIImageView alloc]initWithFrame:CGRectMake(650*CXCWidth,40*CXCWidth, 20*CXCWidth, 20*CXCWidth)];
        [img setImage:[UIImage imageNamed:@"icon_jifen"]];
        [self addSubview:img];

        //分数
        scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(620*CXCWidth,20*CXCWidth, 100*CXCWidth, 50*CXCWidth)];
        scoreLabel.textAlignment =NSTextAlignmentRight;
        scoreLabel.font = [UIFont systemFontOfSize:16];
        scoreLabel.textColor = [UIColor colorWithRed:0 green:214/255.0 blue:149/255.0 alpha:1];
        
        [self addSubview:scoreLabel];
        //时间
        timeLabe = [[UILabel alloc]init];
        timeLabe.frame =   CGRectMake(30*CXCWidth, +countlabel.bottom+20*CXCWidth, 350*CXCWidth, 50*CXCWidth);
        [self addSubview:timeLabe];
        timeLabe.textColor =TextGroColor;
        timeLabe.font =[UIFont systemFontOfSize:13];
        
        
        
        typeLabel = [[UILabel alloc]init];
        typeLabel.frame =  CGRectMake(500*CXCWidth, countlabel.bottom+20*CXCWidth, 220*CXCWidth, 50*CXCWidth);
        [self addSubview:typeLabel];
        typeLabel.textColor =TextGroColor;
        typeLabel.textAlignment =NSTextAlignmentRight;
        typeLabel.font =[UIFont systemFontOfSize:13];
        
        UILabel *xian =[[UILabel alloc]initWithFrame:CGRectMake(0,160*CXCWidth-1*CXCWidth, CYScreanW ,1*CXCWidth)];
        xian.backgroundColor =BGColor;
        [self addSubview:xian];
        
        
        }
        
    
    return self;

}
    




- (void)btnAction:(UIButton *)btn
{
    
    
}

//获取字符串的宽度
-(float)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:fontSize];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                              NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                              NSFontAttributeName:font
                                                                                                                                              } context:nil];
    
    return sizeToFit.size.width;
}
//获得字符串的高度
-(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:18.0];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                             NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                             NSFontAttributeName:font
                                                                                                                                             } context:nil];
    return sizeToFit.size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setDic:(NSDictionary *)dic
{
    _dic =dic;
    countlabel.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"intro"]];
    timeLabe.text =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"gmtCreate"]];
    scoreLabel.text =[NSString stringWithFormat:@"+%@",[_dic objectForKey:@"money"]];
    if ([[NSString stringWithFormat:@"%@",[_dic objectForKey:@"type"] ]isEqualToString:@"1"]) {
        typeLabel.text =@"获得积分";
        scoreLabel.text =[NSString stringWithFormat:@"+%@",[_dic objectForKey:@"money"]];

    
    }else
    {
        typeLabel.text =@"消耗积分";
        scoreLabel.text =[NSString stringWithFormat:@"-%@",[_dic objectForKey:@"money"]];
        scoreLabel.textColor = [UIColor orangeColor];

    }
    float with=  [self widthForString:scoreLabel.text fontSize:13 andHeight:50*CXCWidth];

    img.frame =CGRectMake(750*CXCWidth-with-30*CXCWidth-40*CXCWidth,40*CXCWidth, 20*CXCWidth, 20*CXCWidth);
    
    
}

- (void)tupian:(UIButton *)btn
{
}

@end
