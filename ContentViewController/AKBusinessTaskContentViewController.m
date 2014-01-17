//
//  AKBusinessTaskContentViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-3-27.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKBusinessTaskContentViewController.h"
#import "AKInternetInterface.h"
#import "AKFastLabel.h"
#import "AKFastButton.h"
#import "AKFastView.h"
#import "AKFastTextView.h"
#import "AKFastImageView.h"
#import "AKFastCallView.h"
#import "AKFastTextField.h"
#import "AKSurveyDetailsViewController.h"
#import "AKBusinessPhotoViewController.h"
#define _START_INTERVAL_ 10 //开头的间隔
#define _LINE_HEIGHT_ 25 //每行的高度
#define _FOUR_WIDTH_ 88
#define _SIX_WIDTH_ 120
#define _QUERY_LABEL_FONT_ 17//字体大小
//判断是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface AKBusinessTaskContentViewController ()
-(void)ransmitRequest;//发送请求
-(void)ransmitRequestWithDic:(NSDictionary*)aDic;//发送请求
-(void)refreshContent;//刷新
- (void)addQueryView;//查询view
- (void)addFeedbackView;//添加反馈View
@end

@implementation AKBusinessTaskContentViewController

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
    UIImageView *topImage = [AKFastImageView imageViewWithFrame:CGRectMake(15, 10, 30, 30) andImage:[UIImage imageNamed:@"search.png"]];
    UILabel *topLabel = [AKFastLabel labelWithFrame:CGRectMake(50, 0, 280, 44) andText:@"商务任务查询" andtextAlignment:UITextAlignmentLeft andFont:22];
    topLabel.textColor = [UIColor whiteColor];
    UILabel *queryLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 50, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"商务编码：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel1.textColor = [UIColor whiteColor];
    queryTextField1 = [AKFastTextField textFieldWithFrame:CGRectMake(_FOUR_WIDTH_+5, 50, 165, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeASCIICapable andFont:15.f];
    queryTextField1.tag = 401;
    queryTextField1.delegate = self;
    queryTextField1.text = @"";
    UILabel *queryLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 65+_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"商务名称：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel2.textColor = [UIColor whiteColor];
    queryTextField2 = [AKFastTextField textFieldWithFrame:CGRectMake(_FOUR_WIDTH_+5, 90, 165, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeDefault andFont:15.f];
    queryTextField2.tag = 402;
    queryTextField2.delegate = self;
    queryTextField2.text = @"";
    UILabel *queryLabel3 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 80+2*_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"药店编码：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel3.textColor = [UIColor whiteColor];
    queryTextField3 = [AKFastTextField textFieldWithFrame:CGRectMake(_FOUR_WIDTH_+5, 80+2*_LINE_HEIGHT_, 165, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeASCIICapable andFont:15.f];
    queryTextField3.tag = 403;
    queryTextField3.delegate = self;
    queryTextField3.text = @"";
    UILabel *queryLabel4 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 95+3*_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"药店名称：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel4.textColor = [UIColor whiteColor];
    queryTextField4 = [AKFastTextField textFieldWithFrame:CGRectMake(_FOUR_WIDTH_+5, 95+3*_LINE_HEIGHT_, 165, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeDefault andFont:15.f];
    queryTextField4.tag = 404;
    queryTextField4.delegate = self;
    queryTextField4.text = @"";
    UILabel *queryLabel5 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 110+4*_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"目标店员：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel5.textColor = [UIColor whiteColor];
    queryTextField5 = [AKFastTextField textFieldWithFrame:CGRectMake(_FOUR_WIDTH_+5, 110+4*_LINE_HEIGHT_, 165, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypeDefault andFont:15.f];
    queryTextField5.tag = 405;
    queryTextField5.delegate = self;
    queryTextField5.text = @"";
    UILabel *queryLabel6 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 125+5*_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"  电    话 ：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    queryLabel6.textColor = [UIColor whiteColor];
    queryTextField6 = [AKFastTextField textFieldWithFrame:CGRectMake(_FOUR_WIDTH_+5, 125+5*_LINE_HEIGHT_, 165, 30) andBackgroundColor:[UIColor whiteColor] andBorderStyle:UITextBorderStyleBezel andKeyboardType:UIKeyboardTypePhonePad andFont:15.f];
    queryTextField6.tag = 406;
    queryTextField6.delegate = self;
    queryTextField6.text = @"";
    UIButton *queryBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(163, 140+6*_LINE_HEIGHT_, 80, 30) andNormalTitle:@"查询" andBackgroundImage:[UIImage imageNamed:@"button_60.png"] andTouchUpTarget:self andTouchUpAction:@selector(queryBegin)];
    [queryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIButton *cancelBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(30, 140+6*_LINE_HEIGHT_, 80, 30) andNormalTitle:@"取消" andBackgroundImage:[UIImage imageNamed:@"button_60.png"] andTouchUpTarget:self andTouchUpAction:@selector(queryCancel)];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIView *minQueryView = [AKFastView viewWithWithFrame:CGRectMake(20, 20, 280, cancelBtn.frame.origin.y+cancelBtn.frame.size.height+10) andBackgroundColor:[UIColor blackColor]];
    minQueryView.userInteractionEnabled = YES;
    [minQueryView addSubview:topImage];
    [minQueryView addSubview:topLabel];
    [minQueryView addSubview:queryLabel1];
    [minQueryView addSubview:queryTextField1];
    [minQueryView addSubview:queryLabel2];
    [minQueryView addSubview:queryTextField2];
    [minQueryView addSubview:queryLabel3];
    [minQueryView addSubview:queryTextField3];
    [minQueryView addSubview:queryLabel4];
    [minQueryView addSubview:queryTextField4];
    [minQueryView addSubview:queryLabel5];
    [minQueryView addSubview:queryTextField5];
    [minQueryView addSubview:queryLabel6];
    [minQueryView addSubview:queryTextField6];
    [minQueryView addSubview:queryBtn];
    [minQueryView addSubview:cancelBtn];
    [queryView addSubview:minQueryView];
    [self.view addSubview:queryView];
}
- (void)addFeedbackView//添加反馈View
{
    CGRect myScreen=[[UIScreen mainScreen]bounds];
    feedbackView = [AKFastView viewWithWithFrame:CGRectMake(0, 0,CGRectGetWidth(myScreen), CGRectGetHeight(myScreen)-64) andBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5]];
    feedbackView.hidden = YES;
    feedbackView.userInteractionEnabled = YES;
    UIImageView *topImage = [AKFastImageView imageViewWithFrame:CGRectMake(15, 10, 30, 30) andImage:[UIImage imageNamed:@"search.png"]];
    UILabel *topLabel = [AKFastLabel labelWithFrame:CGRectMake(50, 0, 280, 44) andText:@"任务反馈" andtextAlignment:UITextAlignmentLeft andFont:22];
    topLabel.textColor = [UIColor whiteColor];
    UILabel *feedbackLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 50, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"是否达标：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    feedbackLabel1.textColor = [UIColor whiteColor];
    isFeedbackBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(_FOUR_WIDTH_+5, 50, 18, 18) andNormalImage:[UIImage imageNamed:@"but_pitch0.png"] andSelectedImage:[UIImage imageNamed:@"but_pitch1.png"] andTouchUpTarget:self andTouchUpAction:@selector(standardYes)];
    isFeedbackBtn.selected = NO;
    UILabel *yesLabel = [AKFastLabel labelWithFrame:CGRectMake(_FOUR_WIDTH_+25, 50, 18, 18) andText:@"是" andtextAlignment:UITextAlignmentCenter andFont:_QUERY_LABEL_FONT_];
    yesLabel.textColor = [UIColor whiteColor];
    noFeedbackBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(_FOUR_WIDTH_+50, 50, 18, 18) andNormalImage:[UIImage imageNamed:@"but_pitch0.png"] andSelectedImage:[UIImage imageNamed:@"but_pitch1.png"] andTouchUpTarget:self andTouchUpAction:@selector(standardNo)];
    noFeedbackBtn.selected = YES;
    UILabel *noLabel = [AKFastLabel labelWithFrame:CGRectMake(_FOUR_WIDTH_+75, 50, 18, 18) andText:@"否" andtextAlignment:UITextAlignmentCenter andFont:_QUERY_LABEL_FONT_];
    noLabel.textColor = [UIColor whiteColor];
    UILabel *feedbackLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 65+_LINE_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"  备    注 ：" andtextAlignment:UITextAlignmentLeft andFont:_QUERY_LABEL_FONT_];
    feedbackLabel2.textColor = [UIColor whiteColor];
    feedbackTextView = [AKFastTextView textViewBoundaryWithFrame:CGRectMake(_FOUR_WIDTH_+5, 90, 165, 80) andBackgroundColor:[UIColor whiteColor] andKeyboardType:UIKeyboardTypeDefault andFont:_QUERY_LABEL_FONT_-1]; 
    feedbackTextView.delegate = self;
    UIButton *feedbackBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(163, 185, 80, 30) andNormalTitle:@"反馈" andBackgroundImage:[UIImage imageNamed:@"button_60.png"] andTouchUpTarget:self andTouchUpAction:@selector(feedbackBegin)];
    [feedbackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIButton *cancelBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(30, 185, 80, 30) andNormalTitle:@"取消" andBackgroundImage:[UIImage imageNamed:@"button_60.png"] andTouchUpTarget:self andTouchUpAction:@selector(feedbackCancel)];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIView *minFeedbackView = [AKFastView viewWithWithFrame:CGRectMake(20, 20, 280, cancelBtn.frame.origin.y+cancelBtn.frame.size.height+10) andBackgroundColor:[UIColor blackColor]];
    minFeedbackView.userInteractionEnabled = YES;
    [minFeedbackView addSubview:topImage];
    [minFeedbackView addSubview:topLabel];
    [minFeedbackView addSubview:feedbackLabel1];
    [minFeedbackView addSubview:isFeedbackBtn];
    [minFeedbackView addSubview:yesLabel];
    [minFeedbackView addSubview:noFeedbackBtn];
    [minFeedbackView addSubview:noLabel];
    [minFeedbackView addSubview:feedbackLabel2];
    [minFeedbackView addSubview:feedbackTextView];
    [minFeedbackView addSubview:feedbackBtn];
    [minFeedbackView addSubview:cancelBtn];
    [feedbackView addSubview:minFeedbackView];
    [self.view addSubview:feedbackView];
    
    
}
- (void)viewDidLoad
{
    userData = [AKUserData sharedUserData];
    parameterDic = [[NSMutableDictionary alloc]init];
    currentPageStr = [[NSMutableString alloc]init];
    pagecountStr = [[NSMutableString alloc]init];
    currentRequestContent = [[AKCurrentRequest alloc]init];
    currentRequestContent.delegate = self;
    parameterCurrentRequest = [[AKParameterCurrentRequest alloc]init];
    parameterCurrentRequest.delegate = self;
    cellViewArray = [[NSMutableArray alloc]init];
    cellArray = [[NSMutableArray alloc]init];
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"商务任务" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    UIButton *rightRefreshBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalTitle:@"刷新" andBackgroundImage:[UIImage imageNamed:@"top_anniu"] andTouchUpTarget:self andTouchUpAction:@selector(refreshContent)];
    rightRefreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:rightRefreshBtn]autorelease];
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
    [self addQueryView];
    [self addFeedbackView];
    [self ransmitRequest];
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
    [cellArray release];
    [cellViewArray release];
    [pagecountStr release];
    [currentPageStr release];
    [parameterCurrentRequest release];
    [parameterDic release];
    [aTableView release];
    [super dealloc];
}
#pragma - 执行方法
-(void)standardYes
{
    isFeedbackBtn.selected = YES;
    noFeedbackBtn.selected = NO;
}
-(void)standardNo
{
    isFeedbackBtn.selected = NO;
    noFeedbackBtn.selected = YES;
}
-(void)feedbackCancel//反馈取消
{
    [self touchesBegan:nil withEvent:nil];
    isFeedbackBtn.selected = NO;
    noFeedbackBtn.selected = YES;
    feedbackTextView.text = @"";
    feedbackView.hidden = YES;
}
-(void)feedbackBegin//开始反馈
{
    [self touchesBegan:nil withEvent:nil];
    NSDictionary *dic = [cellArray objectAtIndex:feedbackIndex-100];
    NSString *idStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    NSMutableDictionary *aDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"update",@"action",idStr,@"id",feedbackTextView.text,@"intro", nil];
    if (isFeedbackBtn.selected) {
        [aDic setObject:@"1" forKey:@"isdb"];
    }else{
        [aDic setObject:@"0" forKey:@"isdb"];
    }
    [parameterCurrentRequest parameterCurrentRequestWithURL:_SWRENWU_INTERFACE_ andParameter:aDic];
    isFeedbackBtn.selected = NO;
    noFeedbackBtn.selected = YES;
    feedbackTextView.text = @"";
    feedbackView.hidden = YES;
    
}
-(void)ransmitRequest//发送请求
{
    mum.hidden = NO;
    NSDictionary *aParameterDic = [NSDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"list",@"action",@"",@"pagenum", nil];
    [parameterDic setDictionary:aParameterDic];
    [currentRequestContent currentRequestWithURL:_SWRENWU_INTERFACE_ andParameter:parameterDic];
}
-(void)ransmitRequestWithDic:(NSDictionary*)aDic//发送请求
{
    mum.hidden = NO;
    [currentRequestContent currentRequestWithURL:_SWRENWU_INTERFACE_ andParameter:parameterDic];
}

-(void)refreshContent//刷新
{
    [self ransmitRequest];
}
-(void)photographUploading:(UIButton*)sender//拍照
{
    NSDictionary *dic = [cellArray objectAtIndex:sender.tag-100];
    NSString *mnoStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mno"]];
    NSString *mnameStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mname"]];
    AKBusinessPhotoViewController *businessPhotoVC = [[AKBusinessPhotoViewController alloc]init];
    businessPhotoVC.mName = mnameStr;
    businessPhotoVC.mNo = mnoStr;
    [self.navigationController pushViewController:businessPhotoVC animated:NO];
    [businessPhotoVC release];
    
}
-(void)surveyDetails:(UIButton*)sender//详情
{
    NSDictionary *dic = [cellArray objectAtIndex:sender.tag-100];
    NSString *idStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    AKSurveyDetailsViewController *surveyDetailsVC = [[AKSurveyDetailsViewController alloc]init];
    surveyDetailsVC.surveyId = idStr;
    surveyDetailsVC.surveyURL = _SWRENWU_INTERFACE_;
    [self.navigationController pushViewController:surveyDetailsVC animated:NO];
    [surveyDetailsVC release];
}
-(void)feedback:(UIButton*)sender//反馈
{
    feedbackIndex = sender.tag;
    feedbackView.hidden = NO;
}
-(void)makeAPhoneCall:(UIButton*)sender//拨打电话
{
    NSDictionary *dic = [cellArray objectAtIndex:sender.tag-100];
    NSString *telStr = [NSString stringWithFormat:@"tel://%@",[dic objectForKey:@"mobile"]];
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:telStr];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
    [callWebview release];
}
-(void)diMethod:(UIButton*)sender//底部五个按钮的方法
{
    switch (sender.tag) {
        case 200:{
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
    queryTextField1.text = @"";
    queryTextField2.text = @"";
    queryTextField3.text = @"";
    queryTextField4.text = @"";
    queryTextField5.text = @"";
    queryTextField6.text = @"";
}
-(void)queryBegin//开始查询
{
    //    http://skyeyes.ip165.com/yyt/port/mtask.aspx?cid=008&mobile=18953553903&pwd=123&action=list&pagenum=&id=&areano=&areaname=&year=&month=&mno=&mname=&linkman=&mob=&intro=
    [self touchesBegan:nil withEvent:nil];
    [parameterDic setObject:queryTextField1.text forKey:@"areano"];
    [parameterDic setObject:queryTextField2.text forKey:@"areaname"];
    [parameterDic setObject:queryTextField3.text forKey:@"mno"];
    [parameterDic setObject:queryTextField4.text forKey:@"mname"];
    [parameterDic setObject:queryTextField5.text forKey:@"linkman"];
    [parameterDic setObject:queryTextField6.text forKey:@"mob"];
    [parameterDic setObject:@"" forKey:@"pagenum"];
    [self ransmitRequestWithDic:parameterDic];
    queryView.hidden = YES;
    queryTextField1.text = @"";
    queryTextField2.text = @"";
    queryTextField3.text = @"";
    queryTextField4.text = @"";
    queryTextField5.text = @"";
    queryTextField6.text = @"";
}
#pragma - 连接代理
//请求成功
-(void)parameterRefreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    NSString *causeStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"cause"]];
    if ([flagStr isEqualToString:@"success"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:causeStr
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        if ([causeStr isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"反馈失败！"
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
-(void)parameterRefreshFailWithParameter
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"数据连接失败"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//网络问题
-(void)parameterRefreshFailWithInternet
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"网络连接失败，请检查网络后再试！"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//请求成功
-(void)refreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    mum.hidden = YES;
//    NSLog(@"%@",aContentDic);
    //    NSLog(@"%@",[aContentDic objectForKey:@"cause"]);
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    if ([flagStr isEqualToString:@"success"]) {
        NSArray *listArray = [aContentDic objectForKey:@"mtask"];
        if (listArray.count) {
            [cellViewArray setArray:[AKFastCallView businessTaskCellViewWithArray:listArray andSharingTouchUpTarget:self andPhotoAction:@selector(photographUploading:) andDetailsAction:@selector(surveyDetails:) andFeedbackAction:@selector(feedback:) andPhoneAction:@selector(makeAPhoneCall:)]];
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [queryTextField1 resignFirstResponder];
    [queryTextField2 resignFirstResponder];
    [queryTextField3 resignFirstResponder];
    [queryTextField4 resignFirstResponder];
    [queryTextField5 resignFirstResponder];
    [queryTextField6 resignFirstResponder];
    [feedbackTextView resignFirstResponder];
    [UIView beginAnimations:@"Animations" context:nil]; //context传值
    [UIView setAnimationDuration:0.25f];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
    queryView.transform = translation;
    feedbackView.transform = translation;
    [UIView commitAnimations];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!iPhone5) {
        switch (textField.tag) {
            case 401:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -55);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 402:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -55);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 403:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -55);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 404:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -100);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 405:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -135);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 406:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -170);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
                
            default:
                break;
        }
    }else{
        switch (textField.tag) {
            case 404:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -60);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 405:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -60);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
            case 406:{
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -60);
                queryView.transform = translation;
                [UIView commitAnimations];
                break;}
                
            default:
                break;
        }
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (!iPhone5) {
        [UIView beginAnimations:@"Animations" context:nil]; //context传值
        [UIView setAnimationDuration:0.25f];
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -80);
        feedbackView.transform = translation;
        [UIView commitAnimations];
    }
}
@end
