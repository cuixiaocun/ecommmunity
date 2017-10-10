//
//  CommunityVC.m
//  WisdomCommunity
//
//  Created by Admin on 2017/3/27.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "CommunityVC.h"
#import "comBBSTableViewCell.h"
@interface CommunityVC ()
{
    UILabel *prompt;
    UIView* selectLabelInTView;//中间
    UIView *selectLabelAtTop;//顶端按钮

}
@property (nonatomic,strong) NSString *BBSRootLabelString;//按钮标签


@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"社区大小事";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    infoArray = [[NSMutableArray alloc] init];
    currentPage =1;
    _BBSRootLabelString =@"1";
    NSArray *tishiArr =@[@"最新",@"分享",@"集市"];
    selectLabelAtTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYScreanW, (CYScreanH - 64) * 0.06)];
    selectLabelAtTop.backgroundColor = [UIColor clearColor];
    selectLabelAtTop.userInteractionEnabled =YES;
    [self.view addSubview:selectLabelAtTop];
    
    for (int i=0; i<3; i++) {
        UIButton* leftButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3*i,0, CYScreanW / 3, (CYScreanH - 64) * 0.06)];
        leftButton.backgroundColor = [UIColor clearColor];
        [leftButton setTitle:[NSString stringWithFormat:@"%@",tishiArr[i]] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
        [leftButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
        leftButton.tag =200+i;
        if (i==0) {
            leftButton.selected =YES;
        }
        //            leftButton.backgroundColor =[UIColor    yellowColor];
        [leftButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
        [selectLabelAtTop addSubview:leftButton];
        
    }
    for (int i=0; i<2; i++) {
        UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*CYScreanW*1/3, 0,1, (CYScreanH - 64) * 0.06)];
        img.backgroundColor =BGColor;
        [selectLabelAtTop addSubview:img];
        
    }

    //添加tableview
    [self.tableView setFrame:CGRectMake(0, 0, CYScreanW, CXCScreanH-64)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    selectLabelAtTop.hidden = YES;

    // 下拉刷新
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    
    self.headerView = headerView;
    
    // 上拉加载
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    
    
    
    [self.tableView setBackgroundColor:BGColor];
    [self RequestSeeNumber];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        NSString *CellID = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        UIScrollView *titleV =[self.view viewWithTag:9090];
        
        [titleV removeFromSuperview];
//        titleV.backgroundColor =[UIColor redColor];
        UIScrollView *bgView = [[UIScrollView alloc] init];
        //        ;
        [bgView setUserInteractionEnabled:YES];
        bgView.tag =9090;
        [bgView setBackgroundColor:[UIColor whiteColor]];
        bgView.frame =CGRectMake(0, 0, CYScreanW, 0.36*CYScreanW+0.16*(CYScreanH-64)+1);

//        [bgView setContentSize:CGSizeMake(80*themeArr.count,100)];
        [cell addSubview:bgView];
        NSArray *strArr =@[@"1left",@"2right"];
        
        for (int i=0; i<2; i++) {
            UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(CYScreanW*0.02+CYScreanW*0.49*i, CYScreanW*0.03, (CYScreanW * 0.47), CYScreanW*0.3)];
            [bgView addSubview:btn];
            UIImageView*imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (CYScreanW * 0.47), CYScreanW*0.3)];
            imgV.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",strArr[i]]];
            [btn addSubview:imgV];
            btn.tag =100+i;
            imgV.userInteractionEnabled=YES;
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            

        }
       
        UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW * 0.02, CYScreanW*0.36, CYScreanW * 0.3, (CYScreanH - 64) * 0.08)];
        btnLeft.backgroundColor = [UIColor clearColor];
        [btnLeft setTitle:@"【话题】" forState:UIControlStateNormal];
        btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
        [btnLeft setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateNormal];
        [btnLeft setImage:[UIImage imageNamed:@"icon_topic"] forState:UIControlStateNormal];
        btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [bgView addSubview:btnLeft];
        
        prompt = [[UILabel alloc] init];
        prompt.textColor = [UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00];
        prompt.font = [UIFont fontWithName:@"Arial" size:12];
        prompt.textAlignment = NSTextAlignmentCenter;
        if (self.HotPostContentDict) {
            prompt.text = [NSString stringWithFormat:@"#%@#",[self.HotPostContentDict objectForKey:@"title"]];
        }
        [bgView addSubview:prompt];
//        prompt.backgroundColor =[UIColor redColor];
        prompt.frame =CGRectMake(btnLeft.right, btnLeft.top, (CYScreanW * 0.7), (CYScreanH - 64) * 0.08);
        NSArray *tishiArr =@[@"最新",@"分享",@"集市"];
         selectLabelInTView = [[UIView alloc] initWithFrame:CGRectMake(0, prompt.bottom+(CYScreanH - 64)*0.01, CYScreanW, (CYScreanH - 64) * 0.06)];
        selectLabelInTView.backgroundColor = [UIColor clearColor];
        selectLabelInTView.userInteractionEnabled =YES;
        [bgView addSubview:selectLabelInTView];

        for (int i=0; i<3; i++) {
            UIButton* leftButton = [[UIButton alloc] initWithFrame:CGRectMake(CYScreanW / 3*i,0, CYScreanW / 3, (CYScreanH - 64) * 0.06)];
            leftButton.backgroundColor = [UIColor clearColor];
            [leftButton setTitle:[NSString stringWithFormat:@"%@",tishiArr[i]] forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];
            [leftButton setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];
            leftButton.tag =200+i;
            if (i==0) {
                leftButton.selected =YES;
            }
//            leftButton.backgroundColor =[UIColor    yellowColor];
            [leftButton addTarget:self action:@selector(labelClickBBSRButton:) forControlEvents:UIControlEventTouchUpInside];
            [selectLabelInTView addSubview:leftButton];

        }
        for (int i=0; i<2; i++) {
            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*CYScreanW*1/3, 0,1, (CYScreanH - 64) * 0.06)];
            img.backgroundColor =BGColor;
            [selectLabelInTView addSubview:img];
            
        }
        for (int i=0; i<2; i++) {
            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0, CYScreanW*0.36+(CYScreanH - 64) * 0.08, CYScreanW, 1)];
            img.backgroundColor =BGColor;
            [bgView addSubview:img];
            
        }
        
        return cell;
        
    }else{
        
        static NSString *identy = @"cell";
        comBBSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (cell==nil) {
            cell = [[comBBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];

            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
//        cell.dic = [infoArray objectAtIndex:indexPath.row-1];
        return cell;
        
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        return  0.36*CYScreanW+0.16*(CYScreanH-64)+1 ;
    }else
    {
        return 320;
      
    }
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"infoArray.coun:%d",infoArray.count+1);
    return infoArray.count+1;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return;
        
    }
    return;
}

- (void)buttonAction:(UIButton *)btn
{

//100
}
- (void)labelClickBBSRButton:(UIButton *)btn
{
    for (int i =0; i<3; i++) {
        UIButton *selectBtn =(UIButton *)[self.view viewWithTag:200+i];
        [selectBtn setSelected:NO];
//        [selectBtn setTitleColor:[UIColor colorWithRed:0.545 green:0.545 blue:0.545 alpha:1.00] forState:UIControlStateNormal];

    }

    btn.selected=YES;
//    [btn setTitleColor:[UIColor colorWithRed:0.098 green:0.502 blue:0.902 alpha:1.00] forState:UIControlStateSelected];

    currentPage =1;
    
    _BBSRootLabelString = [NSString stringWithFormat:@"%d",btn.tag-199];
    [self getCBListRequest];

    
    
    

//200
}
//监测tableview滚动事件，滚动的时候触发

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取查看次数最多的帖子
- (void) RequestSeeNumber
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSDictionary *getDict = [NSDictionary dictionaryWithDictionary:[CYSmallTools getDataKey:COMDATA]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"]   =  [CYSmallTools getDataStringKey:ACCOUNT];//
    parames[@"token"]     =  [CYSmallTools getDataStringKey:TOKEN];
    parames[@"comNo"]     =  [NSString stringWithFormat:@"%@",[getDict objectForKey:@"id"]];
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/hotNote",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view];
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[JSON objectForKey:@"success"] integerValue] == 1)
         {
             
             
             if (![[JSON objectForKey:@"returnValue"]isEqual:[NSNull null]]) {
                 
                 
                 self.HotPostContentDict = [NSDictionary dictionaryWithDictionary:[JSON objectForKey:@"returnValue"]];
                 prompt.text = [NSString stringWithFormat:@"#%@#",[self.HotPostContentDict objectForKey:@"title"]];
                 NSLog(@"获取查看次数最多的帖子请求成功title = %@",[self.HotPostContentDict objectForKey:@"title"]);
                 //             NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                 //             [self.comBBSTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
             }
             
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
     }];
}
//获取帖子列表
- (void) getCBListRequest
{
    //数据请求   设置请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    
        parames[@"category"]     =  [NSString stringWithFormat:@"%@",_BBSRootLabelString];//
        parames[@"currentPage"]  =  [NSString stringWithFormat:@"%d",currentPage];
        parames[@"pageSize"]     =  @"15";
    
    NSLog(@"parames = %@",parames);
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/note/noteList",POSTREQUESTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        
         
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功JSON:%@", dict);
         
         if (dict) {
             if ([[dict objectForKey:@"success"] integerValue] == 1)
             {
                 
                 NSMutableArray *array=[NSMutableArray arrayWithArray:[dict objectForKey:@"returnValue"]];
                 if ([array isKindOfClass:[NSNull class]]) {
                     [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                     return ;
                 }
                 if (currentPage==1) {
                     [infoArray removeAllObjects];
                 }
                 
                 [infoArray addObjectsFromArray:array];
                 
                 if ([infoArray count]==0 && currentPage==1) {
                     [MBProgressHUD showError:@"没有数据了" ToView:self.view];
                     
                 }
                 
                 pageCount =infoArray.count/15;
                 //判断是否加载更多 isLoading反回来的，只有连着网的才行
                 if (array.count==0 || array.count<15){
                     self.canLoadMore = NO; // signal that there won't be any more items to load
                 }else{
                     self.canLoadMore = YES;
                 }
                 
                 DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
                 [fv.activityIndicator stopAnimating];
                 
                 if (!self.canLoadMore) {
                     fv.infoLabel.hidden = YES;
                 }else{
                     fv.infoLabel.hidden = NO;
                 }
                 
                 [self.tableView reloadData];
                 
             }
             
             
         }

     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败:%@", error.description);
         [MBProgressHUD showError:@"加载出错" ToView:self.view];
        
     }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Pull to Refresh
- (void) pinHeaderView
{
    [super pinHeaderView];
    
    // do custom handling for the header view
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"加载中...";
    [CATransaction begin];
    [self.tableView setFrame:CGRectMake(0,64, CYScreanW,CYScreanH)];
    
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    ((DemoTableHeaderView *)self.headerView).arrowImage.hidden = YES;
    [CATransaction commit];;
}
- (void) unpinHeaderView
{
    [super unpinHeaderView];
    
    // do custom handling for the header view
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    ((DemoTableHeaderView *)self.headerView).time.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:[NSDate date]]];
    // [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    //[formatter release];
    // do custom handling for the header view
    [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    if (willRefreshOnRelease){
        hv.title.text = @"松开即可更新...";
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.18f];
        ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
        [CATransaction commit];
    }
    
    else{
        
        if ([hv.title.text isEqualToString:@"松开即可更新..."]) {
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.18f];
            ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
        }
        
        
        hv.title.text = @"下拉即可刷新...";
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        ((DemoTableHeaderView *)self.headerView).arrowImage.hidden = NO;
        ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DIdentity;
        [CATransaction commit];
    }
    
}
//
- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:0];
    
    
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}
#pragma mark - Load More

- (void) willBeginLoadingMore
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
}
- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:0];
    
    
    // Inform STableViewController that we have finished loading more items
    
    return YES;
}



#pragma mark - Dummy data methods
- (void) addItemsOnTop
{
    
    currentPage=1;
    [self performSelector:@selector(getCBListRequest) withObject:nil afterDelay:0];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (currentPage >= pageCount-1){
        self.canLoadMore = NO; // signal that there won't be any more items to load
    }else{
        self.canLoadMore = YES;
    }
    
    
    
    
    if (!self.canLoadMore) {
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
    
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [self refreshCompleted];
}


- (void) addItemsOnBottom
{
    currentPage++;
    [self performSelector:@selector(getCBListRequest) withObject:nil afterDelay:0];
    
    
    if (currentPage >= pageCount-1)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    else
        self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0) {
        [self headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight]
                       scrollView:scrollView];
    } else if (!isLoadingMore && self.canLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        //NSLog(@"%f====%f",scrollPosition,[self footerLoadMoreHeight]);
        if (scrollPosition < [self footerLoadMoreHeight] && scrollPosition > 20) {
            
            [fv.infoLabel setText:@"上拉加载更多..."];
        }else if(scrollPosition < 20){
            //[fv.infoLabel setText:@"释放开始加载..."];
            [fv.infoLabel setText:@"正在加载..."];
            [self loadMore];
        }
    
    }
    
    
    if (scrollView.contentOffset.y >= (CYScreanH - 64) * 0.32)
    {
        selectLabelAtTop.hidden = NO;
        selectLabelInTView.hidden = YES;
    }
    else
    {
        selectLabelAtTop.hidden = YES;
        selectLabelInTView.hidden = NO;
    }

}

@end
