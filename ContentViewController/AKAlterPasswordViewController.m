//
//  AKAlterPasswordViewController.m
//  农化通
//
//  Created by 凯_SKK on 13-3-7.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKAlterPasswordViewController.h"
#import "AKInternetInterface.h"
#import "AKFastButton.h"
#import "AKFastLabel.h"
@interface AKAlterPasswordViewController ()
-(void)showAlertWithTitle:(NSString*)aTitle message:(NSString*)aMessage cancelTitle:(NSString*)aCancelTitle;
@end

@implementation AKAlterPasswordViewController

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
    self.textField1.secureTextEntry = YES;
    self.textField2.secureTextEntry = YES;
    self.textField3.secureTextEntry = YES;
    currentRequestContent = [[AKCurrentRequest alloc]init];
    currentRequestContent.delegate = self;
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"修改密码" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    UIButton *rightRefreshBtn = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalTitle:@"更新" andBackgroundImage:[UIImage imageNamed:@"top_anniu"] andTouchUpTarget:self andTouchUpAction:@selector(refreshContent)];
    rightRefreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:rightRefreshBtn]autorelease];
    mum = [AKUploadMum uploadWhiteMumWithSite:CGPointMake(60, 80) andMunName:@"更新中..."];
    [self.view addSubview:mum];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textField1 release];
    [_textField2 release];
    [_textField3 release];
    [currentRequestContent release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextField1:nil];
    [self setTextField2:nil];
    [self setTextField3:nil];
    [super viewDidUnload];
}
#pragma - 执行方法
- (void)clickLeftBtn//返回
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)refreshContent//更新
{
    NSDictionary *mimaDic = [NSDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",self.textField1.text,@"oldpwd",self.textField2.text,@"newpwd",self.textField3.text,@"rnewpwd", nil];
    [currentRequestContent currentRequestWithURL:_MIMA_INTERFACE_ andParameter:mimaDic];
}
-(void)showAlertWithTitle:(NSString*)aTitle message:(NSString*)aMessage cancelTitle:(NSString*)aCancelTitle
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:aTitle
                                                   message:aMessage
                                                  delegate:self
                                         cancelButtonTitle:aCancelTitle
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
#pragma - 连接代理
//请求成功
-(void)refreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    mum.hidden = YES;
//    NSLog(@"%@",aContentDic);
    //    NSLog(@"%@",[aContentDic objectForKey:@"cause"]);
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    NSString *causeStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"cause"]];
    if ([flagStr isEqualToString:@"success"]) {
        userData.userPassword = self.textField2.text;
        self.textField1.text = @"";
        self.textField2.text = @"";
        self.textField3.text = @"";
    }
    [self showAlertWithTitle:@"提示" message:causeStr cancelTitle:@"确定"];
}
//解析数据失败
-(void)refreshFailWithParameter
{
    mum.hidden = YES;
    [self showAlertWithTitle:@"提示" message:@"更新失败！" cancelTitle:@"确定"];
}
//网络问题
-(void)refreshFailWithInternet
{
    mum.hidden = YES;
    [self showAlertWithTitle:@"提示" message:@"网络连接失败，请检查网络后再试！" cancelTitle:@"确定"];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
}
@end
