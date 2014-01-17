//
//  AKLogInViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-3-27.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKLogInViewController.h"
#import "AKInternetInterface.h"
#import "AKUserData.h"
#import "AKMainInterfaceViewController.h"
//判断是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface AKLogInViewController ()
-(void)acquireUserData;//获得用户资料
@end

@implementation AKLogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewDidAppear:animated];
}
- (void)viewDidLoad
{
    [self.rememberBut setImage:[UIImage imageNamed:@"fh_yes.png"] forState:UIControlStateSelected];
    self.textField3.secureTextEntry = YES;
    logInRequest = [[AKCurrentRequest alloc]init];
    logInRequest.delegate = self;
    [self acquireUserData];
    mum = [AKUploadMum uploadMumWithSite:CGPointMake(0, 160) andMunName:@"登录中..."];
    [self.view addSubview:mum];
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
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
    [_rememberBut release];
    [logInRequest release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextField1:nil];
    [self setTextField2:nil];
    [self setTextField3:nil];
    [self setRememberBut:nil];
    [super viewDidUnload];
}
#pragma - 辅助方法
- (void)applicationWillResignActive:(UIApplication *)application
{
    [self touchesBegan:nil withEvent:nil];
}
-(void)acquireUserData//获得用户资料
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];//储存信息用的
    NSDictionary *userDic = [defaults objectForKey:@"userData"];
    if ([userDic objectForKey:@"ID"]&&[userDic objectForKey:@"account"]&&[userDic objectForKey:@"password"] )
    {
        self.textField1.text = [userDic objectForKey:@"ID"];
        self.textField2.text = [userDic objectForKey:@"account"];
        self.textField3.text = [userDic objectForKey:@"password"];
        self.rememberBut.selected = YES;
    }
}
- (void)storeUserData//储存账号资料
{
    NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:self.textField1.text,@"ID",self.textField2.text,@"account",self.textField3.text,@"password", nil];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"userData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeUserData//不记住账号时删除储存资料
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)remember:(UIButton *)sender
{
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
}
- (IBAction)logIn:(UIButton *)sender
{
    [self touchesBegan:nil withEvent:nil];
    NSMutableDictionary *requestDic = [[[NSMutableDictionary alloc]init]autorelease];
    if (self.textField1.text&&self.textField2.text&&self.textField3.text) {
        [requestDic setObject:self.textField1.text forKey:@"cid"];
        [requestDic setObject:self.textField2.text forKey:@"mobile"];
        [requestDic setObject:self.textField3.text forKey:@"pwd"];
        [logInRequest currentRequestWithURL:_LOGIN_INTERFACE_ andParameter:requestDic];
        mum.hidden = NO;
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"请输入完整的“ID号”和“账号”！"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [UIView beginAnimations:@"Animations" context:nil]; //context传值
    [UIView setAnimationDuration:0.25f];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
    self.view.transform = translation;
    [UIView commitAnimations];
}
#pragma - 代理实现
-(void)refreshSucceedWithContentDictionary:(NSDictionary *)aContentDic
{
//    NSLog(@"%@",aContentDic);
    mum.hidden = YES;
    NSString *isLeaderStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"isleader"]];
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    if ([flagStr isEqualToString:@"success"]) {
        AKUserData *userData = [AKUserData sharedUserData];
        userData.userId = self.textField1.text;
        userData.userAccount = self.textField2.text;
        userData.userPassword = self.textField3.text;
        userData.userIsLeader = isLeaderStr;
        if (self.rememberBut.selected) {
            [self storeUserData];
        }else{
            [self removeUserData];
        }
        AKMainInterfaceViewController *mainInterfaceVC = [[AKMainInterfaceViewController alloc]init];
        [self.navigationController pushViewController:mainInterfaceVC animated:NO];
        [mainInterfaceVC release];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"请输入正确的的“ID号”、“账号”和“密码”！"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}
-(void)refreshFailWithParameter//参数问题 请求失败
{
    mum.hidden = YES;
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:@"请输入正确的的“ID号”、“账号”和“密码”！"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)refreshFailWithInternet//网络问题 请求失败
{
    mum.hidden = YES;
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:@"网络连接失败，请检查网络！"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!iPhone5) {
        [UIView beginAnimations:@"Animations" context:nil]; //context传值
        [UIView setAnimationDuration:0.25f];
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -124);
        self.view.transform = translation;
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:@"Animations" context:nil]; //context传值
        [UIView setAnimationDuration:0.25f];
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -20);
        self.view.transform = translation;
        [UIView commitAnimations];
    }
    
}
@end
