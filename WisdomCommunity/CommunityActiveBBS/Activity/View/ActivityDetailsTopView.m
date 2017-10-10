//
//  ActivityDetailsTopView.m
//  WisdomCommunity
//
//  Created by mac on 2016/12/30.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityDetailsTopView.h"

@interface ActivityDetailsTopView()




@end

@implementation ActivityDetailsTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initActivityDetailsView];
    }
    return self;
}


- (void)initActivityDetailsView
{
//    @property (nonatomic, strong) UIButton    *participateButton;//参与人数
//    @property (nonatomic, copy)   Block       participateDidClicked;
//    @property (nonatomic, strong) UIImageView *headImage;//头
//    @property (nonatomic, strong) UIImageView *faceImage;//头像
//    @property (nonatomic, strong) UILabel     *titlelabel;//标题
//    @property (nonatomic, strong) UILabel     *participateLabel;//参与人数
//    @property (nonatomic, strong) UILabel     *nameLabel;//姓名
//    @property (nonatomic, strong) UILabel     *timeLabel;//时间
//    @property (nonatomic, strong) UILabel     *acTimeLabel;//时间段
//    @property (nonatomic, strong) UILabel     *addressLabel;//地址
//    @property (nonatomic, strong) UILabel     *comeLabel;//来自
    //初始化
    self.headImage         = [[UIImageView alloc] init];
    self.faceImage         = [[UIImageView alloc] init];
    self.participateButton = [[UIButton alloc]    init];
    self.titlelabel        = [[UILabel alloc]     init];
    self.participateLabel  = [[UILabel alloc]     init];
    self.nameLabel         = [[UILabel alloc]     init];
    self.timeLabel         = [[UILabel alloc]     init];
    self.acTimeLabel       = [[UILabel alloc]     init];
    self.addressLabel      = [[UILabel alloc]     init];
    self.comeLabel         = [[UILabel alloc]     init];
//    UIView *transparent    = [[UIView alloc]      init];
    //颜色
//    transparent.backgroundColor            = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.titlelabel.textColor              = TEXTColor;
    self.participateLabel.textColor        = [UIColor orangeColor];
//    self.participateLabel.backgroundColor  = TheMass_toneAttune;
    self.nameLabel.textColor               = [UIColor blackColor];
    self.timeLabel.textColor               = [UIColor lightGrayColor];
    self.acTimeLabel.textColor             = TextGroColor;
    self.addressLabel.textColor            = TextGroColor;
//    self.participateButton.backgroundColor = TextGroColor;
//    [_participateButton setBackgroundColor:NavColor];
    [_participateButton setImage:[UIImage imageNamed:@"icon_join"] forState:UIControlStateNormal];
    //字体居中
    self.titlelabel.textAlignment       = NSTextAlignmentLeft;
    self.participateLabel.textAlignment = NSTextAlignmentLeft;
    //居中
    self.comeLabel.textAlignment = NSTextAlignmentRight;
    
    //字体
    self.titlelabel.font       = [UIFont fontWithName:@"Arial" size:18];
    self.participateLabel.font = [UIFont systemFontOfSize:14.0f];
    self.nameLabel.font        = [UIFont systemFontOfSize:16.0f];
    self.timeLabel.font        = [UIFont systemFontOfSize:13.0f];
    self.comeLabel.font        = [UIFont systemFontOfSize:13.0f];
    self.acTimeLabel.font      = [UIFont systemFontOfSize:13.0f];
    self.addressLabel.font     = [UIFont systemFontOfSize:13.0f];
    
    //形状
    self.participateLabel.layer.masksToBounds  = YES;
    self.participateLabel.layer.cornerRadius   = 5.0f;
        self.participateButton.layer.masksToBounds = YES;
    self.participateButton.layer.cornerRadius  = 45*CXCWidth;
    //事件
    [self.participateButton addTarget:self action:@selector(participateDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //约束
     _headImage.frame =CGRectMake(0, 0, CYScreanW, 320*CXCWidth);
     _headImage.contentMode =  UIViewContentModeScaleAspectFill;
     _headImage.clipsToBounds = YES;

    _participateButton.frame =CGRectMake(630*CXCWidth, 320*CXCWidth-45*CXCWidth, 90*CXCWidth, 90*CXCWidth);
    _titlelabel.frame =CGRectMake(24*CXCWidth,_headImage.bottom+15*CXCWidth, 700*CXCWidth, 60*CXCWidth);
    
   _acTimeLabel .frame =CGRectMake(_titlelabel.left, _titlelabel.bottom,700*CXCWidth , 40*CXCWidth);
    
    _participateLabel.frame =CGRectMake(_acTimeLabel.left,_acTimeLabel.bottom , 700*CXCWidth, 50*CXCWidth);
    _addressLabel.frame =CGRectMake(_participateLabel.left, _participateLabel.bottom, 700*CXCWidth, 65*CXCWidth);
    
    UIView *zhongV =[[UIView alloc]initWithFrame:CGRectMake(0, _addressLabel.bottom, CYScreanW, 210*CXCWidth)];
    zhongV.backgroundColor =BGColor;
    [self addSubview:zhongV];
    UIView *whiteV =[[UIView alloc]initWithFrame:CGRectMake(0, 25*CXCWidth, CYScreanW, 160*CXCWidth)];
    whiteV.backgroundColor =[UIColor whiteColor];
    [zhongV addSubview:whiteV];
    _faceImage.frame =CGRectMake(20*CXCWidth,30*CXCWidth , 100*CXCWidth, 100*CXCWidth);
    _nameLabel.frame =CGRectMake(_faceImage.right+24*CXCWidth, 30*CXCWidth, 400*CXCWidth, 50*CXCWidth);
    _timeLabel.frame=CGRectMake(_faceImage.right+24*CXCWidth ,_nameLabel.bottom, 400*CXCWidth, 50*CXCWidth);
    _comeLabel.frame =CGRectMake((750-24-300)*CXCWidth, _nameLabel.top, 300*CXCWidth, 60*CXCWidth);
    self.faceImage.layer.masksToBounds         = YES;
    self.faceImage.layer.cornerRadius          = 50.0*CXCWidth ;

       //默认数据
    self.headImage.image = [UIImage imageNamed:@"01"];
    self.faceImage.image = [UIImage imageNamed:@"icon_posting_bg"];
    self.titlelabel.text = @"#回家过年,团团圆圆#";
    self.participateLabel.text = @"60人参加";
    self.nameLabel.text = @"Carlos_Zhang";
    self.timeLabel.text = @"03-18 12:23:09";
    self.acTimeLabel.text = @"活动时间:2017.01.01 - 03.06";
    self.addressLabel.text = @"活动地址:颐高上海街二期广场";
    self.comeLabel.text = @"来自 颐高上海街";
    [self textColorChangeWith:self.comeLabel];
    
    
    
    //装载
    [self           addSubview:self.headImage];
//    [self           addSubview:transparent];
    [self           addSubview:self.titlelabel];
    [self           addSubview:self.participateLabel];
    [whiteV           addSubview:self.faceImage];
    [whiteV           addSubview:self.nameLabel];
    [whiteV           addSubview:self.timeLabel];
    [whiteV           addSubview:self.comeLabel];
    [self           addSubview:self.acTimeLabel];
    [self           addSubview:self.addressLabel];
    [self           addSubview:self.participateButton];
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


- (void)setTopViewWithModel:(ActivityDetailsModel *)model
{
    self.titlelabel.text = [NSString stringWithFormat:@"%@",model.title];
    self.participateLabel.text = [NSString stringWithFormat:@"%@人参与",model.playCount];
    NSDictionary *dict = model.accountDO;
    NSString *imgAddress = [self objectOrNilForKey:@"imgAddress" fromDictionary:dict];
    
    NSString *nickName = [self objectOrNilForKey:@"nickName" fromDictionary:dict];
    //获取数组图片
    NSArray *imageArray = [model.imgAddress componentsSeparatedByString:@","];
    NSMutableArray *imageList = [NSMutableArray array];
    for (int i = 0; i<imageArray.count; i++) {
        if (![imageArray[i] isEqualToString:@""]) {
            [imageList addObject:imageArray[i]];
        }
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@",[imageList firstObject]];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl.length > 6 ? imageUrl : BackGroundImage]];//@"http://7xwtb9.com2.z0.glb.qiniucdn.com/01.jpg"
    
    [self.faceImage sd_setImageWithURL:[NSURL URLWithString:imgAddress == nil ? DefaultHeadImage:imgAddress]];
    self.nameLabel.text = (nickName == nil || [nickName isEqualToString:@"<null>"]) ? @"未获取":nickName;
    NSLog(@"model.communityName = %@",model.communityName);
    self.comeLabel.text = [NSString stringWithFormat:@"来自:%@",model.communityName == nil?@"":model.communityName];
    self.timeLabel.text = model.gmtCreate;
    self.acTimeLabel.text = [NSString stringWithFormat:@"%@",IsNilString(model.acTime)?@"暂无":model.acTime];
    self.addressLabel.text = [NSString stringWithFormat:@"%@",IsNilString(model.address)?@"暂无":model.address];
    
    if ((![[self returnStateString:model.acTime]isEqualToString:@"end"])&[[NSString stringWithFormat:@"%@",model.viewAccountJoinStatus] isEqualToString:@"0"]) {
        _participateButton.hidden=NO;
    }else
    {
    
        _participateButton.hidden=YES;

    
    }
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (void)participateDidClicked:(UIButton *)sender
{
    if (self.participateDidClicked) {
        self.participateDidClicked(sender);
    }
}
- (void)textColorChangeWith:(UILabel *)label
{
    NSMutableAttributedString *sendMessageString = [[NSMutableAttributedString alloc] initWithString:label.text];
    [sendMessageString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.733 green:0.733 blue:0.733 alpha:1.00] range:NSMakeRange(0,2)];
    label.attributedText = sendMessageString;
}

- (NSString *)returnStateString:(NSString *)acTime
{
    if (acTime == nil) {
        return nil;
    }
    NSArray *actimeArray = [acTime componentsSeparatedByString:@"~"];
    NSString *starTimer = [actimeArray firstObject];
    NSString *endTimer = [actimeArray lastObject];
    NSDate *date = [NSDate date]; // 获得时间对象
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [forMatter stringFromDate:date];
    NSLog(@"当前时间%@,",dateStr);
    //    if ([[self compareOneDay:dateStr withAnotherDay:starTimer] isEqualToString:@"1"]) {
    if ([[self compareOneDay:dateStr withAnotherDay:endTimer] isEqualToString:@"1"]) {
        //活动已经结束
        return @"end";
    }else{
        //活动正在进行
        return @"start";
    }
    //    }else{
    //        //活动尚未开始
    //        return @"Not";
    //    }
}

- (NSString *)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    if (IsNilString(anotherDayStr)) {
        return @"1";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-dd-MM"];
    
    NSComparisonResult result = [oneDayStr compare:anotherDayStr];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        //日期one比今天小
        return @"1";
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        //日期one小比今天大
        return @"-1";
    }else
    {
        return @"1";
        
        
    }
    //NSLog(@"Both dates are the same");
    return @"0";
    
}

@end
