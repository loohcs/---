//
//  AKSurveyDetailsViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-4-1.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKSurveyDetailsViewController.h"
#import "AKInternetInterface.h"
#import "AKFastButton.h"
#import "AKFastLabel.h"
@interface AKSurveyDetailsViewController ()
-(void)ransmitRequestWithDic:(NSDictionary*)aDic;//发送请求
@end

@implementation AKSurveyDetailsViewController
@synthesize surveyId = _surveyId;
@synthesize surveyURL = _surveyURL;
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
    self.aScrollView.contentSize = CGSizeMake(320, self.label22.frame.origin.y+self.label22.frame.size.height);
    userData = [AKUserData sharedUserData];
    currentRequestContent = [[AKCurrentRequest alloc]init];
    currentRequestContent.delegate = self;
    
    parameterDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"detail",@"action",_surveyId,@"id", nil];
    
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"调查详情" andtextAlignment:UITextAlignmentCenter andFont:18];
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
    [_label22 release];
    [_label21 release];
    [_label20 release];
    [_label19 release];
    [_label18 release];
    [_label17 release];
    [_label16 release];
    [_label15 release];
    [_label14 release];
    [_label13 release];
    [_label12 release];
    [_label11 release];
    [_label10 release];
    [_label9 release];
    [_label8 release];
    [_label1 release];
    [_label2 release];
    [_label3 release];
    [_label4 release];
    [_label5 release];
    [_label6 release];
    [_label7 release];
    [_aScrollView release];
    [_surveyId release];
    [_surveyURL release];
    [currentRequestContent release];
    [parameterDic release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLabel22:nil];
    [self setLabel21:nil];
    [self setLabel20:nil];
    [self setLabel19:nil];
    [self setLabel18:nil];
    [self setLabel17:nil];
    [self setLabel16:nil];
    [self setLabel15:nil];
    [self setLabel14:nil];
    [self setLabel13:nil];
    [self setLabel12:nil];
    [self setLabel11:nil];
    [self setLabel10:nil];
    [self setLabel9:nil];
    [self setLabel8:nil];
    [self setLabel1:nil];
    [self setLabel2:nil];
    [self setLabel3:nil];
    [self setLabel4:nil];
    [self setLabel5:nil];
    [self setLabel6:nil];
    [self setLabel7:nil];
    [self setAScrollView:nil];
    [super viewDidUnload];
}
#pragma -mark 执行方法
-(void)ransmitRequestWithDic:(NSDictionary*)aDic//发送请求
{
    mum.hidden = NO;
    [currentRequestContent currentRequestWithURL:_surveyURL andParameter:parameterDic];
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
        NSMutableArray *listArray = [NSMutableArray array];
        if ([_surveyURL isEqualToString:_SWDIAOCHA_INTERFACE_]) {
            [listArray setArray:[aContentDic objectForKey:@"mequipmentdetail"]];
        }else{
            if ([_surveyURL isEqualToString:_SWRENWU_INTERFACE_]) {
                [listArray setArray:[aContentDic objectForKey:@"mtaskdetail"]];
            }
        }
        
        if (listArray.count) {
            NSDictionary *noticeDic = [listArray lastObject];
            NSString *labelStr1 = [NSString stringWithFormat:@"药店编号：%@",[noticeDic objectForKey:@"mno"]];
            NSString *labelStr2 = [NSString stringWithFormat:@"药店名称：%@",[noticeDic objectForKey:@"mname"]];
            NSString *labelStr3 = [NSString stringWithFormat:@"地址：%@",[noticeDic objectForKey:@"address"]];
            NSString *labelStr4 = [NSString stringWithFormat:@"目标人员：%@",[noticeDic objectForKey:@"linkman"]];
            NSString *labelStr5 = [NSString stringWithFormat:@"电话：%@",[noticeDic objectForKey:@"mobile"]];
            NSString *labelStr6 = [NSString stringWithFormat:@"地垫：%@",[noticeDic objectForKey:@"f1"]];
            NSString *labelStr7 = [NSString stringWithFormat:@"花盆：%@",[noticeDic objectForKey:@"f2"]];
            NSString *labelStr8 = [NSString stringWithFormat:@"展盒：%@",[noticeDic objectForKey:@"f3"]];
            NSString *labelStr9 = [NSString stringWithFormat:@"盒托：%@",[noticeDic objectForKey:@"f4"]];
            NSString *labelStr10 = [NSString stringWithFormat:@"跳跳卡：%@",[noticeDic objectForKey:@"f5"]];
            NSString *labelStr11 = [NSString stringWithFormat:@"推拉贴：%@",[noticeDic objectForKey:@"f6"]];
            NSString *labelStr12 = [NSString stringWithFormat:@"气球：%@",[noticeDic objectForKey:@"f7"]];
            NSString *labelStr13 = [NSString stringWithFormat:@"会员卡：%@",[noticeDic objectForKey:@"f8"]];
            NSString *labelStr14 = [NSString stringWithFormat:@"灯笼：%@",[noticeDic objectForKey:@"f9"]];
            NSString *labelStr15 = [NSString stringWithFormat:@"挂件：%@",[noticeDic objectForKey:@"f10"]];
            NSString *labelStr16 = [NSString stringWithFormat:@"海报：%@",[noticeDic objectForKey:@"f11"]];
            NSString *labelStr17 = [NSString stringWithFormat:@"陈列面：%@",[noticeDic objectForKey:@"f12"]];
            NSString *labelStr18 = [NSString stringWithFormat:@"其他：%@",[noticeDic objectForKey:@"f13"]];
            NSString *labelStr19 = [NSString stringWithFormat:@"POP发布小计：%@",[noticeDic objectForKey:@"f14"]];
            NSString *labelStr20 = [NSString stringWithFormat:@"是否支持陈列费用：%@",[noticeDic objectForKey:@"f15"]];
            NSString *labelStr21 = [NSString stringWithFormat:@"陈列费用金额：%@",[noticeDic objectForKey:@"f16"]];
            NSString *labelStr22 = [NSString stringWithFormat:@"备注：%@",[noticeDic objectForKey:@"f17"]];
            self.label1.text = labelStr1;
            self.label2.text = labelStr2;
            self.label3.text = labelStr3;
            self.label4.text = labelStr4;
            self.label5.text = labelStr5;
            self.label6.text = labelStr6;
            self.label7.text = labelStr7;
            self.label8.text = labelStr8;
            self.label9.text = labelStr9;
            self.label10.text = labelStr10;
            self.label11.text = labelStr11;
            self.label12.text = labelStr12;
            self.label13.text = labelStr13;
            self.label14.text = labelStr14;
            self.label15.text = labelStr15;
            self.label16.text = labelStr16;
            self.label17.text = labelStr17;
            self.label18.text = labelStr18;
            self.label19.text = labelStr19;
            self.label20.text = labelStr20;
            self.label21.text = labelStr21;
            self.label22.text = labelStr22;
            self.label22.numberOfLines = 0;
            [self.label22 sizeToFit];
            self.aScrollView.contentSize = CGSizeMake(320, self.label22.frame.origin.y+self.label22.frame.size.height);
            
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
