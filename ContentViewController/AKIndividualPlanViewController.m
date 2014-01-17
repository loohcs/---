//
//  AKIndividualPlanViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-3-28.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKIndividualPlanViewController.h"
#import "AKInternetInterface.h"
#import "AKFastLabel.h"
#import "AKFastButton.h"
#import "AKFastView.h"
#import "AKFastImageView.h"
#import "AKFastCallView.h"
#import "AKFastTextField.h"
#import "AKPlanDetailsViewController.h"
#define _START_INTERVAL_ 10 //开头的间隔
#define _LINE_HEIGHT_ 25 //每行的高度
#define _FOUR_WIDTH_ 90
#define _QUERY_LABEL_FONT_ 17//字体大小
//判断是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface AKIndividualPlanViewController ()
-(void)ransmitRequest;//发送请求
-(void)ransmitRequestWithDic:(NSDictionary*)aDic;//发送请求
-(void)refreshContent;//刷新
- (void)addQueryView;//查询view
@end

@implementation AKIndividualPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)addQueryView
{
    CGRect myScreen=[[UIScreen mainScreen]bounds];
    queryView = [AKFastView viewWithWithFrame:CGRectMake(0, 0,CGRectGetWidth(myScreen), CGRectGetHeight(myScreen)-64) andBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5]];
    queryView.hidden = YES;
    queryView.userInteractionEnabled = YES;
    UIView *minQueryView = [AKFastView viewWithWithFrame:CGRectMake(20, 40, 280, 250) andBackgroundColor:[UIColor blackColor]];
    minQueryView.userInteractionEnabled = YES;
    UIImageView *topImage = [AKFastImageView imageViewWithFrame:CGRectMake(15, 10, 30, 30) andImage:[UIImage imageNamed:@"search.png"]];
    UILabel *topLabel = [AKFastLabel labelWithFrame:CGRectMake(50, 0, 280, 44) andText:@"计划查询：" andtextAlignment:UITextAlignmentLeft andFont:22];
    topLabel.textColor = [UIColor whiteColor];
    UILabel *queryLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 50, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"  姓    名 ：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel1.textColor = [UIColor whiteColor];
    UILabel *queryLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 65+_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"  标    题 ：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel2.textColor = [UIColor whiteColor];
    UILabel *queryLabel3 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 80+2*_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"开始时间：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel3.textColor = [UIColor whiteColor];
    UILabel *queryLabel4 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 95+3*_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"结束时间：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel4.textColor = [UIColor whiteColor];
    queryTextField1 = [AKFastTextField textFieldWithFrame:CGRectMake(95, 50, 150, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeDefault andFont:15.f];
    queryTextField1.tag = 401;
    queryTextField1.delegate = self;
    queryTextField1.text = @"";
    queryTextField2 = [AKFastTextField textFieldWithFrame:CGRectMake(95, 90, 150, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeDefault andFont:15.f];
    queryTextField2.tag = 402;
    queryTextField2.delegate = self;
    queryTextField2.text = @"";
    queryTextField3 = [AKFastTextField textFieldWithFrame:CGRectMake(95, 130, 150, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeDefault andFont:15.f];
    queryTextField3.tag = 403;
    queryTextField3.delegate = self;
    queryTextField3.text = @"";
    queryTextField3.placeholder = @"格式：2013-1-1";
    queryTextField3.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    queryTextField4 = [AKFastTextField textFieldWithFrame:CGRectMake(95, 170, 150, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeDefault andFont:15.f];
    queryTextField4.tag = 404;
    queryTextField4.delegate = self;
    queryTextField4.text = @"";
    queryTextField4.placeholder = @"格式：2013-1-30";
    queryTextField4.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    UIButton *queryBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(160, 110+4*_LINE_HEIGHT_, 80, 30) andNormalTitle:@"查询" andBackgroundImage:[UIImage imageNamed:@"button_60.png"] andTouchUpTarget:self andTouchUpAction:@selector(queryBegin)];
    [queryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIButton *cancelBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(30, 110+4*_LINE_HEIGHT_, 80, 30) andNormalTitle:@"取消" andBackgroundImage:[UIImage imageNamed:@"button_60.png"] andTouchUpTarget:self andTouchUpAction:@selector(queryCancel)];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [minQueryView addSubview:topImage];
    [minQueryView addSubview:topLabel];
    [minQueryView addSubview:queryLabel1];
    [minQueryView addSubview:queryLabel2];
    [minQueryView addSubview:queryLabel3];
    [minQueryView addSubview:queryLabel4];
    [minQueryView addSubview:queryTextField1];
    [minQueryView addSubview:queryTextField2];
    [minQueryView addSubview:queryTextField3];
    [minQueryView addSubview:queryTextField4];
    [minQueryView addSubview:queryBtn];
    [minQueryView addSubview:cancelBtn];
    [queryView addSubview:minQueryView];
    [self.view addSubview:queryView];
}
- (void)viewDidLoad
{
    userData = [AKUserData sharedUserData];
    parameterDic = [[NSMutableDictionary alloc]init];
    currentPageStr = [[NSMutableString alloc]init];
    pagecountStr = [[NSMutableString alloc]init];
    currentRequestContent = [[AKCurrentRequest alloc]init];
    currentRequestContent.delegate = self;
    cellViewArray = [[NSMutableArray alloc]init];
    cellArray = [[NSMutableArray alloc]init];
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"个人计划" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    UIView *rightBtnView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 85, 31) andBackgroundColor:[UIColor clearColor]];
    rightBtnView.userInteractionEnabled = YES;
    UIButton *rightReportBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 2, 40, 27) andNormalTitle:@"上报" andBackgroundImage:[UIImage imageNamed:@"top_anniu"] andTouchUpTarget:self andTouchUpAction:@selector(reportData)];
    rightReportBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIButton *rightRefreshBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(45, 2, 40, 27) andNormalTitle:@"刷新" andBackgroundImage:[UIImage imageNamed:@"top_anniu"] andTouchUpTarget:self andTouchUpAction:@selector(refreshContent)];
    rightRefreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtnView addSubview:rightReportBtn];
    [rightBtnView addSubview:rightRefreshBtn];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:rightBtnView]autorelease];
    CGRect myScreen=[[UIScreen mainScreen]bounds];
    aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(myScreen), CGRectGetHeight(myScreen)-108) style:UITableViewStylePlain];
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线的样式
    aTableView.backgroundColor = [UIColor clearColor];//透明
    aTableView.delegate = self;
    aTableView.dataSource = self;
    [self.view addSubview:aTableView];
    UIImageView *diImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, CGRectGetHeight(myScreen)-108, CGRectGetWidth(myScreen), 44) andImage:[UIImage imageNamed:@"di_bar.png"]];
    diImageView.userInteractionEnabled = YES;
    NSArray *labelArray = [NSArray arrayWithObjects:@"查询",@"首页",@"上页",@"下页",@"尾页", nil];
    for (int i=0; i<=4; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"p%d.png",i];
        UIImage *image = [UIImage imageNamed:imageStr];
        CGRect diImageRect = CGRectMake(20+60*i, 0, 32, 32);
        CGRect diLabelRect = CGRectMake(15+60*i, 32, 42, 12);
        UIButton *diButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:diImageRect andNormalImage:image andTouchUpTarget:self andTouchUpAction:@selector(diMethod:) andTag:200+i];
        NSString *labelName = [NSString stringWithFormat:@"%@",[labelArray objectAtIndex:i]];
        UILabel *diLabel = [AKFastLabel labelWithFrame:diLabelRect andText:labelName andtextAlignment:UITextAlignmentCenter andFont:12];
        [diImageView addSubview:diButton];
        [diImageView addSubview:diLabel];
    }
    [self.view addSubview:diImageView];
    mum = [AKUploadMum uploadWhiteMumWithSite:CGPointMake(60, 80) andMunName:@"加载中..."];
    [self.view addSubview:mum];
    [self ransmitRequest];
    [self addQueryView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [currentRequestContent release];
    [cellViewArray release];
    [cellArray release];
    [pagecountStr release];
    [currentPageStr release];
    [parameterDic release];
    [aTableView release];
    [super dealloc];
}
#pragma - 执行方法
-(void)ransmitRequest//发送请求
{
//    http://skyeyes.ip165.com/yyt/port/eplan.aspx?cid=444&mobile=13406957927&pwd=1&action=list&pagenum=&id=&employno=&employ=&title=&content=&stime=&etime=&rcontent=
    mum.hidden = NO;
    NSDictionary *aParameterDic = [NSDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"list",@"action",@"",@"pagenum",@"",@"title",@"",@"employ",@"",@"sdate",@"",@"edate", nil];
    [parameterDic setDictionary:aParameterDic];
    [currentRequestContent currentRequestWithURL:_YGJIHUA_INTERFACE_ andParameter:parameterDic];
}
-(void)ransmitRequestWithDic:(NSDictionary*)aDic//发送请求
{
    mum.hidden = NO;
    [currentRequestContent currentRequestWithURL:_YGJIHUA_INTERFACE_ andParameter:parameterDic];
}
-(void)reportData//上报
{
    AKIndividualPlanReportViewController *individualPlanReportVC = [[AKIndividualPlanReportViewController alloc]init];
    individualPlanReportVC.delegate = self;
    [self.navigationController pushViewController:individualPlanReportVC animated:NO];
    [individualPlanReportVC release];
}

-(void)refreshContent//刷新
{
    [self ransmitRequest];
}
-(void)diMethod:(UIButton*)sender//底部五个按钮的方法
{
    switch (sender.tag) {
        case 200:{
            queryTextField1.text = @"";
            queryTextField2.text = @"";
            queryTextField3.text = @"";
            queryTextField4.text = @"";
            queryView.hidden = NO;
            break;}
        case 201:{
            int pageindex = [currentPageStr intValue];
            if (pageindex<=1) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"已经是第一页！"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
            }else{
                [parameterDic setObject:@"1" forKey:@"pagenum"];
                [self ransmitRequestWithDic:parameterDic];
            }
            break;}
        case 202:{
            int pageindex = [currentPageStr intValue];
            if (pageindex<=1) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"已经是第一页！"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
            }else{
                pageindex--;
                NSString *pageindexStr = [NSString stringWithFormat:@"%d",pageindex];
                [parameterDic setObject:pageindexStr forKey:@"pagenum"];
                [self ransmitRequestWithDic:parameterDic];
            }
            break;}
        case 203:{
            int pageindex = [currentPageStr intValue];
            int pagecount = [pagecountStr intValue];
            if (pageindex>=pagecount) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"已经是最后一页！"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
            }else{
                pageindex++;
                NSString *pageindexStr = [NSString stringWithFormat:@"%d",pageindex];
                [parameterDic setObject:pageindexStr forKey:@"pagenum"];
                [self ransmitRequestWithDic:parameterDic];}
            break;}
        case 204:{
            int pageindex = [currentPageStr intValue];
            int pagecount = [pagecountStr intValue];
            if (pageindex>=pagecount) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"已经是最后一页！"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
            }else{
                pageindex = pagecount;
                NSString *pageindexStr = [NSString stringWithFormat:@"%d",pageindex];
                [parameterDic setObject:pageindexStr forKey:@"pagenum"];
                [self ransmitRequestWithDic:parameterDic];}
            break;}
            
        default:
            break;
    }
}
- (void)clickLeftBtn//返回
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)queryCancel//查询取消
{
    [self touchesBegan:nil withEvent:nil];
    queryView.hidden = YES;
}
-(void)queryBegin//开始查询
{
    [self touchesBegan:nil withEvent:nil];
    [parameterDic setObject:queryTextField1.text forKey:@"employ"];
    [parameterDic setObject:queryTextField2.text forKey:@"title"];
    [parameterDic setObject:queryTextField3.text forKey:@"sdate"];
    [parameterDic setObject:queryTextField4.text forKey:@"edate"];
    [parameterDic setObject:@"" forKey:@"pagenum"];
    [self ransmitRequestWithDic:parameterDic];
    queryView.hidden = YES;
    
}
#pragma - 上报成功代理
-(void)individualPlanReportSucceedPopWillRefresh
{
    [self refreshContent];
}
#pragma - 连接代理 
//请求成功
-(void)refreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    mum.hidden = YES;
//    NSLog(@"%@",aContentDic);
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    if ([flagStr isEqualToString:@"success"]) {
        NSArray *listArray = [aContentDic objectForKey:@"PersonalPlan"];
        if (listArray.count) {
            [cellViewArray setArray:[AKFastCallView individualPlanCellViewWithArray:listArray]];
            [cellArray setArray:listArray];
            [aTableView reloadData];
            [aTableView setContentOffset:CGPointMake(0, 0)animated:NO];
        }else{
            [cellViewArray setArray:nil];
            [cellArray setArray:nil];
            [aTableView reloadData];
            
        }
        [currentPageStr setString:[NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"currentpage"]]];
        [pagecountStr setString:[NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"pageall"]]];
        
    }else{
        NSString *causeStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"cause"]];
        if ([causeStr isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"数据连接失败"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:causeStr
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
}
//解析数据失败
-(void)refreshFailWithParameter
{
    mum.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"数据连接失败"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//网络问题
-(void)refreshFailWithInternet
{
    mum.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"网络连接失败，请检查网络后再试！"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
#pragma mark - TableView代理方法
//返回Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//返回Row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellViewArray.count;
}
//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *cellView = [cellViewArray objectAtIndex:indexPath.row];
    CGFloat cellHeight = cellView.frame.size.height;
    return cellHeight;
}
//绘制Cell
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    for(UIView*contentView in cell.contentView.subviews)
    {
        [contentView removeFromSuperview];
    }
    UIView *cellView = [cellViewArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:cellView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//点击Cell触发的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [cellArray objectAtIndex:indexPath.row];
    NSString *idStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    AKPlanDetailsViewController *planDetailsVC = [[AKPlanDetailsViewController alloc]init];
    planDetailsVC.detailsId = idStr;
    [self.navigationController pushViewController:planDetailsVC animated:NO];
    [planDetailsVC release];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [queryTextField1 resignFirstResponder];
    [queryTextField2 resignFirstResponder];
    [queryTextField3 resignFirstResponder];
    [queryTextField4 resignFirstResponder];
    [UIView beginAnimations:@"Animations" context:nil]; //context传值
    [UIView setAnimationDuration:0.25f];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
    queryView.transform = translation;
    [UIView commitAnimations];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!iPhone5) {
        switch (textField.tag) {
            case 401:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -50);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 402:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -50);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 403:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -90);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 404:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -130);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;} 
                
            default:
                break;
        }
    }
    
}
@end
