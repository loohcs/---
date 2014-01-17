//
//  AKDailyDetailsViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-4-8.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKDailyDetailsViewController.h"
#import "AKFastLabel.h"
#import "AKFastView.h"
#import "AKFastButton.h"
#import "AKFastTextView.h"
#import "AKFastCallView.h"
#import "AKInternetInterface.h"
#define _START_INTERVAL_ 0 //开头的间隔
#define _LINE_HEIGHT_ 19 //每行的高度
#define _LABEL_FONT_ 14//字体大小
#define _LABEL_BACK_COLOR_ [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1] //label的背景颜色
@interface AKDailyDetailsViewController ()
-(void)ransmitRequest;//发送请求
@end

@implementation AKDailyDetailsViewController
@synthesize detailsId = _detailsId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)addDetails
{
    label1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 0, 320, _LINE_HEIGHT_) andText:@"  日报标题：" andtextAlignment:UITextAlignmentLeft andFont:_LABEL_FONT_ andTextColor:[UIColor blackColor] andBackgroundColor:[UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1]];
    label2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 20, 320, _LINE_HEIGHT_) andText:@"  员工姓名：" andtextAlignment:UITextAlignmentLeft andFont:_LABEL_FONT_ andTextColor:[UIColor blackColor] andBackgroundColor:_LABEL_BACK_COLOR_];
    label3 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 40, 320, _LINE_HEIGHT_) andText:@"  上报时间：" andtextAlignment:UITextAlignmentLeft andFont:_LABEL_FONT_ andTextColor:[UIColor blackColor] andBackgroundColor:_LABEL_BACK_COLOR_];
    UIView *intervalView1 = [AKFastView viewWithWithFrame:CGRectMake(0, 19, 320, 1) andBackgroundColor:[UIColor blackColor]];
    UIView *intervalView2 = [AKFastView viewWithWithFrame:CGRectMake(0, 39, 320, 1) andBackgroundColor:[UIColor blackColor]];
    UIView *intervalView3 = [AKFastView viewWithWithFrame:CGRectMake(0, 59, 320, 1) andBackgroundColor:[UIColor blackColor]];
    textView1 = [AKFastTextView textViewNormalWithFrame:CGRectMake(0, 57, 320, 84) andBackgroundColor:[UIColor clearColor] andKeyboardType:UIKeyboardTypeDefault andFont:_LABEL_FONT_-2];
    textView1.editable = NO;
    UIView *intervalView4 = [AKFastView viewWithWithFrame:CGRectMake(0, 144, 320, 1) andBackgroundColor:[UIColor blackColor]];
    UIView *pfTopView = [AKFastView viewWithWithFrame:CGRectMake(0, 145, 320, 30) andBackgroundColor:_LABEL_BACK_COLOR_];
    CGRect myScreen=[[UIScreen mainScreen]bounds];
    UILabel *pfTopLabel = [AKFastLabel labelWithFrame:CGRectMake(20, 0, 140, 30) andText:@"[批复情况]" andtextAlignment:UITextAlignmentLeft andFont:_LABEL_FONT_+2];
    [pfTopView addSubview:pfTopLabel];
    aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 175, CGRectGetWidth(myScreen), CGRectGetHeight(myScreen)-239) style:UITableViewStylePlain];
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线的样式
    aTableView.backgroundColor = [UIColor clearColor];//透明
    aTableView.delegate = self;
    aTableView.dataSource = self;
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    [self.view addSubview:intervalView1];
    [self.view addSubview:intervalView2];
    [self.view addSubview:intervalView3];
    [self.view addSubview:intervalView4];
    [self.view addSubview:textView1];
    [self.view addSubview:pfTopView];
    [self.view addSubview:aTableView];
}
- (void)viewDidLoad
{
    userData = [AKUserData sharedUserData];
    cellViewArray = [[NSMutableArray alloc]init];
    currentRequest = [[AKCurrentRequest alloc]init];
    currentRequest.delegate = self;
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"日报详情" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    UIButton *rightRefreshBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalTitle:@"刷新" andBackgroundImage:[UIImage imageNamed:@"top_anniu"] andTouchUpTarget:self andTouchUpAction:@selector(refreshContent)];
    rightRefreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:rightRefreshBtn]autorelease];
    [self addDetails];
    mum = [AKUploadMum uploadWhiteMumWithSite:CGPointMake(60, 60) andMunName:@"加载中..."];
    [self.view addSubview:mum];
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
    [cellViewArray release];
    [_detailsId release];
    [aTableView release];
    [currentRequest release];
    [super dealloc];
}
#pragma mark - 执行方法
-(void)ransmitRequest//发送请求
{
    mum.hidden = NO;
    //    http://skyeyes.ip165.com/yyt/port/eplan.aspx?cid=101&mobile=15985745217&pwd=123456&action=reply&pagenum=&id=&employno=&employ=&title=&content=&stime=&etime=&rcontent=
    NSDictionary *aParameterDic = [NSDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"detail",@"action",_detailsId,@"id", nil];
    [currentRequest currentRequestWithURL:_YGRIBAO_INTERFACE_ andParameter:aParameterDic];
}
-(void)refreshContent//刷新
{
    [self ransmitRequest];
}
- (void)clickLeftBtn//返回
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma - 连接代理
//请求成功
-(void)refreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    mum.hidden = YES;
//    NSLog(@"%@",aContentDic);
    //    NSLog(@"%@",[aContentDic objectForKey:@"cause"]);
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    if ([flagStr isEqualToString:@"success"]) {
        NSArray *listArray1 = [aContentDic objectForKey:@"daysworkdetail"];
        NSDictionary *personalDic = [NSDictionary dictionaryWithDictionary:[listArray1 lastObject]];
        NSString *label1Str = [NSString stringWithFormat:@"  日报标题：%@",[personalDic objectForKey:@"Title"]];
        NSString *label2Str = [NSString stringWithFormat:@"  员工姓名：%@",[personalDic objectForKey:@"Employ"]];
        NSString *label3Str = [NSString stringWithFormat:@"  上报时间：%@",[personalDic objectForKey:@"Createtime"]];
        NSString *textView1Str = [NSString stringWithFormat:@"  %@",[personalDic objectForKey:@"Content"]];
        label1.text = label1Str;
        label2.text = label2Str;
        label3.text = label3Str;
        textView1.text = textView1Str;
        NSArray *listArray2 = [aContentDic objectForKey:@"daysworkreply"];
        if (listArray2.count) {
            [cellViewArray setArray:[AKFastCallView dailyDetailsCellViewWithArray:listArray2]];
            [aTableView reloadData];
            
        }else{
            [cellViewArray setArray:nil];
            [aTableView reloadData];
            
        }
        
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
@end
