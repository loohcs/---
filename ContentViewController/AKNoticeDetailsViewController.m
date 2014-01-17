//
//  AKNoticeDetailsViewController.m
//  农化通
//
//  Created by 凯_SKK on 13-3-14.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKNoticeDetailsViewController.h"
#import "AKInternetInterface.h"
#import "AKFastLabel.h"
#import "AKFastButton.h"
@interface AKNoticeDetailsViewController ()
-(void)ransmitRequestWithDic:(NSDictionary*)aDic;//发送请求
@end

@implementation AKNoticeDetailsViewController
@synthesize noticeId = _noticeId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
  
- (void)viewDidLoad
{
    userData = [AKUserData sharedUserData];
    currentRequestContent = [[AKCurrentRequest alloc]init];
    currentRequestContent.delegate = self;
    parameterDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"detail",@"action",_noticeId,@"id", nil];
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"公告详情" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    UIButton *rightRefreshBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalTitle:@"刷新" andBackgroundImage:[UIImage imageNamed:@"top_anniu"] andTouchUpTarget:self andTouchUpAction:@selector(refreshContent)];
    rightRefreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:rightRefreshBtn]autorelease];
    mum = [AKUploadMum uploadWhiteMumWithSite:CGPointMake(60, 80) andMunName:@"加载中..."];
    [self.view addSubview:mum];
    [self ransmitRequestWithDic:parameterDic];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_label1 release];
    [_label2 release];
    [_textView1 release];
    [_noticeId release];
    [currentRequestContent release];
    [parameterDic release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLabel1:nil];
    [self setLabel2:nil];
    [self setTextView1:nil];
    [super viewDidUnload];
}
-(void)ransmitRequestWithDic:(NSDictionary*)aDic//发送请求
{
    mum.hidden = NO;
    [currentRequestContent currentRequestWithURL:_GONGGAO_INTERFACE_ andParameter:parameterDic];
}
-(void)refreshContent//刷新
{
    [self ransmitRequestWithDic:parameterDic];
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
        NSArray *listArray = [aContentDic objectForKey:@"noticedetail"];
        if (listArray.count) {
            NSDictionary *noticeDic = [listArray lastObject];
            NSString *titleStr = [NSString stringWithFormat:@"%@",[noticeDic objectForKey:@"title"]];
            NSString *createtimeStr = [NSString stringWithFormat:@"创建时间：%@",[noticeDic objectForKey:@"createtime"]];
            NSString *contentStr = [NSString stringWithFormat:@"%@",[noticeDic objectForKey:@"content"]];
            self.label1.text = titleStr;
            self.label2.text = createtimeStr;
            self.textView1.text = contentStr;
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"没有数据！"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];
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
@end
